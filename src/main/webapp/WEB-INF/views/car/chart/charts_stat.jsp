<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import = "java.util.Enumeration"%>
<!-- 제이쿼리 호출/ statMain에서 불러온 jquery와 충돌이 발생하여 주석처리
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
-->
<!-- chart.js option에서 time사용하려면 Chart.min.js가 아닌 Chart.bundle.js 사용해야함-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>

<html>
<head>
<title>EngineRpm</title>
</head>
<body>
	<div class="chartBox" style="width: 1200px; height: 600px; margin-left:30px;border:1px solid black;">
	    <form name="input" method = "POST" >
	            <div style="width: 1000px; height: 500px;margin:30px;float:right"><canvas id="statChart"></canvas></div>
	            <div style="width: 80px; height:100px;margin-top:200px;margin-left:20px;border:1px solid black;font-size:0.8em; padding-left:10px" align="left">
	              시간단위 설정<br><br>
	              <!-- 시간단위가 선택되면 timeFrame 함수 실행 , 일단위로 default 체크되어 있음 -->
	            <label><input type="radio" name="timeUnit" value="YEAR" onclick="timeFrame(this)">년</label><br>
	            <label><input type="radio" name="timeUnit" value="MONTH" onclick="timeFrame(this)">월</label><br>
	            <label><input type="radio" name="timeUnit" value="DATE" onclick="timeFrame(this)" checked>일</label><br>
	            </div>
	    </form>
	</div>
<%
	/*
	//String route = request.getParameter("selectBox");
	String[] sels = request.getParameterValues("select");
	System.out.println("test");
	System.out.println(sels);
	String sel = "";
	if (sels != null){
	    for(int i = 0;i < sels.length;i++)
	        sel += sels[i] + " ";
	}
	*/
%>
</body>
</html>
<script type="text/javascript">
		$(document).ready(function(){
			getGraph()
		})
		let rpmTimeList = [];
		let rpmList = [];
		function getGraph(){
			$.ajax({
				url:location.href.split('/')[0]+"/gsonList",
				type:"get",
				dataType:"json",
				contentType:"application/json;cahrset=utf-8",
				//data: {time:87209,fuelLevel:78}
				success:function(data){
					for (let i = 0; i<data.length;i++){
						rpmTimeList.push(data[i].insDte);
						rpmList.push(data[i].rpm);
					}
					console.log("ajax-rpmlList")
				},
				error:function(request,status,error,data){
					alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
				}
			})//ajax
		}//getGraph

		$(document).ready(function(){
			getGraph2()
		})
		let fuelTimeList = [];
		let fuelList = [];			
		function getGraph2(){
			$.ajax({
				url:location.href.split('/')[0]+"/fuelList",
				type:"get",
				dataType:"json",
				contentType:"application/json;cahrset=utf-8",
				//data: {time:87209,fuelLevel:78}
				success:function(data){
					for (let i = 0; i<data.length;i++){
						fuelTimeList.push(data[i].time);
						fuelList.push(data[i].Fuel);
					}
					console.log("ajax-fuelTimeList")
				},
				error:function(request,status,error,data){
					alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
				}
			})//ajax
		}//getGraph
		$(document).ready(function(){
			getGraph3()
		})
		let speedTimeList = [];
		let speedList = [];	
		function getGraph3(){
			$.ajax({
				url:location.href.split('/')[0]+"/speedList",
				type:"get",
				dataType:"json",
				contentType:"application/json;cahrset=utf-8",
				//data: {time:87209,fuelLevel:78}
				success:function(data){
					for (let i = 0; i<data.length;i++){
						speedTimeList.push(data[i].insDte);
						speedList.push(data[i].speed);
					}
					console.log("ajax - speedList")
				},
				error:function(request,status,error,data){
					alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
				}
			})//ajax
		}//getGraph
</script>
<script type="text/javascript">
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
		let column;
		function selectChart(col){
			columnValue = col.value;
			statChart.data.labels=[];
			statChart.data.datasets[0].data = [];
			statChart.update();
		}
		//시간 단위 선택하면 실행 되는 함수
		function timeFrame(period){
			let periodValue = period.value;
			let timeList = [];
			let valueList = [];
			//console.log(carSelected)
			$.ajax({
				type:"post",
				url:"/stat/time",
				async: false,
				data: {period : periodValue, column : columnValue, carNum: carSelected},
				success: function(data){
					for (let i = 0; i<data.length;i++){
						timeList.push(data[i].date);
						valueList.push(data[i].value);
					}
					statChart.data.labels=timeList;
					statChart.data.datasets[0].data = valueList;
					console.log(valueList);
					statChart.options.scales.x.time.unit = periodValue;
					statChart.update();
				}, error:function(request,status,error){
					alert("error:"+request.status);
				}

			})
		}	     
</script>