<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량 통계</title>
<!-- 달력(datepicker)사용을 위한 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- chart.js option에서 time사용하려면 Chart.min.js가 아닌 Chart.bundle.js 사용해야함-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>

	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
</head>
<style>
div
{
	/* border:1px solid red; */ 
	padding: 0px 10px 10px 0px; 
	
} 
</style>
<body>
	<div style="float:left; width:98%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
	       <div style="margin-left:30px;">
	         시간 단위 조회: &nbsp;&nbsp;
	       <label><input type="radio" name="timeUnit" value="MONTH" onclick="dateUnit(this)">월&nbsp;&nbsp;&nbsp;</label>
	       <label><input type="radio" name="timeUnit" value="DATE" onclick="dateUnit(this)">일</label><br>
	       </div>
		</div>
		<!-- 네번째 라인 -->
		<div align="left" >
			<!-- 달력 삽입-->
			<div align="left" style="width:98%; margin-left:30px;">
				조회기간: 
				FROM
				<!-- <input name="from" autocomplete="off" readonly="readonly">  -->
				<input type="text" id="datePicker_from" style="width:295px;" autocomplete="off">
				&nbsp;TO
				<input type="text" id="datePicker_to" style="width:295px;" autocomplete="off">
			</div>
		</div>
		<!-- 다섯번째 라인: 항목 선택 -->
		<div align="left">
			<div style="margin-left:30px;float:left;">통계:&emsp;&nbsp;</div>
		 	<div style="width:800px; height:20px;margin-top:20px; margin-left:40px;">        		
	           <input type="radio" name="chart_choice" value="tripCount" onclick="selectChart(this)" >총 운행수(Trip)&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="totalDIstance" onclick="selectChart(this)" >총 운행량(km)&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="totalFuel" onclick="selectChart(this)" >총 연료 사용량(L)&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="avgMileage" onclick="selectChart(this)" >평균 연비(km/L)      
           </div>
       </div>
       	<!-- 여섯번째 라인: 조회 버튼 -->
    	<div align="left">
  			<div align="center" style="width:1000px; margin-left:30px; margin-top:30px;">
				<button style="width:40%;" onclick="setComplete()">조회</button>
			</div>
		</div>
       	<!-- 일곱번째 라인: 차트삽입-->
		<div align="left">
			<!-- Chart -->
			<div style="width: 1000px; height: 500px;margin:30px;"><canvas id="statChart"></canvas></div>
		</div>
	</div>
</body>
<script type="text/javascript">
let dateUnitSelected;
let column;
let startDate;
let endDate;

//월 형식(yyyy/mm) 맞추기 위한 함수 생성
function monthFormat(month){
	var month_plus;
	var mm;
	month_plus = ++month;
	console.log("month_plus",month_plus)
	if (month_plus<10){
		mm = '0'+month_plus;
	}else{
		mm = month_plus;
	}
	return mm
}
//datepicker 삽입 function, 위의 라디오박스에서 월/일 선택결과에 따라 달력이 달라짐
function dateUnit(unit) {
	dateUnitSelected = unit.value;
	$('#datePicker_from, #datePicker_to').datepicker('setDate', "");
	$("#datePicker_from, #datePicker_to").datepicker("destroy");
	if (dateUnitSelected=='MONTH'){//연과 월만 선택하도록 달력 생성
		  $("#datePicker_from").datepicker({
		        format: 'mm-yyyy',
		        changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        onClose: function(dateText, inst) {
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
		            startDate = year+"/"+ monthFormat(month);
		        }
		    });
		  	$("#datePicker_to").datepicker({
		        format: 'mm-yyyy',
		        changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        onClose: function(dateText, inst) {
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
		            endDate = year+"/"+ monthFormat(month)
		        }
		     });
		    $("#datePicker_from, #datePicker_to").focus(function () {
		        $(".ui-datepicker-calendar").hide();
		     });
		    //console.log(month, day)
	}else{//년월일 모두 선택하도록 달력생성
		$("#datePicker_from, #datePicker_to").datepicker({
			 dateFormat: 'yy-mm-dd',
	        changeMonth: true,
	        changeYear: true
	        //showButtonPanel: true,
	    });
	    $("#datePicker_from, #datePicker_to").focus(function () {
	        $(".ui-datepicker-calendar").show();
	    });
	    $('#datePicker_from').change(function (){
	    	startDate = $('#datePicker_from').val();
	    });
	    $('#datePicker_to').change(function (){
	    	endDate = $('#datePicker_to').val();
	    });
	}
	}
	
//차트항목 선택
function selectChart(col){
	columnValue = col.value;
	/*
	statChart.data.labels=[];
	statChart.data.datasets[0].data = [];
	statChart.update(); */
}
let labelData =[];
let featureData = [];
const statChart = new Chart(document.getElementById('statChart'),{
	type:"bar",
	options:{
		legend:{
			display:false
		},
	      scales: {
	   	   x: {
	   		   type: 'time',
	   		   time: {
	   			   unit: 'day'
	   		   }}
	      }
		},
	data:{
		labels:labelData,
		datasets: [{
			data: featureData,
			borderColor:"#3e95cd",
			fill: false
		}]
	}});
//시간 단위 선택하면 실행 되는 함수
function setComplete(){
	let timeList = [];
	let valueList = [];
	console.log(dateUnitSelected,startDate,endDate,columnValue)
	//console.log(carSelected)
	$.ajax({
		type:"post",
		url:"/stat/carsStat",
		async: false,
		data: {dateUnit: dateUnitSelected, column: columnValue,startDate:startDate, endDate: endDate },
		success: function(data){
			for (let i = 0; i<data.length;i++){
				timeList.push(data[i].date);
				valueList.push(data[i].value);
			}
			statChart.data.labels=timeList;
			statChart.data.datasets[0].data = valueList;
			console.log(valueList);
			statChart.options.scales.x.time.unit = dateUnitSelected;
			statChart.update();
		}, error:function(request,status,error){
			alert("error:"+request.status);
		}
	})
}
</script>
</html> 