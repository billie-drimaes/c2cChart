<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 스프링은 따로 라이브러리를 설치하지 않아도 다운 받을 라이브러리를 설정할 수 있다. --> 
<!-- 그 중에 jstl 라이브러리도 있기 때문에 사용할 수 있는것 --> 
<link rel="stylesheet" type="text/css" href="css/common.css"> 
<!-- rel : 형태는 스타일 시트, 타입은 텍스트로된 css --> 
<style> 
* {
	margin: 0;
	padding: 0;
}
ul li{
	list-style: none;
}
a {
	text-decoration: none;
}

#menu {
	font:bold 16px "malgun gothic";
	width:1600px;
	height:30px;
	color:black;
	line-height: 40px; 
	margin:0 auto;
	text-align: center;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
	margin-left:80px;
}

#menu > ul > li {
	float:left;
	width:300px;
	position:relative;
}
#menu > ul > li > ul {
	width:130px;
	display:none;
	position: absolute;
	font-size:14px;
	background: gray;
}
#menu > ul > li:hover > ul {
	display:block;
	
}
#menu > ul > li > ul > li:hover {
	background: lightGray;
	transition: ease 1s;
	}
#account{
	float:left;
	width:100px;
	margin-left:20px;
}
#webName{
	font-size:2.0em;
	width:300px;
	height:50px;
	margin-left:700px;
	margint-bottom:0px;
	padding-left:100px;
}
#account_wrap > ul > li:last-child::before{
	content:"|";
	float:left;
	margin-left:8px;
	margin-right:-10px;
}
div
{
	/* border:1px solid red; */ 
	padding: 0px 10px 10px 0px; 
	
} 
</style>
 
<!-- 
	viewport : 사용자에게 보여지는 영역
	width=device-width : 넓이를 기기의 크기에 맞춘다. 
	inital-scale="1" : 초기 화면 배율을 1로 맞춘다. 
 -->
<meta charset="UTF-8" name = "viewport" content="width=device-width", inital-scale="1">
<header style="text-align: left;">
	<div class="top" style="height:70px; padding-top:15px; padding-bottom:0; width:1600px;">
		<div align="left" id="account" style="float:left;">
			<div style="border: 1px solid #ccc; font-size:0.8em; padding:5px;">
			안녕하세요,<br>
			<%
			//세션의 정보는 Object타입으로 저장되어있음
			//UserServiceImpl.java에서 session에 지정한 변수 가져오기
			String name = (String) session.getAttribute("name");
			out.print(name);
			%>님
			</div>
			<div align="center" id="account_wrap">
				<ul style="width:100px;font-size:0.5em;">
	               <li style="float:left;"><a href="logout.do" class="find_text">로그아웃</a></li>
	               <li><a href="/WEB-INF/views/myAccount.jsp" class="find_text">내정보</a></li>
	           </ul>
           </div>
		</div>
		<div id="webName">
			<div>
			Drimaes FMS
			</div>
		</div>
	</div>
	<div id="menu" style="margin-left: 100px;" align="center"> 
		<ul> 
			<li><a href='../main'>Main</a></li> 
			<li><a href='../cars'>전체 차량</a>
				<ul class="submenu">
					<li><a href='../carsStat'>통계</a></li>
				</ul>
			</li> 
			<li><a href='../car'>개별 차량</a>
				<ul class="submenu">
					<li><a href='../car'>모니터링</a></li>
					<li><a href='../carStat'>통계</a></li>
					<li><a href='../carReport'>보고서</a></li>
				</ul>
			</li> 
			<li><a href='../monitoring'>안전 모니터링</a></li>
			<li><a href='../account'>계정</a>
			</li> 
		</ul>
	</div> 
</header>
