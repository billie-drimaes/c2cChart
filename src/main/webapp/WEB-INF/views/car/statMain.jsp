<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개별차량 통계</title>
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
			<!-- DB의 carInfo 테이블에서 차량번호를 가져와 선택하도록 함 / infoMapper-->
			<select id="carNum" name="selectBox" style="width:400px; height:30px; margin-left:30px;" onchange="selectCar()">
   		  		<option>차량번호 선택</option>
      			<c:forEach var="info" items="${carList}" varStatus="i">
         			<option value="${info.carNo}">${info.carNo}</option>
      			</c:forEach>
         </select>
		</div>
		<!-- 두번째 라인 -->
		<div align="left" >
			<div style="margin-left:30px;">차량번호: <label id="carNumShow"></label>
			</div>
		</div>
		<!-- 세번째 라인 -->
		<div align="left" >
	       <div style="margin-left:30px;">
	         시간 단위 조회&nbsp;&nbsp;
	       <label><input type="radio" name="timeUnit" value="MONTH" onclick="dateUnit(this)">월&nbsp;&nbsp;&nbsp;</label>
	       <label><input type="radio" name="timeUnit" value="DATE" onclick="dateUnit(this)">일</label><br>
	       </div>
		</div>
		<!-- 네번째 라인 -->
		<div align="left" >
			<!-- 달력 삽입-->
			<div align="left" style="width:98%; margin-left:30px;">
				FROM
				<!-- <input name="from" autocomplete="off" readonly="readonly">  -->
				<input type="text" id="datePicker_from" style="width:295px;" autocomplete="off">
				&nbsp;TO
				<input type="text" id="datePicker_to" style="width:295px;" autocomplete="off">
			</div>
		</div>
		<!-- 다섯번째 라인: 항목 선택 -->
		<div align="left">
			<div style="margin-left:30px;float:left;">통계: </div>
		 	<div style="width:800px; height:20px;margin-top:20px; margin-left:40px;">        		
	           <input type="radio" name="chart_choice" value="speed" onclick="selectChart(this)" >평균속도&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="mileage" onclick="selectChart(this)" >평균연비&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="distance" onclick="selectChart(this)" >전체+트립 별 이동거리&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="tripValue" onclick="selectChart(this)" >트립 별 평균속도/평균연비/공회전 시간<br>
	           <input type="radio" name="chart_choice" value="idling" onclick="selectChart(this)" >총 전체+트립 별 공회전시간&emsp;&emsp;
	           <input type="radio" name="chart_choice" value="acceleration" onclick="selectChart(this)" >급가속+급감속+엔진실화&emsp;&emsp;              
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
let carSelected;
let dateUnitSelected;
let column;
let startDate;
let endDate;

function selectCar(){
	carSelected = $('#carNum').val();
	//선택된 차량이 드롭다운 아래 출력되도록함.
	document.getElementById("carNumShow").innerHTML = carSelected;

	console.log("선택된 차량 : " + carSelected);
	//console.log("선택된 날짜 : " + insDte);
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
		            startDate = year+"/"+(++month)
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
		            endDate = year+"/"+(++month)
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
	type:"line",
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
	console.log(carSelected,dateUnitSelected,startDate,endDate,columnValue)
	//console.log(carSelected)
	$.ajax({
		type:"post",
		url:"/stat/carStat",
		async: false,
		data: {dateUnit: dateUnitSelected, column: columnValue, carNum: carSelected, startDate:startDate, endDate: endDate },
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