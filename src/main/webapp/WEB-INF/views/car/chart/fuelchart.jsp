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

var chartName = "FuelLevel";
const fuelBar = new Chart(document.getElementById('fuelBar'),{
	type:"horizontalBar",
	options:{
		legend:{
			display:false
		},
       animation:false,
       scales:{
    	   xAxes : [{
    		   stacked: true,//누적막대 그래프
    		   display: false //그리드 선 제거
    	   }],
    	   yAxes : [{
    		   stacked: true,//누적막대 그래프
    		   display: false //그리드 선 제거
    	   }]
       },
       maintainAspectRatio:false,
       tooltips: {
           enabled: false
        }
	},
	data:{
		labels:[],
		datasets: [
			{
				label:'FuelLevel',
				data:[79],
				backgroundColor:'rgb(255, 205, 86)'
			},
			{
				label:'',
				data:[21],
				backgroundColor:'#BDBDBD'
			}
		]
	}});
//main.jsp에서 changeTrip() onchange함수에서 호출 됨
function getFuelBarChart(){
	console.log(carSelected,selectedTrip)
	//console.log(carSelected)
	$.ajax({
		type:"post",
		url:"/car/fuelBar",
		async: false,
		data: {tripId: selectedTrip, carNum: carSelected },
		success: function(data){
			if(data[0]!==undefined){
			var fuelTime = data[0].time;
			var fuelValue= data[0].value;
			}
			console.log("fuelValue:"+fuelValue)
			fuelBar.data.datasets[0].label='fuelvalue';
			fuelBar.data.datasets[0].data =[fuelValue];
			fuelBar.data.datasets[1].data =[100-fuelValue];
			fuelBar.update();
			$('#voFuelLevel').text(fuelValue);
		}, error:function(request,status,error){
			alert("error:"+request.status);
		}
	})
}

setInterval(function(){
	getFuelBarChart();
	console.log("fuelBarupdate");
},3000); //3000ms: 3초간격

</script>