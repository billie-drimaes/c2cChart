<%@page import="com.bill.vo.CarLogVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량</title>
	
	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<!-- 
		mqtt subscribe 소스를 가져온다.
		main.jsp 파일이 open 되면 subscribe가 실행된다. 
	 -->
	<jsp:include page="../mqtt/mqtt.jsp"/>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<style>
/* 슬래시 모양 css 가져옴 */
.slash {
  background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
}
.backslash {
  background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="100%" y2="100%" stroke="gray" /></svg>');
}
.slash, .backslash { text-align: left; }
.slash div, .backslash div { text-align: right; }

/* 테이블은 div 크기만큼 늘려준다 */
table{width:100%; height:100%}

/* div는 오른쪽, 아래쪽에 여백을 둔다 */
/* .container div 
{
	width:24.5%;
	height:210px;
} */
div
{
	/* border:1px solid red; */ 
	padding: 0px 10px 10px 0px; 
	
} 
span
{
	font-weight: border;
}
</style>
<%

	Object carList = request.getAttribute("selectCar");
	pageContext.setAttribute("carList", carList);

	Object tripList = request.getAttribute("selectTrip");
	pageContext.setAttribute("tripList", tripList);
	
	
%>
<body>
	<!-- 첫번째 라인 -->
	<div style="float:left; width:98%; margin:1%;">
		<div align="left" >
			<input type="date" id="insDte" style="width:295px;" onchange="changeDate()">
		</div>
		<!-- 첫번째 라인 -->
		<div align="left" >
			<div style="float:left;">
				<select id="carId" style="width:300px; height:30px" onchange="changeCar()">
					<option selected="selected">차량을 선택해주세요.</option>
					<c:forEach var="i" items="${carList}">
						<option value="${i.carNo }">${i.carNo }</option>
					</c:forEach>
				</select>
			</div>
			<div  style="float:left; width:100px"></div>
			<div style="float:left;">
				Trip ID : &nbsp;&nbsp;
				<select id="tripId" name="tripName" style="width:300px; height:30px" onchange="changeTrip()">
					<option selected="selected">Trip을 선택해주세요.</option>
				</select>
			</div>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width:810px; height:210px; padding: 0px 10px 10px 0px;">
				<table style="float:left; ">
					<tr>
						<th style="width:100px">Trip ID</th>
						<td style="width:260px"><span id="voTripId"></span></td>
						<th style="width:100px">날짜</th>
						<td><span id="voInsDte"></span></td>
					</tr>
					<tr>
						<th>사용자 ID</th>
						<td><span id="voUserId"></span></td>
						<th>주행 거리</th>
						<td><span id="voDrvDistance"></span></td>
					</tr>
					<tr>
						<th>차량번호</th>
						<td><span id="voCarNo"></span></td>
						<th>운행시간</th>
						<td><span id="voDrvTime"></span></td>
					</tr>
				</table>
			</div>
			
			<div align="left" style="float:left; width:400px; height:210px; ">
				<table>
					<tr>
						<td style="text-align:center;">
							FuelLevel<br><br>
							<span id="voFuelLevel" style="float:left; font-size:1.5em;color:rgb(255, 205, 86);font-weight:bold;"></span>
							<div style="width:370px; height:80px;"><canvas id=fuelBar></canvas></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="container" align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							배터리 전압(V)
							<br>
							<span id="batteryVolt"></span> 
							<div>
								<span id="batteryTemp"></span>
								<br>
								배터리 온도(℃)
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 세번째 라인 -->
		<div align="left" style="float:left; width:100%;" > 
			<div  class="container" align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							냉각수 온도(℃)
							<br>
							<span id="coolantTemp"></span> 
							<div>
								<span id="Temperature"></span>
								<br>
								외부 온도(℃)
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<div align="left" style="width:100%">
					<button style="width:49%; float:left" onclick="location.href='log'">Log</button>
					&nbsp;
					<button style="width:49%; float:right">Report</button>
				</div>
				<div style="padding:0px 0px 0px 0px; width:400px; height:100%;">
					<table style="float:left; width:100%; height:176px;">
						<tr>
							<td>
								공회전 시간
								<br>
								<span id="idling"></span> 
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							속도(km)
							<br>
							<span id="Speed"></span> 
							<div>
								<span id="RPM"></span>
								<br>
								RPM
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							토크(kgf.m)
							<br>
							<span id="torque"></span> 
							<div>
								<span id="horsePower"></span>
								<br>
								마력(PS)
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 네번째 라인 -->
		<div align="left" style="float:left; " > 
			<div align="left" style="float:left; width:810px; height:300px;">
				<table>
					<tr>
						<td>
							map
							<br>
							<span id="gps"></span>
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:810px; height:300px;">
				<div style="float:left; width:100%; height:145px; ">
					<table>
						<tr>
							<td >
								<canvas id=milechart></canvas>
							</td>
						</tr>
					</table>
				</div>
				<div style="float:left; width:100%; height:145px; ">
					<table>
						<tr>
							<td >
								<canvas id=rpmChart></canvas>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
