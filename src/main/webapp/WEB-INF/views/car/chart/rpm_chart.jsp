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
			var graphChart;
			$(document).ready(function(){
				getGraph()
			})
			let objArray = [];
			var labelData_uniq;
			var featureData_uniq;
			function arrayToList(arr) {
				labelData_uniq=[];
				featureData_uniq=[];
				for (let i = 0; i<arr.length;i++){
					labelData_uniq.push(arr[i].time);
					featureData_uniq.push(arr[i].value);
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
			function getGraph(){
				$.ajax({
					url:location.href.split('/')[0] + "/rpmList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						//var data_slice = data.slice(-100);
						var data_slice = data;
						for (let i = 0; i<data_slice.length;i++){
		        			var data_obj = {};
							data_obj.time = data_slice[i].time;
							data_obj.value = data_slice[i].rpm;
							objArray.push(data_obj);
						}
		        		objArray = _.uniqBy(objArray,"time");
		       		arrayToList(objArray);
			        	labelData= labelData_uniq;
			        	featureData= featureData_uniq;
			        	console.log("rpmLength"+featureData.length)
				       chartName="Engine RPM"
				       
				        labelData_ms = cloneObject(labelData); //깊은복사
				        var context = document.getElementById('rpmChart');

				        if(graphChart!==undefined){
				        	graphChart.destroy()
				        }
				        graphChart = new Chart(context,{
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
		    	getGraph();
		    	console.log("timeSetupdate");
		    },3000); //3000ms: 3초간격
</script>