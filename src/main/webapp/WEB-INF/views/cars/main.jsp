<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량</title>
<jsp:include page="../navbar.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	function changeCar() {
		var selectedCar = $('#carId').val();
		console.log("chageCar().." + selectedCar);
		$.ajax({
			type: 'get', 
			url: 'cars',
			async: false,
			data: {
				searchId: selectedCar
			},
			success: function(data){
				console.log("success search data");
				$(data).each(function(i){
					
				})
			}, error: function(xhr) {
				console.log("error search data");
				console.log(xhr.responseText);
				alert("system doesn't proceed this process");
				return;
			}
		})
	}
</script>
<body>
	<div style="width:98%; margin:1%; ">
		<!-- 라인1. -->
		<div align="left" style="float:left; width:100%;">
			<select onchange="changeCar()" id="carId">
				<option>차량을 선택해주세요.</option>
				<c:forEach var="i" items="${list }">
					<option>${i.carId }</option>
				</c:forEach>
			</select>
		</div>
		<!-- 라인2. -->
		<div align="left" style="width:100%;">
			<div align="left" style="float:left; width: 35%; height: 100%; align-content: left; ">
				<table>
					<thead>
						<tr>
							<th>차량번호</th>
							<th>운행시간</th>
							<th>운행거리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" items="${list }">
							<tr>
								<td><span>${i.carId }</span></td>
								<td><span>${i.tripRuntime }</span></td>
								<td><span>${i.tripDistance }</span></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>						
					</tfoot>
				</table>
			</div>
			<div align="left" style="float:left; width: 60%; height: 100%; align-content: center; ">map</div>
		</div>
	</div>
</body>

</html>