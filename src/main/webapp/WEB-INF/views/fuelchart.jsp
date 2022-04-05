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
<body>
      <div style="width: 600px; height: 250px; position: absolute; top:-30%,;"><canvas id="fuelchart"></canvas></div>
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
			var graphChart_f;
			$(document).ready(function(){
				getGraph_f()
			})
			let objArray_f = [];
			function arrayToList(arr) {
				labelData_uniq_f=[];
				featureData_uniq_f=[];
				for (let i = 0; i<arr.length;i++){
					labelData_uniq_f.push(arr[i].time);
					featureData_uniq_f.push(arr[i].value);
				}
			}
			//깊은복사를 위한 재귀함수 정의
			function cloneObject(obj) {
				  var clone = {};
				  for (var key in obj) {
				    if (typeof obj[key] == "object" && obj[key] != null) {
				      clone[key] = cloneObject(obj[key]);
				    } else {
				      clone[key] = obj[key];
				    }
				  }
				  return clone;
				}
			function getGraph_f(){
				$.ajax({
					url:"http://52.78.209.55:8080/springTest/fuelList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						var data_slice = data.slice(-100);
						for (let i = 0; i<data_slice.length;i++){
		        			var data_obj = {};
							data_obj.time = data_slice[i].time;
							data_obj.value = data_slice[i].Fuel;
							objArray_f.push(data_obj);
						}
		        		objArray_f = _.uniqBy(objArray_f,"time");
						var labelData_uniq_f = [];
						var featureData_uniq_f = [];
						for (let i = 0; i<objArray_f.length;i++){
							labelData_uniq_f.push(objArray_f[i].time);
							featureData_uniq_f.push(objArray_f[i].value);
						}
			        	labelData= labelData_uniq_f;
			        	featureData= featureData_uniq_f;
			        	console.log("fuelLength"+featureData_uniq_f.length)
				       chartName="fuelLevel"
				       
				        var context = document.getElementById('fuelchart');

				        if(graphChart_f!==undefined){
				        	graphChart_f.destroy()
				        }
				        graphChart_f = new Chart(context,{
							type:"line",
							options:{
								title:{
									display: true,
									text:chartName
								},
								legend:{
									display:false
								},
						       animation:false

							},
							data:{
								labels:labelData,
								datasets: [{
									data: featureData,
									//label: "fuelLevel",
									borderColor:"#3e95cd",
									fill: false
								}]
							}
						});
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
		    setInterval(function(){
		    	getGraph_f();
		    	console.log("fuel_timeSetupdate");
		    },3000); //3000ms: 3초간격
</script>