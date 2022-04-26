<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<style>
/* 슬래시 모양 css 가져옴 */
.input_text {
	width:90%;
	height:80%;
	border: none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.find_text {
	text-decoration:none;
}
li{
	list-style:none;
	float: left;
	padding: 0 15px;
}
li::after{
	content:"|";
	float:right;
	margin-right:-17px
}
li:last-child::after{
	content:"";
}
ul{
	align: center;
}
</style>
<body>
	<div style="float:left; width:100%; margin:1%;">
		<!-- 첫번째 라인 -->		
		<div align="center" style="font-size:2.0em; margin-top:100px;" >
			<div>
			Drimaes FMS
			</div>
		</div>
		<div class="login_wrap">
			<!-- 로그인 박스 -->
			<form id="frmLogin" action="login" method="post">
				<div align="center" class="id_pw_wrap" >
					<div style="border:1px solid black; width:400px; height:30px; margin-top:100px;" id="id_line">
						<span class="icon_id" style="float:left; color:gray;">&#x1F464;
						</span>
						<input type="text" name="userId" placeholder="아이디" class="input_text" maxlength="12" value="">
					</div>
					<div style="border:1px solid black; width:400px; height:30px; margin-top:10px;" id="pw_line">
						<span class="icon_pw" style="float:left; color:gray;">&#x1F512;
						</span>
						<input type="password" name="password" placeholder="비밀번호" class="input_text" minlength="8" maxlength="12" value="">
					</div>
					<div style="width:400px; height:30px; margin-top:10px;" id="errMsg">
						<c:if test="${message == 'error'}">
						 	<div style="color:red;"> 아이디 또는 비밀번호가 일치하지 않습니다.
							</div>
						</c:if>
					</div>
					<button type="submit" style="width:400px; height:40px; margin-top:10px; font-size:1.3em">로그인</button>
				</div>
			</form>
			<!-- 로그인박스 하단 -->
			<div align="center">
			<ul class="find_wrap" id="find_wrap" style="width:250px; height:30px;">
               <li><a target="_blank" href="/WEB-INF/views/findId.jsp" class="find_text">아이디 찾기</a></li>
               <li><a target="_blank" href="/WEB-INF/views/findPw.jsp" class="find_text">비밀번호 찾기</a></li>
           </ul>
           </div>
		</div>
	</div>
</body>
</html>