let carSelected;
let selectedTrip;
function changeCar(){
	carSelected = $('#carId').val();
	var insDte = $('#insDte').val();
	console.log("선택된 차량 : " + carSelected);
	console.log("선택된 날짜 : " + insDte);
	var $target = $("select[name='tripName']");
	var $option = $("select[name='tripName'] option");
	$.ajax({
		type: 'post', 
		url: "/car/post", 
		async: false, 
		data: {
			carNo : carSelected,
			insDte : insDte
		}, // 서버로 보낼 데이터 
		success: function(data) {
			$option.remove();
			$target.append("<option value=''>Trip을 선택해주세요.</option>");
			
			if(data.length == 0) {
			} else {
				$(data).each(function(i){
					$target.append("<option value="+data[i].tripId+">"+data[i].tripId+"</option>");
				})
			}
			changeTrip();
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}
function changeTrip(){
	selectedTrip = document.getElementById("tripId").value;
	var insDte = $('#insDte').val();
	console.log("선택된 Trip ID : " + selectedTrip);
	console.log("선택된 날짜 : " + $('#insDte').val() + '/' + insDte);
	$.ajax({
		type: 'post', 
		url: "/car/json", 
		async: false, 
		data: {
					carNum : carSelected,
					tripId : selectedTrip, 
					insDte : insDte
		}, // 서버로 보낼 데이터 
		success: function(data) {
			if(data.length == 0) {
				$('#voTripId').empty();
				$('#voInsDte').empty();
				$('#voCarNo').empty();
				$('#voUserId').empty();
				$('#voDrvDistance').empty();
				$('#voDrvTime').empty();
				$('#voStTime').empty();
				$('#voEndTime').empty();
				$('#voStGps').empty();
				$('#voEndGps').empty();
			} else {
				$(data).each(function(i){
					console.log(data[i]);
					console.log(data[i]["carNo"]);
					$('#voTripId').text(data[i]["tripId"]);
					$('#voInsDte').text(data[i]["insDte"]);
					$('#voCarNo').text(data[i]["carNo"]);
					$('#voUserId').text(data[i]["userId"]);
					$('#voDrvDistance').text(data[i]["DRIVING_DISTANCE"]);
					$('#voDrvTime').text(data[i]["DRIVING_TIME"]);
					$('#voStTime').text(data[i]["START_TIME"]);
					$('#voEndTime').text(data[i]["END_TIME"]);
					$('#voStGps').text(data[i]["START_GPS"]);
					$('#voEndGps').text(data[i]["END_GPS"]);
				})
			}
			getRpmChart();
			getMileChart();
			getFuelBarChart();
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}

function changeDate(){
	if($('#insDte').val() != null) changeCar(); 
	changeTrip();
}
</script>
<!-- fuel Chart -->
<jsp:include page="/WEB-INF/views/car/chart/milechart.jsp"/>
<!-- rpmChart -->
<jsp:include page="/WEB-INF/views/car/chart/rpm_chart.jsp"/>
<!-- donut chart (fuel level) -->
<jsp:include page="/WEB-INF/views/car/chart/fuelchart.jsp"/>
 </html>