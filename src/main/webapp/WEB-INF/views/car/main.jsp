<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체차량</title>
	
	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<!-- 
		mqtt subscribe 소스를 가져온다.
		main.jsp 파일이 open 되면 subscribe가 실행된다. 
	 -->
	<%-- <jsp:include page="../mqtt/mqtt.jsp">
		<jsp:param value="" name=""/>
	</jsp:include> --%>
	
	<!-- fuel Chart -->
	<jsp:include page="/WEB-INF/views/car/chart/fuelchart.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		
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

</style>
<script type="text/javascript">
	var mqtt;
	var reconnectTimeout = 2000;
	//var host ="61.42.251.202";
	var host ="192.168.100.138";
	var port = 9001;
	var payload = "";
	
	//callback function
	//성공 접속
	function onConnect(){
		console.log("접속 완료");
		mqtt.subscribe("test/#", {qos: 1}); // 토픽명
	}
	//접속 실패
	function onFailure(message){
		console.log("접속 실패");
		setTimeout(mqttConnection, reconnectTimeout);
	}
	//메세지가 도착하는 경우 호출
	function onMessageArrived(msg){
		console.log("도착.." + msg.destinationName);
		console.log(msg.payloadString);
		payload = msg.payloadString;
		document.getElementById("payload").innerHTML = payload;
		/* 
		topic :** **`test/driver/route/time/[컬럼]`
		컬럼 : ['RPM','Speed','Runtime','Fuel','Temperature','coolantTemp','idling','batteryVolt','batteryTemp','torque','horsePower']`
		(rpm,속도,운행시간,연료량,외부온도,냉각수온도,공회전시간,베터리전압,베터리온도,토크,마력)
		+ 위치정보 토픽 :** **`test/driver/route/time/Latitude/Longitude/Altitude'
		 */
		var topic = msg.destinationName;
		var strTopic = topic.split("test/driver/route/time/")[1];
		var msg = msg.payloadString; 
		var strMsg = msg.split("/")[3];
		console.log("strTopic --> "+strTopic);
		console.log("splitPayload --> " + strMsg);
		if(strTopic=="RPM") {
			document.getElementById("RPM").innerHTML = strMsg;
		} else if(strTopic=="Speed") {
			console.log("splitPayload --> " + splitPayload);
			document.getElementById("Speed").innerHTML = strMsg;
		} else if(strTopic=="Runtime") {
			document.getElementById("Runtime").innerHTML = strMsg;
		} else if(strTopic=="Fuel") {
			document.getElementById("Fuel").innerHTML = strMsg;
		} else if(strTopic=="Temperature") {
			document.getElementById("Temperature").innerHTML = strMsg;
		} else if(strTopic=="coolantTemp") {
			document.getElementById("coolantTemp").innerHTML = strMsg;
		} else if(strTopic=="idling") {
			document.getElementById("idling").innerHTML = strMsg;
		} else if(strTopic=="batteryVolt") {
			document.getElementById("batteryVolt").innerHTML = strMsg;
		} else if(strTopic=="batteryTemp") {
			document.getElementById("batteryTemp").innerHTML = strMsg;
		} else if(strTopic=="torque") {
			document.getElementById("torque").innerHTML = strMsg;
		} else if(strTopic=="horsePower") {
			document.getElementById("horsePower").innerHTML = strMsg;
		} else {
			document.getElementById("gps").innerHTML = strMsg;
		}
		//alert("메세지 도착!" + msg.payloadString);
	}
	function mqttConnection(){
		//mqtt클라이언트 객체 생성
		mqtt = new Paho.MQTT.Client(host,port,"cloud-sub-client");
		//연결하고 callback 함수 등록
		var options = {
				timeout: 3,
				onSuccess: onConnect,
				onFailure: onFailure
		};
		//메세지가 도착하면 실행될 함수 등록
		mqtt.onMessageArrived = onMessageArrived;
		//접속
		mqtt.connect(options);
	}
	mqttConnection();
</script>
<body>

	<div style="float:left; width:100%; margin:1%;">
		<!-- 첫번째 라인 -->
		<div align="left" >
			<select id="" style="width:400px; height:30px">
				<option>driver1</option>
				<option>driver2</option>
				<option>driver3</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Trip ID : &nbsp;&nbsp;
			<select id="" style="width:289px; height:30px">
				<option>route1</option>
				<option>route2</option>
				<option>route3</option>
			</select>
			<span id="payload"></span>
		</div>
		
		<!-- 두번째 라인 -->
		<div align="left" style="float:left; width:100%;">
			<div align="left" style="float:left; width:810px; height:210px; padding: 0px 10px 10px 0px;">
				<table style="float:left; ">
					<tr>
						<th style="width:100px">Trip ID</th>
						<td style="width:260px"></td>
						<th style="width:100px">날짜</th>
						<td></td>
					</tr>
					<tr>
						<th>사용자 ID</th>
						<td></td>
						<th>주행 거리</th>
						<td></td>
					</tr>
					<tr>
						<th>차량번호</th>
						<td></td>
						<th>운행시간</th>
						<td></td>
					</tr>
				</table>
			</div>
			
			<div align="left" style="float:left; width:400px; height:210px; ">
				<table>
					<tr>
						<td>
							<canvas id="fuelchart"></canvas>
						</td>
					</tr>
				</table>
			</div>
			<div class="container" align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							배터리 전압(V)
							<br>
							<span id="batteryVolt"></span> 
							<div>
								<span id="batteryTemp"></span>
								<br>
								배터리 온도(℃)
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 세번째 라인 -->
		<div align="left" style="float:left; width:100%;" > 
			<div  class="container" align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							냉각수 온도(℃)
							<br>
							<span id="coolantTemp"></span> 
							<div>
								<span id="Temperature"></span>
								<br>
								외부 온도(℃)
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<div align="left" style="width:100%">
					<button style="width:49%; float:left">Log</button>
					&nbsp;
					<button style="width:49%; float:right">Report</button>
				</div>
				<div style="padding:0px 0px 0px 0px; width:400px; height:100%;">
					<table style="float:left; width:100%; height:177px;">
						<tr>
							<td>
								공회전 시간
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							속도(km)
							<br>
							<span id="Speed"></span> 
							<div>
								<span id="RPM"></span>
								<br>
								RPM
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:400px; height:210px;">
				<table>
					<tr>
						<td class="slash">
							토크(kgf.m)
							<br>
							<span id="torque"></span> 
							<div>
								<span id="horsePower"></span>
								<br>
								마력(PS)
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 네번째 라인 -->
		<div align="left" style="float:left; " > 
			<div align="left" style="float:left; width:810px; height:300px;">
				<table>
					<tr>
						<td>
							map
						</td>
					</tr>
				</table>
			</div>
			<div align="left" style="float:left; width:810px; height:300px;">
				<div style="float:left; width:100%; height:145px; ">
					<table>
						<tr>
							<td >
								공회전 시간
							</td>
						</tr>
					</table>
				</div>
				<div style="float:left; width:100%; height:145px; ">
					<table>
						<tr>
							<td >
								공회전 시간
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>