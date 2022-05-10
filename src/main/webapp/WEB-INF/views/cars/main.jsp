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
	<div align="center" style="float:left; width:98%; margin:1%; ">
		<!-- 라인1. -->
		<div align="left" >
			<select>
				<option>차량을 선택해주세요.</option>
			</select>
		</div>
		<!-- 라인2. -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width: 40%; height: 100%; align-content: center; padding: 0px 10px 10px 0px;">
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
			<div align="left" style="float:left; width: 60%; height: 100%; align-content: center; padding: 0px 10px 10px 0px;">map</div>
		</div>
	</div>
</body>
</html>