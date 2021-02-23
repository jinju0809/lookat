<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<script type="text/javascript">
  	$(document).ready(function() {
		fn_login();
	});
  	
  	function login() {
  		var m_id = $('#m_id').val();
		var m_pw = $('#m_pw').val();
		var sendByIdPw = {
			"m_id" : m_id,
			"m_pw" : m_pw
		}
		
		$.ajax({
			url: 'login.do',
			type: 'post',
			data: JSON.stringify(sendByIdPw),  // JSON -> String 형변환 후 컨트롤러로 보내는 String 타입의 JSON 데이터
			contentType: 'application/json',  // 컨트롤러로 보내는 데이터의 타입을 알려주기 위해
			dataType: 'json',
			success: function(responseObj) {  // 성공하면 받아오는 데이터
				if (responseObj.loginResult == 1) {
					alert(m_id + '님 환영합니다.')
					location.href = '${referer}';
				} else if (responseObj.loginResult == 0) {
					alert('아이디 항목은 필수 입력값입니다.')
					$('#m_id').focus();
				} else if (responseObj.loginResult == -1) {
					alert('패스워드 항목은 필수 입력값입니다.')
					$('#m_pw').focus();
				} else if (responseObj.loginResult == -2) {
					alert('패스워드 항목이 8자(개) 이상으로 해주십시오.')
					$('#m_pw').focus();
				} else if (responseObj.loginResult == -3) {
					alert('아이디 또는 비밀번호가 일치하지 않습니다.')
					$('#m_pw').focus();
					location.href='loginPage.do';
				} else {
					alert('loginResult == null')
				}
			},
			error: function() {
				alert('AJAX FAIL')
			}
		});
  	}
  	
	function fn_login() {
		$('#login_btn').on('click', function() {
			login();
		});
		$('#m_pw').keypress(function(event){
            if ( event.which == 13 ) {
            	login();
            }
       	});
	}  
</script>
<head>
	<style type="text/css">
		#loginContainer{
			width: 80%;
			display: block;
			margin: auto;
			text-align: center;
		}
		table>tbody>tr>td{
			padding : 2px 4px;
		}
		td>#login_btn{
			width : 100px;
			height: 80px;
			border : 1px solid black;
			background-color: white;
		}
		td>#login_btn:hover{
			background-color: black;
			color:white;
			transition-property: background-color, color;
			transition-duration: 0.6s;
		}
		.login_textbox{
			padding : 4px;
			width : 284px;
			height : 35px;
			font-size : 10px;
		}
		#alinks{
			text-align: left;
		}
		#alinks>a{
			font-size : 12px;
			color: black;
		}
		#alinks>a:hover{
			text-decoration: none;
			color: grey;
		}
		input[type=password] {
			font-family:-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto;
		}
	</style>
</head>
<div id="loginContainer">
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<table id="loginTable" style="display:inline;">
	<tbody>
		<tr>
		<td>
			<input class="login_textbox" type="text" id="m_id" name="m_id" placeholder="ID" /><br/>
		</td>
		<td rowspan="2">
			<button id="login_btn">Sign In</button>
		</td>
		<tr>
		<td>
			<input class="login_textbox" type="password" id="m_pw" name="m_pw" placeholder="PASSWORD" /><br/>
		</td>
		</tr>
		<tr>
		<td id="alinks" colspan = "2">
			<br>
			<a href="findIdPage.do">Find Id</a>&nbsp;&nbsp;&nbsp;
			<a href="findPasswordPage.do">Find Password</a>&nbsp;&nbsp;&nbsp;
			<a href="signUpPage.do">Join Us</a>
		</td>
		</tr>
	</tbody>
</table>
<br/><br/>
	
</div>

<%@ include file="../template/footer.jsp"%>