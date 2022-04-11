<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개별차량 통계</title>
<!-- 달력(datepicker)사용을 위한 라이브러리 추가 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

	<!-- 상단 메뉴 -->
	<jsp:include page="../../navbar.jsp">
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
	color: red;
	font-weight: border;
	font-size: 1.5em;
}
</style> 
<body>
	<div style="float:left; width:100%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
			<!-- DB의 carInfo 테이블에서 차량번호를 가져와 선택하도록 함 / infoMapper-->
			<select name="selectBox" style="width:400px; height:30px" onchange="selectCar(this)">
   		  		<option>차량번호 선택</option>
      			<c:forEach var="info" items="${infoList}" varStatus="i">
         			<option value="${info.carNo}">${info.carNo}</option>
      			</c:forEach>
         </select>
		</div>
		<!-- 두번째 라인 -->
		<div align="left" >
			차량: 12가1234
		</div>
		<!-- 세번째 라인 -->
		<div align="left" >
			<!-- 달력 삽입-->
			<div align="left" style="width:100%">
				FROM
				<input name="from" autocomplete="off" readonly="readonly">
				&nbsp;TO
				<input name="to" autocomplete="off" readonly="readonly">
				&nbsp;
				<button style="width:10%;">조회</button>
			</div>
		</div>
		<!-- 네번째 라인: 차트 삽입 -->
		<div align="left">
			<!-- Chart -->
			<jsp:include page="/WEB-INF/views/gson.jsp"/>
		</div>
	</div>
	<script>
		$(function() {
			  $( "input[name='from']" ).datepicker();
			});
		$(function() {
			  $( "input[name='to']" ).datepicker();
			});
	</script> 
</body> 
</html> 