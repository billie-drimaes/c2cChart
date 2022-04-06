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
    <!-- <div style="width: 500px; height: 300px;margin-left:600;margin-top:100;"><canvas id="doughnut-chart"></canvas></div> -->           
</body>
</html>
<script type="text/javascript">
			$(document).ready(function(){
				getGraph_dou()
			})
			let fuelTimeList = [];
			let fuelList = [];
			let fuel_num = 0;
			function getGraph_dou(){
				$.ajax({
					url: location.href.split('/')[0] + "/fuelList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						var lastdata = data[data.length-1]
						fuel_num = lastdata.Fuel
						var fuel_time = lastdata.time
						console.log("fuelLevel_time"+fuel_time)
						var data = { 
								labels: [ 
									"Fuel Level" 
								], 
								datasets: [ 
									{ 
										data: [fuel_num, 100-fuel_num], 
										backgroundColor: [ 
											"#FF6384" 
										], 
										hoverBackgroundColor: [ 
											"#FF6384" 
										] 
									}] 
						};

					    var dougnutChart = new Chart(document.getElementById("doughnut-chart"), {
					        type: 'doughnut',
					        data: data,
					        options: {
					          title: {
					            display: true,
					            text: 'Fuel Level'
					          	},
					          	legend: {
					          		display: false
					          	},
					          	elements: { 
					          		center: { 
					          			text: Math.round(fuel_num), 
					          			fontStyle: 'Helvetica', //Default Arial 
					          			sidePadding: 15 //Default 20 (as a percentage) 
					          		} 
					          	},
						        animation:false, 
						        rotation: 1 * Math.PI, 
						        circumference: 1 * Math.PI		        
						        }
					    });
						
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
			Chart.plugins.register({ 
				beforeDraw: function (chart) { 
					if (chart.config.options.elements.center) { 
						//Get ctx from string 
						var ctx = chart.chart.ctx; 
						
						//Get options from the center object in options 
						var centerConfig = chart.config.options.elements.center; 
						var fontSize = centerConfig.fontSize || '50'; 
						var fontStyle = centerConfig.fontStyle || 'Arial'; 
						var txt = centerConfig.text; 
						var color = centerConfig.color || '#000'; 
						var sidePadding = centerConfig.sidePadding || 20; 
						var sidePaddingCalculated = (sidePadding/100) * (chart.innerRadius * 2) 
						//Start with a base font of 30px 
						ctx.font = fontSize + "px " + fontStyle; 
						
						//Get the width of the string and also the width of the element minus 10 to give it 5px side padding 
						var stringWidth = ctx.measureText(txt).width; 
						var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated; 
						
						// Find out how much the font can grow in width. 
						var widthRatio = elementWidth / stringWidth; 
						var newFontSize = Math.floor(30 * widthRatio); 
						var elementHeight = (chart.innerRadius * 0.7); 
						
						// Pick a new font size so it will not be larger than the height of label. 
						var fontSizeToUse = Math.min(newFontSize, elementHeight); 
						
						//Set font settings to draw it correctly. 
						ctx.textAlign = 'center'; 
						ctx.textBaseline = 'middle'; 
						var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2); 
						var centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 2); 
						
						//반도넛일 경우 
						if (chart.config.options.rotation === Math.PI && chart.config.options.circumference === Math.PI) { 
							centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 1.3); 
							} 
						ctx.font = fontSizeToUse+"px " + fontStyle; 
						ctx.fillStyle = color; 
						
						//Draw text in center 
						ctx.fillText(txt, centerX, centerY); 
						} 
					} 
			});
		    setInterval(function(){
		    	getGraph_dou();
		    	console.log("doughnutUpate");
		    },3000); //3000ms: 3초간격

</script>