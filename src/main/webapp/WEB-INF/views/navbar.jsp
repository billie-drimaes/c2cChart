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
	width:700px;
	height:50px;
	color:black;
	line-height: 50px; 
	margin:0 auto;
	text-align: center;
}

#menu > ul > li {
	float:left;
	width:140px;
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
</style>
 
<!-- 
	viewport : 사용자에게 보여지는 영역
	width=device-width : 넓이를 기기의 크기에 맞춘다. 
	inital-scale="1" : 초기 화면 배율을 1로 맞춘다. 
 -->
<meta charset="UTF-8" name = "viewport" content="width=device-width", inital-scale="1">
<header style="border-bottom: 1px solid #ccc; padding: 15px 0; text-align: left"> 
	<div id="menu" style="margin-left: 100px;"> 
		<ul> 
			<li><a href='../main'>Main</a></li> 
			<li><a href='../cars'>전체 차량</a>
				<ul class="submenu">
					<li><a href='../cars'>통계</a></li>
				</ul>
			</li> 
			<li><a href='../car'>개별 차량</a>
				<ul class="submenu">
					<li><a href='../car'>모니터링</a></li>
					<li><a href='../carStat'>통계</a></li>
					<li><a href='../car'>보고서</a></li>
				</ul>
			</li> 
			<li><a href='../monitoring'>안전 모니터링</a></li>
			<li><a href='../monitoring'>계정</a>
				<ul class="submenu">
					<li><a href='../cars'>관리자페이지</a></li>
				</ul>
			</li> 
		</ul>
	</div> 
</header>
