<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<%-- 
		<jsp:forward page="../car/main.jsp">
			<jsp:param value="" name=""/>
		</jsp:forward>
		 --%>
		<script type="text/javascript">
		var i = 0; 
		var mqtt;
		var reconnectTimeout = 2000;
		//var host ="61.42.251.202";
		var host ="192.168.12.21";
		//var host ="wss:a6v8vus1k5k5m-ats.iot.ap-northeast-2.amazonaws.com/C2C-Mqtt"; 
		var port = 9001;
		
		//callback function
		//성공 접속
		function onConnect(){
			mqtt.subscribe("test/#", {qos: 1}); // 토픽명
			console.log("접속 완료"); 
		}
		//접속 실패
		function onFailure(message){
			setTimeout(mqttConnection, reconnectTimeout);
			console.log("접속 실패");
		}
		//메세지가 도착하는 경우 호출
		function onMessageArrived(msg){
			console.log("도착.." + msg.destinationName);
			console.log(msg.payloadString);
			//document.getElementById("payload").innerHTML = payload;
			/* 
			topic :** **`test/driver/route/time/[컬럼]`
			컬럼 : ['RPM','Speed','Runtime','Fuel','Temperature','coolantTemp','idling','batteryVolt','batteryTemp','torque','horsePower']`
			(rpm,속도,운행시간,연료량,외부온도,냉각수온도,공회전시간,베터리전압,베터리온도,토크,마력)
			+ 위치정보 토픽 :** **`test/driver/route/time/Latitude/Longitude/Altitude'
			 */
			var topic = msg.destinationName;
			var strTopic = topic.split("test/driver/route/time/")[1];
			var message = msg.payloadString; 
			var strMsg = message.split("/")[3];
			console.log("strTopic --> "+strTopic);
			console.log("splitPayload --> " + strMsg);
			if(strTopic=="RPM") {
				document.getElementById("RPM").innerHTML = strMsg;
			} 
			if(strTopic=="Speed") {
				document.getElementById("Speed").innerHTML = strMsg;
			} 
			if(strTopic=="Runtime") {
				//document.getElementById("Runtime").innerHTML = strMsg;
			} 
			if(strTopic=="Fuel") {
				//document.getElementById("Fuel").innerHTML = strMsg;
			} 
			if(strTopic=="Temperature") {
				document.getElementById("Temperature").innerHTML = strMsg;
			} 
			if(strTopic=="coolantTemp") {
				document.getElementById("coolantTemp").innerHTML = strMsg;
			} 
			if(strTopic=="idling") {
				document.getElementById("idling").innerHTML = strMsg;
			} 
			if(strTopic=="batteryVolt") {
				document.getElementById("batteryVolt").innerHTML = strMsg;
			} 
			if(strTopic=="batteryTemp") {
				document.getElementById("batteryTemp").innerHTML = strMsg;
			} 
			if(strTopic=="torque") {
				document.getElementById("torque").innerHTML = strMsg;
			} 
			if(strTopic=="horsePower") {
				document.getElementById("horsePower").innerHTML = strMsg;
			} 
			if(strTopic=="Latitude/Longitude/Altitude"){
				document.getElementById("gps").innerHTML = message.split("/")[3] + "/" + message.split("/")[4] + "/" + message.split("/")[5];
			}
			//alert("메세지 도착!" + msg.payloadString);
		}
		function mqttConnection(){
			//mqtt클라이언트 객체 생성
			mqtt = new Paho.MQTT.Client(host,port,"cloud-sub-client");
			//연결하고 callback 함수 등록
			var options = {
					timeout: 10,
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
		
		<title>Insert title here</title>
	</head>
	<body>
		<script type="text/javascript">
			//mqttConnection();
		</script>
		<!-- <input type="button" id="pub_btn" value="publish"/> -->
	</body>
</html>