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
			type: 'post', 
			url: 'cars/json',
			async: false,
			data: {
				searchId: selectedCar
			},
			success: function(data){
				console.log("success search data");
				console.log("data.." + data["searchList"].length);
				var body = ''; 
				var foot = '';
				if(data["searchList"].length > 0) {
					$(data["searchList"]).each(function(i){
						body += '<tr>' 
									+ '<td>' + data["searchList"][i].carId + '</td>'
								 	+ '<td>' + data["searchList"][i].TripRuntime + '</td>'
								 	+ '<td>' + data["searchList"][i].TripDistance + '</td>'
							 	+ '</tr>';
					})
				}
			 	foot += '<tr>'
				 			+ '<td colspan="3" align="center">'	+ '총 ' +  data["searchList"].length + '대 운행 중' + '</td>'
		 			+ '</tr>';
		 			
			 	$('#tbody').html(body);
			 	$('#tfoot').html(foot);

			 	
			}, error: function(xhr) {
				console.log("error search data");
				console.log(xhr.responseText);
				alert("system doesn't proceed this process");
				return;
			}
		})
	}
</script>
<style>
	div
	{
		/* border:1px solid red; */  
		padding: 0px 10px 10px 0px; 
		
	} 
</style>
<body>
	<div style="float:left; width:98%; margin:1%;">
		<!-- 라인1. -->
		<div align="left" >
			<select onchange="changeCar()" id="carId" style="width:300px; height:30px" >
				<option value=>차량을 선택해주세요.</option>
				<c:forEach var="i" items="${list }">
					<option value="${i.carId }">${i.carId }</option>
				</c:forEach>
			</select>
		</div>
		<!-- 라인2. -->
		<div align="left" style="width:100%;">
			<div align="left" style="float:left; width: 35%; height: 100%; align-content: left; ">
				<table style="float:left; width:100%">
					<thead>
						<tr>
							<th>차량번호</th>
							<th>운행시간</th>
							<th>운행거리</th>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach var="i" items="${list }">
							<tr>
								<td><span>${i.carId }</span></td>
								<td><span>${i.tripRuntime }</span></td>
								<td><span>${i.tripDistance }</span></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot id="tfoot">	
						<tr>
							<td colspan="3" align="center">총 <span>${listSize }</span>대 운행 중</td>
						</tr>				
					</tfoot>
				</table>
			</div>
			<div align="left" style="float:left; width: 60%; height: 100%; align-content: center; ">map</div>
		</div>
	</div>
</body>

</html>