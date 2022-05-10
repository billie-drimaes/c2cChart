<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량</title>
<jsp:include page="../navbar.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
</head>
<body>
	<div align="center" style="float:left; width:98%; margin:1%; align-content: center; ">
		<!-- 라인1. -->
		<div align="left" style="width: 100%">
			<select>
				<option>차량을 선택해주세요.</option>
			</select>
		</div>
		<!-- 라인2. -->
		<div align="left" style="width: 100%; ">
			<table>
				<thead>
					<tr>
						<th>차량번호</th>
						<th>운행시간</th>
						<th>운행거리</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
				<tfoot>						
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>