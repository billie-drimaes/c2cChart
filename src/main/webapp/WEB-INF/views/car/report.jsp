<%@page import="java.util.Date"%>
<%@page import="com.bill.vo.CarLogVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.7.2/bluebird.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>

	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
</head>
<style>
/* 테이블은 div 크기만큼 늘려준다 */
table{width:100%; height:100%}

/* div는 오른쪽, 아래쪽에 여백을 둔다 */
/* .container div 
{
	width:24.5%;
	height:210px;
} */
span
{
	font-weight: border;
}
input
{
	height: 25px;
}
table 
{
	text-align: center;
}
th{
	width:50%;
	background-color: #D3D3D3;
}
.report{
	margin-left:30px;
   vertical-align: middle;
	border:1px solid black;
	width:90%;
	height:100%;
	padding:10px;
	overflow-x: hidden;
}
#reportChart{
	border:1px solid black;
}
</style>
<%
	Object carList = request.getAttribute("selectCar");
	pageContext.setAttribute("carList", carList);
%>
<script type="text/javascript">

</script>
<body>
	<div class="total" style="width:95%; margin:1%; overflow: hidden;">
		<!-- 첫번째 라인 
		<div align="left" >
			<input type="date" id="insDte" style="width:295px;" onchange="changeDate()">
		</div>
		-->
		<!-- 첫번째 라인 -->
		<div align="center" style="margin-left:30px;margin-bottom:30px;">
			<div style="float:left;">
				<select id="carId" style="width:300px; height:30px" onchange="changeCar()">
					<option>차량을 선택해주세요.</option>
					<c:forEach var="i" items="${carList}">
						<option value="${i.carNo }">${i.carNo }</option>
					</c:forEach>
				</select>
			</div>
			<div  style="float:left; width:100px"></div>
			<div style="float:left;">
				Trip ID : &nbsp;&nbsp;
				<select id="tripId" name="tripName" style="width:300px; height:30px" onchange="changeTrip()">
					<option>Trip을 선택해주세요.</option>
				</select>
			</div>
			<span id="payload"></span>
		</div>	
		<div align="center" class="report">
			<!-- 두번째 라인 -->
			<div align="center" class="contents" style="float:left; width:90%;margin-left:50px; height:250px; overflow: auto;">
				<div align="left" style="float:left; width:750px; height:90%;">
					<table style="float:left;">
						<tr>
							<th colspan="2">Trip 
							<span id="voReportTrip"></span> Report</th>
						</tr> 
						<tr>
							<th>Trip ID</th>
							<td><span id="voTripId"></span></td>
						</tr>
						<tr>
							<th>날짜</th>
							<td><span id="voInsDte"></span></td>
						</tr>
						<tr>
							<th>차량번호</th>
							<td><span id="voCarNo"></span></td>
						</tr>					
						<tr>
							<th>User ID</th>
							<td><span id="voUserId"></span></td>
						</tr>					
						<tr>
							<th>주행거리</th>
							<td><span id="voDrvDistance"></span></td>
						</tr>
						<tr>
							<th>운행시간</th>
							<td><span id="voDrvTime"></span></td>
						</tr>
					</table>
					</div>
					<div style="float:left; border:1px solid black;">
					Map
					</div>
				</div>
				<div align="center" class="contents" style="float:left; width:95%; height:310px; overflow: auto;">
					<div id="reportChart" style="float:left; width:750px; height:95%;margin-left:3%;">
							<canvas id=milechart></canvas>
					</div>
					<div id="reportChart" style="float:left; width:750px; height:95%;margin-left:30px; ">
							<canvas id=rpmChart></canvas>
					</div>
				</div>
				<div align="center" class="contents" style="float:left; width:80%;margin-left:100px; margin-right:3%; overflow: auto;">
				<table>
					<tr>
						<th>참고사항</th>
					</tr>
					<tr>
						<td>
							<div style="float:left; width:40%; margin-left:70px">
								<table>
									<tr>
										<th style="width:100px">구분</th>
										<th style="width:100px">시간</th>
										<th style="width:100px">위치</th>
									</tr>
									<tr>
										<td>운행시작</td>
										<td><span id="voStTime"></span></td>
										<td><span id="voStGps"></span></td>
									</tr>
									<tr>
										<td>운행종료</td>
										<td><span id="voEndTime"></span></td>
										<td><span id="voEndGps"></span></td>
									</tr>
								</table>
							</div>
							<div style="float:left; width:40%;margin-left:100px;">
								<table>
									<tr>
										<th style="width:70px">구분</th>
										<th>빈도수(회)</th>
									</tr>
									<tr>
										<td>급가속</td>
										<td></td>
									</tr>
									<tr>
										<td>급감속</td>
										<td></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="button" align="center" style="float:left; width:90%;margin-top:10px;height:40px;">
			<div id="loader" style="display: none;">
				<span>잠시만 기다려주세요...</span>
			</div>
			<button type="button" id="savePdf" style="width:100px;height:30px;">PDF 저장</button>
		</div>
	</div>	
</body>
<script type="text/javascript">
let carSelected;
let selectedTrip;

