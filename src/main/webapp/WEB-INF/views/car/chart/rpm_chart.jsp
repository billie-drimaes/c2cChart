<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import = "java.util.Enumeration"%>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
<!-- chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>

<html>
<head>
<title>EngineRpm</title>
</head>
<body>
      <!-- <div style="width: 600px; height: 250px;float: right;"><canvas id="rpmChart"></canvas></div> -->
</body>
</html>
<script type="text/javascript">

console.log("carSelected:"+carSelected);
console.log("selectedTrip:"+selectedTrip);

var chartName = "RPM";
const rpmChart = new Chart(document.getElementById('rpmChart'),{
	type:"line",
	options:{
		title:{
			display: true,
			text:chartName
		},
		legend:{
			display:false
		},
       animation:false,
       maintainAspectRatio:false
	},
	data:{
		labels:[],
		datasets: [{
			data:[],
			borderColor:"#3e95cd",
			fill: false
		}]
	}});
//시간 단위 선택하면 실행 되는 함수
function getRpmChart(){
	let rpmTimeList = [];
	let rpmValueList = [];
	console.log(carSelected,selectedTrip)
	//console.log(carSelected)
	$.ajax({
		type:"post",
		url:"/car/rpmchart",
		async: false,
		data: {tripId: selectedTrip, carNum: carSelected },
		success: function(data){
			for (let i = 0; i<data.length;i++){
				rpmTimeList.push(data[i].time);
				rpmValueList.push(data[i].value);
			}
			rpmChart.data.labels=rpmTimeList;
			rpmChart.data.datasets[0].data = rpmValueList;
			console.log("getRpmChartData");
			rpmChart.update();
		}, error:function(request,status,error){
			alert("error:"+request.status);
		}
	})
}
</script>