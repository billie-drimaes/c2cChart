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
<title>FuelLevel</title>
    	
</head>
</html>
<script type="text/javascript">
/*
if(graphChart_f!==undefined){
	graphChart_f.destroy()
}
 */

var chartName = "Mileage";
const milechart = new Chart(document.getElementById('milechart'),{
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
//main.jsp에서 changeTrip() onchange함수에서 호출 됨
function getMileChart(){
	let mileTimeList = [];
	let mileValueList = [];
	console.log(carSelected,selectedTrip)
	//console.log(carSelected)
	$.ajax({
		type:"post",
		url:"/car/milechart",
		async: false,
		data: {tripId: selectedTrip, carNum: carSelected },
		success: function(data){
			for (let i = 0; i<data.length;i++){
				mileTimeList.push(data[i].time);
				mileValueList.push(data[i].value);
			}
			milechart.data.labels=mileTimeList;
			milechart.data.datasets[0].data = mileValueList;
			console.log("getFuelChartData");
			milechart.update();
		}, error:function(request,status,error){
			alert("error:"+request.status);
		}
	})
}
</script>