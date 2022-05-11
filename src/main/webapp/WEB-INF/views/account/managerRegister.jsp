<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자등록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp"/>
</head>
<style>
table{width:100%; height:100%}
table 
{
	border:1px solid black;
	text-align: center;
}
.registTable{
	width: 70%;
	margin-left: 10%;
	margin-top: 5%;
	height: 600px;
}
.name{
	font-size:1.3em;
	background-color: #ffffff;
}
th{
	border:1px solid black;
	width:50%;
	background-color: #D3D3D3;
}
td{
	border:1px solid black;
}
.aster{
	color: red;
}
.buttonWarp{
	width: 70%;
	margin-left: 10%;
	text-align: center;
}
button{
	width:80px; 
	height:40px; 
	margin-top:10px; 
	font-size:1.0em;
	border:1px solid grey;
}
.input_text {
	width:98%;
	height:80%;
	border:1px solid grey;
	background-color: #D3D3D3;
	float:left;
}
</style>
<body>
	<div class="total" style="width:95%; margin:1%; overflow: hidden;">
		<form id="join" action="/user/register" method="post">
			<div align="center" class="registTable">
				<table>
					<tr>
						<th class="name" colspan="2">관&emsp;&emsp;리&emsp;&emsp;자&emsp;&emsp;등&emsp;&emsp;록</th>
					</tr> 
					<tr>
						<th><span class="aster">*</span>관리자 아이디 </th>
						<td>
							<div style="height:60%; width:98%; padding:0; margin-top:-3%;">
							<input type="text" name="userId" id="userId" class="input_text" maxlength="12" value="" style="width:80%;height:100%;">
							<button type="button" onclick="fn_idCheck()" id="idCheck" style="width:15%;height:100%;margin-top:0;background-color:#D3D3D3;" value="N">중복확인</button>
							</div>
							<div style="float:left;height:15%; width:98%;margin-bottom:-3%; text-align:left;" id="result_idcheck">
							</div>
						</td>
					</tr>
					<tr>
						<th><span class="aster">*</span>관리자 비밀번호</th>
						<td><input type="password" name="password" id="password" class="input_text" minlength="8" maxlength="12" value="" placeholder=" 8~12자 제한, 영문+숫자or특수문자 조합"></td>
					</tr>
					<tr>
						<th><span class="aster">*</span>비밀번호 확인</th>
						<td><input type="password" name="checkPassword" id="checkPassword" class="input_text" minlength="8" maxlength="12" value=""></td>
					</tr>					
					<tr>
						<th><span class="aster">*</span>성명</th>
						<td><input type="text" name="userName" id="userName" class="input_text" value=""></td>
					</tr>					
					<tr>
						<th><span class="aster">*</span>생년월일</th>
						<td><input type="text" name="birthDate" id="birthDate" class="input_text" value="" placeholder="ex) 1900/01/01"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" name="email" id="email" class="input_text" value="" placeholder="ex) thanos@drimaes.com"></td>
					</tr>
					<tr>
						<th><span class="aster">*</span>연락처 ('-' 없이 번호만 입력해주세요)</th>
						<td><input type="text" name="phoneNumber" id="phoneNumber" class="input_text" value="" placeholder="ex) 01012341234"></td>
					</tr>
				</table>
			</div>
			<div class="buttonWarp">
				<span class="aster" style="float:left;font-size:0.9em">(*필수입력사항)</span>
				<button type="button" onclick="location.href='../account'" >취소 </button>
				<button type="button" onclick="fnSubmit(); return false;" style="margin-left:30px;">등록 </button>
	      	</div>
      	</form>
	</div>
</body>
<script type="text/javascript">

function fn_idCheck(){
	$.ajax({
		type:"post",
		url:"/user/idCheck",
		//async: false,
		data: {userId: $("#userId").val()},
		success: function(data){
			if(data==1){
				$("#result_idcheck").text("이미 사용중인 아이디 입니다.");
				$("#result_idcheck").css("color","red");
			}else{
				$("#result_idcheck").text("사용가능한 아이디입니다.");
				$("#result_idcheck").css("color","black");
				$("#idCheck").attr("value","Y");
				//console.log($("#idCheck").val())
			}
		}, error:function(request,status,error){
			alert("중복확인 error:"+request.status);
		}
	})
}

function fnSubmit() {
	 
	var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var tel_rule = /^\d{2,3}\d{3,4}\d{4}$/; 
	var pw_rule = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,12}$/;
	var dt_rule = /^\d{4}\/\d{2}\/\d{2}$/;
	
	if ($("#userId").val() == null || $("#userId").val() == "") {
		alert("아이디를 입력해주세요.");
		$("#userId").focus();
		 
		return false;
	}
	 
	if ($("#idCheck").val() != 'Y') {
		alert("아이디 중복체크 해주세요.");
		//$("#result_idcheck").focus();
		 
		return false;
	}
	
	if ($("#password").val() == null || $("#password").val() == "") {
		alert("비밀번호를 입력해주세요.");
		$("#password").focus();
		 
		return false;
	}
	
	if(!pw_rule.test($("#password").val())){
		alert("비밀번호는 8~12자 영문+숫자or특수문자 조합으로 사용해야 합니다.");
		$("#password").focus();
		return false;
	}
	 
	if ($("#checkPassword").val() == null || $("#checkPassword").val() == "") {
		alert("비밀번호 확인을 입력해주세요.");
		$("#checkPassword").focus();
		 
		return false;
	}
	 
	if ($("#password").val() != $("#checkPassword").val()) {
		alert("비밀번호가 일치하지 않습니다.");
		$("#checkPassword").focus();
		 
		return false;
	}
	
	if ($("#userName").val() == null || $("#userName").val() == "") {
		alert("이름을 입력해주세요.");
		$("#userName").focus();
		 
		return false;
	}

	if ($("#birthDate").val() == null || $("#birthDate").val() == "") {
		alert("생년월일을 입력해주세요.");
		$("#birthDate").focus();
		 
		return false;
	}
	
	if(!dt_rule.test($("#birthDate").val())){
		alert("생년월일 형식에 맞게 입력해주세요. ex) 1900/01/01");
		$("#birthDate").focus();
		return false;
	}
	
	if ($("#phoneNumber").val() == null || $("#phoneNumber").val() == "") {
		alert("연락처를 입력해주세요.");
		$("#phoneNumber").focus();
		 
		return false;
	}
	 
	if( $("#email").val() && !email_rule.test($("#email").val())){
		alert("이메일을 형식에 맞게 입력해주세요. ex) thanos@drimaes.com");
		$("#email").focus();
		return false;
	}
	
	if(!tel_rule.test($("#phoneNumber").val())){
		alert("연락처를 형식에 맞게 입력해주세요. ex) 01012341234");
		$("#phoneNumber").focus();
		return false;
	}
	
	if (confirm("회원가입하시겠습니까?")) {
	 
		$("#join").submit();
		 
		return false;
	}
	}

</script>
</html>
