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
	<jsp:include page="../mqtt/mqtt.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<!-- fuel Chart -->
	<jsp:include page="/WEB-INF/views/car/chart/fuelchart.jsp"/>
	<!-- rpmChart -->
	<jsp:include page="/WEB-INF/views/car/chart/rpm_chart.jsp"/>	
	<!-- donut chart (fuel level) -->	
	<jsp:include page="/WEB-INF/views/car/chart/donut_17.jsp"/>
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
	color: red;
	font-weight: border;
	font-size: 1.5em;
}
</style>
<%

	Object carList = request.getAttribute("selectCar");
	pageContext.setAttribute("carList", carList);

	Object tripList = request.getAttribute("selectTrip");
	pageContext.setAttribute("tripList", tripList);
	
	List<CarLogVO> logList = (List<CarLogVO>)request.getAttribute("selectLog");
	pageContext.setAttribute("logList", logList);
	
%>
<body>
	<div style="float:left; width:100%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
			<select id="carId" style="width:400px; height:30px" onchange="changeCarSelect()">
				<option>차량을 선택해주세요.</option>
				<c:forEach var="i" items="${carList}">
					<option value="${i.carNo }">${i.carNo }</option>
				</c:forEach>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Trip ID : &nbsp;&nbsp;
			<select id="tripId" name="tripName" style="width:289px; height:30px">
				<option>Trip을 선택해주세요.</option>
				<c:forEach var="i" items="${tripList}">
					<option value="${i.tripId }">${i.tripId }</option>
				</c:forEach>
			</select>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width:810px; height:210px; padding: 0px 10px 10px 0px;">
				<table style="float:left; ">
					<tr>
						<th style="width:100px">Trip ID</th>
						<td style="width:260px"><%=logList.get(0).getTripId() %></td>
						<th style="width:100px">날짜</th>
						<td><%=logList.get(0).getInsDte() %></td>
					</tr>
					<tr>
						<th>사용자 ID</th>
						<td><%=logList.get(0).getUserId() %></td>
						<th>주행 거리</th>
						<td><%=logList.get(0).getDRIVING_DISTANCE() %></td>
					</tr>
					<tr>
						<th>차량번호</th>
						<td><%=logList.get(0).getCarNo() %></td>
						<th>운행시간</th>
						<td><%=logList.get(0).getDRIVING_TIME() %></td>
					</tr>
				</table>
			</div>
			
			<div align="left" style="float:left; width:400px; height:210px; ">
				<table>
					<tr>
						<td>
							<canvas id=doughnut-chart></canvas>
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
								<canvas id=fuelchart></canvas>
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
function changeCarSelect(){
	var carSelected = document.getElementById("carId").value;
	console.log("선택된 차량 : " + carSelected);
	var $target = $("select[name='tripName']");
	
	$.ajax({
		type: 'post', 
		url: "/car/post", 
		async: false, 
		data: {carNo : carSelected}, // 서버로 보낼 데이터 
		/* dataType: "json", // 호출했을 때 결과타입 */
		success: function(data) {
			if(data.length == 0) {
				//$target.append("<option value="">Trip을 선택해주세요</option>");
			} else {
				$(data).each(function(i){
					//$target.append("<option value="+data[i].tripId+">"+data[i].tripId+"</option>");
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