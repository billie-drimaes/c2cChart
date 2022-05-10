<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 
	viewport : 사용자에게 보여지는 영역
	width=device-width : 넓이를 기기의 크기에 맞춘다. 
	inital-scale="1" : 초기 화면 배율을 1로 맞춘다. 
 -->
<meta charset="UTF-8" name = "viewport" content="width=device-width", inital-scale="1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" />

<title>Main</title>
<jsp:include page="../navbar.jsp">
	<jsp:param value="" name=""/>
</jsp:include>

<style>

.btnCarsMonitoring {
	width: 100%; 
	height: 100%; 
	align-content: center; 
	font-size:20px; 
	font-weight:bold; 
	border-radius: 12px;
	color:white; 
	background-color: #00CCCC;
}
</style>

</head>
<body>
	<div align="center" style="float:left; width:98%; margin:1%; align-content: center; ">
		<!-- 첫번째 라인 -->
		<div align="center" >
			<form action="/main">
				<div style="float:left;">
						<select id="carId" name="searchType" style="width:300px; height:30px" onchange="changeCar()">
							<option selected="selected">차량번호, 차종을 선택해주세요.</option>
							<c:set var="type" value="${searchType }"/>
							<c:choose>
								<c:when test="${type eq 'carId' }">
									<option value="carId" selected="selected">차량번호</option>
								</c:when>
								<c:otherwise>
									<option value="carId">차량번호</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${type eq 'model' }">
									<option value="model" selected="selected">차종</option>
								</c:when>
								<c:otherwise>
									<option value="model">차종</option>
								</c:otherwise>
							</c:choose>
						</select>
				</div>
				<div style="float:left;" class="search_box">
					<input name="searchBox" type="text" placeholder="검색해주세요." style="width:300px; height:25px;" id="searchBox" value="${searchBox }">
					<button type="submit" id="btnSearch" style="width:50px; height:28px;"><i class="fa fa-search" aria-hidden="true"></i><span class="sound_only">검색</span></button>
				</div>
			</form>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width: 100%; height: 100%; align-content: center; padding: 0px 10px 10px 0px;">
				<table style="float:left; ">
					<tr>
						<th>차량번호</th>
						<th>상태</th>
						<th>차종</th>
						<th>누적거리</th>
						<th>위치</th>
						<th style="width:415px">서비스</th>
					</tr>
					<c:forEach var="i" items="${list }">
						<tr>
							<td><span id="carId">${i.carId }</span></td>
							<td><span id="status">${i.STATUS }</span></td>
							<td><span id="model">${i.modelName }</span></td>
							<td><span id="distance">${i.distance }</span></td>
							<td>
								<span id="latitude">${i.latitude },</span>
								<span id="longitude">${i.longitude }</span>
							</td>
							<td>
								<form action="carStat" method="get">
									<input hidden="true" name="carId" value="${i.carId }">
									<input type="button" value="현황" style="width:100px" >
									<input type="button" value="예약" style="width:100px">
									<input type="submit" value="통계" style="width:100px" onclick="window.open('/carStat?carId='" + ${i.carId } + "'")"><!-- 새로운 탭에 open -->
									<!-- <input type="button" value="통계" style="width:100px" onclick="location.href='/carStat'">현재 탭에 화면 변경 -->
									<input type="button" value="장비" style="width:100px">
								</form>
							</td>
						</tr>
						
					</c:forEach>
				</table>
			</div>
			
		</div>
		<div style="float:left; width:80%; height:50px;" align="center">
			<input class="btnCarsMonitoring" type="button" value="전체차량 모니터링" onclick="location.href='/cars'" >
		</div>
	</div>
</body>
</html>