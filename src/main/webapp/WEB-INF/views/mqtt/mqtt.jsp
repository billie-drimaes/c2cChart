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
		//���� ����
		function onConnect(){
			mqtt.subscribe("test/#", {qos: 1}); // ���ȸ�
			console.log("���� �Ϸ�"); 
		}
		//���� ����
		function onFailure(message){
			setTimeout(mqttConnection, reconnectTimeout);
			console.log("���� ����");
		}
		//�޼����� �����ϴ� ��� ȣ��
		function onMessageArrived(msg){
			console.log("����.." + msg.destinationName);
			console.log(msg.payloadString);
			//document.getElementById("payload").innerHTML = payload;
			/* 
			topic :** **`test/driver/route/time/[�÷�]`
			�÷� : ['RPM','Speed','Runtime','Fuel','Temperature','coolantTemp','idling','batteryVolt','batteryTemp','torque','horsePower']`
			(rpm,�ӵ�,����ð�,���ᷮ,�ܺοµ�,�ð����µ�,��ȸ���ð�,���͸�����,���͸��µ�,��ũ,����)
			+ ��ġ���� ���� :** **`test/driver/route/time/Latitude/Longitude/Altitude'
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
			//alert("�޼��� ����!" + msg.payloadString);
		}
		function mqttConnection(){
			//mqttŬ���̾�Ʈ ��ü ����
			mqtt = new Paho.MQTT.Client(host,port,"cloud-sub-client");
			//�����ϰ� callback �Լ� ���
			var options = {
					timeout: 10,
					onSuccess: onConnect,
					onFailure: onFailure
					
			};
	
			//�޼����� �����ϸ� ����� �Լ� ���
			mqtt.onMessageArrived = onMessageArrived;
			//����
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