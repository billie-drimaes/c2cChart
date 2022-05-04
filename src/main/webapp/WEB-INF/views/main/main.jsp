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
<title>Main</title>
<jsp:include page="../navbar.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<style>
</style>
</head>
<body>
	<div style="float:left; width:98%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
			<div style="float:left;">
				<select id="carId" style="width:300px; height:30px" onchange="changeCar()">
					<option selected="selected">차량번호, 차종을 선택해주세요.</option>
					<option value="carId">차량번호</option>
					<option value="model">차종</option>
				</select>
			</div>
			<div style="float:left;" class="search_box">
				<input type="text" placeholder="검색해주세요." style="width:300px; height:25px;">
			</div>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width:100%; height:210px; padding: 0px 10px 10px 0px;">
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
								<input type="button" value="현황" style="width:100px" >
								<input type="button" value="예약" style="width:100px">
								<input type="button" value="통계" style="width:100px">
								<input type="button" value="장비" style="width:100px">
							</td>
						</tr>
						
					</c:forEach>
				</table>
			</div>
			
		</div>
		
	</div>
</body>
</html>