function changeCar(){
	carSelected = $('#carId').val();
	var insDte = $('#insDte').val();
	console.log("선택된 차량 : " + carSelected);
	console.log("선택된 날짜 : " + insDte);
	var $target = $("select[name='tripName']");
	var $option = $("select[name='tripName'] option");
	$.ajax({
		type: 'post', 
		url: "/car/post", 
		async: false, 
		data: {
			carNo : carSelected,
			insDte : insDte
		}, // 서버로 보낼 데이터 
		success: function(data) {
			$option.remove();
			$target.append("<option value=''>Trip을 선택해주세요.</option>");
			
			if(data.length == 0) {
			} else {
				$(data).each(function(i){
					$target.append("<option value="+data[i].tripId+">"+data[i].tripId+"</option>");
				})
			}
			changeTrip();
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}
function changeTrip(){
	selectedTrip = document.getElementById("tripId").value;
	var insDte = $('#insDte').val();
	console.log("선택된 Trip ID : " + selectedTrip);
	console.log("선택된 날짜 : " + $('#insDte').val() + '/' + insDte);
	$.ajax({
		type: 'post', 
		url: "/car/json", 
		async: false, 
		data: {
					tripId : selectedTrip, 
					insDte : insDte
		}, // 서버로 보낼 데이터 
		success: function(data) {
			if(data.length == 0) {
				$('#voTripId').empty();
				$('#voInsDte').empty();
				$('#voCarNo').empty();
				$('#voUserId').empty();
				$('#voDrvDistance').empty();
				$('#voDrvTime').empty();
				$('#voStTime').empty();
				$('#voEndTime').empty();
				$('#voStGps').empty();
				$('#voEndGps').empty();
			} else {
				$(data).each(function(i){
					console.log(data[i]);
					console.log(data[i]["carNo"]);
					$('#voReportTrip').text(data[i]["tripId"]);
					$('#voTripId').text(data[i]["tripId"]);
					$('#voInsDte').text(data[i]["insDte"]);
					$('#voCarNo').text(data[i]["carNo"]);
					$('#voUserId').text(data[i]["userId"]);
					$('#voDrvDistance').text(data[i]["DRIVING_DISTANCE"]);
					$('#voDrvTime').text(data[i]["DRIVING_TIME"]);
					$('#voStTime').text(data[i]["START_TIME"]);
					$('#voEndTime').text(data[i]["END_TIME"]);
					$('#voStGps').text(data[i]["START_GPS"]);
					$('#voEndGps').text(data[i]["END_GPS"]);
				})
			}
			getRpmChart();
			getMileChart();
		}, error:function(xhr) {
			console.log(xhr.responseText);
			alert("system doesn't proceed this process");
			return;
		}
	});
	
}

function changeDate(){
	if($('#insDte').val() != null) changeCar(); 
	changeTrip();
}

$(function(){
	$("#savePdf").click(function(){ //pdf저장 버튼 id
		document.getElementById("loader").style.display="block";
	
		setTimeout(function(){
			createPdf();
		},100)
	});
});
 
//화면 pdf로 저장하기
var renderedImg = new Array;

var contWidth = 200, // 너비(mm) (a4에 맞춤)
		padding = 5; //상하좌우 여백(mm)
		

function createPdf() { //이미지를 pdf로 만들기
	document.getElementById("loader").style.display = "block"; //로딩 시작
	

	var lists = document.querySelectorAll("div.contents"),//div.report:not(div.button) : button을 제외한 나머지 report class 내용만 가져옴
			deferreds = [],
			doc = new jsPDF("p", "mm", "a4"),//가로방향: jsPDF("l", "mm", "a4"
			listsLeng = lists.length;
			console.log(lists)

	for (var i = 0; i < listsLeng; i++) { // div.report 개수만큼 이미지 생성
		var deferred = $.Deferred();
		deferreds.push(deferred.promise());
		generateCanvas(i, doc, deferred, lists[i]);
	}

	$.when.apply($, deferreds).then(function () { // 이미지 렌더링이 끝난 후
		var sorted = renderedImg.sort(function(a,b){return a.num < b.num ? -1 : 1;}), // 순서대로 정렬
				curHeight = padding, //위 여백 (이미지가 들어가기 시작할 y축)
				sortedLeng = sorted.length;
	
		for (var i = 0; i < sortedLeng; i++) {
			var sortedHeight = sorted[i].height, //이미지 높이
					sortedImage = sorted[i].image; //이미지
					
			if( curHeight + sortedHeight > 297 - padding * 2 ){ // a4 높이에 맞게 남은 공간이 이미지높이보다 작을 경우 페이지 추가
				doc.addPage(); // 페이지를 추가함
				curHeight = padding; // 이미지가 들어갈 y축을 초기 여백값으로 초기화
				doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
				curHeight += sortedHeight; // y축 = 여백 + 새로 들어간 이미지 높이
			} else { // 페이지에 남은 공간보다 이미지가 작으면 페이지 추가하지 않음
				doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
				curHeight += sortedHeight; // y축 = 기존y축 + 새로들어간 이미지 높이
			}
					
					
		}
		doc.save('pdf_test.pdf'); //pdf 저장

		document.getElementById("loader").style.display = "none"; //로딩 끝
		curHeight = padding; //y축 초기화
		renderedImg = new Array; //이미지 배열 초기화
	});
}
		
function generateCanvas(i, doc, deferred, curList){ //페이지를 이미지로 만들기
	var pdfWidth = $(curList).outerWidth() * 0.2645, //px -> mm로 변환
		pdfHeight = $(curList).outerHeight() * 0.2645,
		heightCalc = (contWidth * pdfHeight / pdfWidth)*1.3; //비율에 맞게 높이 조절
		html2canvas(curList).then(
			function (canvas) {
				var img = canvas.toDataURL('image/jpeg', 1.0); //이미지 형식 지정
				renderedImg.push({num:i, image:img, height:heightCalc}); //renderedImg 배열에 이미지 데이터 저장(뒤죽박죽 방지)     
				deferred.resolve(); //결과 보내기
				}
		);
}
</script>
<!-- fuel Chart -->
<jsp:include page="/WEB-INF/views/car/chart/milechart.jsp"/>
<!-- rpmChart -->
<jsp:include page="/WEB-INF/views/car/chart/rpm_chart.jsp"/>
</html>