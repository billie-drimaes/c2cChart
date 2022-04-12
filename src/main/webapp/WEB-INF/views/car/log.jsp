<%@page import="java.util.Date"%>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
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
input
{
	height: 25px;
}
table 
{
	text-align: center;
}
</style>
<%

	Object carList = request.getAttribute("selectCar");
	pageContext.setAttribute("carList", carList);
	
	
	
%>
<script type="text/javascript">

</script>
<body>
	<div style="float:left; width:100%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
			<input type="date" id="datePicker" style="width:295px;">
		</div>
		<!-- 첫번째 라인 -->
		<div align="left" >
			<div style="float:left;">
				<select id="carId" style="width:300px; height:30px" onchange="changeCarSelect()">
					<option>차량을 선택해주세요.</option>
					<c:forEach var="i" items="${carList}">
						<option value="${i.carNo }">${i.carNo }</option>
					</c:forEach>
				</select>
			</div>
			<div  style="float:left; width:100px"></div>
			<div style="float:left;">
				Trip ID : &nbsp;&nbsp;
				<select id="tripId" name="tripName" style="width:300px; height:30px" onchange="changeTripSelect()">
					<option>Trip을 선택해주세요.</option>
				</select>
			</div>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width:810px; padding: 0px 10px 10px 0px;">
				<table style="float:left; ">
					<tr>
						<th>Trip ID</th>
						<th>날짜</th>
						<th>차량번호</th>
						<th>User ID</th>
						<th>주행거리</th>
						<th>운행시간</th>
					</tr>
					<tr style="height:50px">
						<td><span id="voTripId"></span></td>
						<td><span id="voInsDte"></span></td>
						<td><span id="voCarNo"></span></td>
						<td><span id="voUserId"></span></td>
						<td><span id="voDrvDistance"></span></td>
						<td><span id="voDrvTime"></span></td>
					</tr>
					<tr>
						<th>연료/배터리<br>사용량</th>
						<th>연비/전비</th>
						<th>공회전 시간</th>
						<th colspan="3">참고사항</th>
					</tr>
					<tr style="height:100px">
						<td></td>
						<td></td>
						<td></td>
						<td colspan="3" style="text-align: center">
							<br>
							<div>
								<table>
									<tr>
										<th style="width:70px">구분</th>
										<th>시간</th>
										<th>위치</th>
									</tr>
									<tr>
										<td>운행시작</td>
										<td><span id="voStTime"></span></td>
										<td><span id="voStGps"></span></td>
									</tr>
									<tr>
										<td>운행종료</td>
										<td><span id="voEndTime"></span></td>
										<td><span id="voEndGps"></span></td>
									</tr>
								</table>
							</div>
							<div>
								<table>
									<tr>
										<th style="width:70px">구분</th>
										<th>빈도수(회)</th>
									</tr>
									<tr>
										<td>급가속</td>
										<td></td>
									</tr>
									<tr>
										<td>급감속</td>
										<td></td>
									</tr>
								</table>
							</div>
							<br>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
		
	</div>
</body>
<script type="text/javascript">
function changeCarSelect(){
	var carSelected = document.getElementById("carId").value;
	console.log("선택된 차량 : " + carSelected);
	var $target = $("select[name='tripName']");
	var $option = $("select[name='tripName'] option");
	$.ajax({
		type: 'post', 
		url: "/car/post", 
		async: false, 
		data: {carNo : carSelected}, // 서버로 보낼 데이터 
		success: function(data) {
			$option.remove();
			$target.append("<option value=''>Trip을 선택해주세요.</option>");
			
			if(data.length == 0) {
			} else {
				$(data).each(function(i){
					$target.append("<option value="+data[i].tripId+">"+data[i].tripId+"</option>");
				})
			}
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}
function changeTripSelect(){
	var selectedTrip = document.getElementById("tripId").value;
	console.log("선택된 Trip ID : " + selectedTrip);

	$.ajax({
		type: 'post', 
		url: "/car/json", 
		async: false, 
		data: {tripId : selectedTrip}, // 서버로 보낼 데이터 
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
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}
</script>
</html>