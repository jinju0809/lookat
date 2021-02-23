<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		fn_findPassword();
	});
	
	function fn_findPassword() {
		$('#findPassword_btn').on('click', function() {
			var m_id = $('#m_id').val();
			var m_name = $('#m_name').val();
			var m_email = $('#m_email').val();
			var authKey;
			var userKey;
			var sendByFindPassword = {
				"m_id" : m_id,
				"m_name" : m_name,
				"m_email" : m_email
			};
			$.ajax({
				url: 'findPassword.do',
				type: 'post',
				data: JSON.stringify(sendByFindPassword),
				contentType: 'application/json',
				dataType: 'json',
				success: function(responseObj) {
					if (responseObj.findPasswordResult == 1) {
						$('#findPasswordResult').empty();
						$('#findPasswordResult2').empty();
						$('#findPasswordResult2').append('<table style="font-size: 12px;"></table>');
						$('#findPasswordResult2').append('<br/>');
						$('#findPasswordResult2').append('<div id="btnContainer"></div>');
						$('#findPasswordResult2 > table').append('<tr></tr>');
						$('#findPasswordResult2 > table').append('<tr></tr>');
						$('#findPasswordResult2 > table').append('<tr></tr>');
						$('#findPasswordResult2 > table > tr:nth-child(1)').append('<td style="width: 50%;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;아이디</td>');
						$('#findPasswordResult2 > table > tr:nth-child(1)').append('<td>' + m_id + '</td>');
						$('#findPasswordResult2 > table > tr:nth-child(2)').append('<td style="height: 30px;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이름</td>');
						$('#findPasswordResult2 > table > tr:nth-child(2)').append('<td>' + m_name + '</td>');
						$('#findPasswordResult2 > table > tr:nth-child(3)').append('<td><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이메일</td>');
						$('#findPasswordResult2 > table > tr:nth-child(3)').append('<td>' + m_email + '</td>');
						$('#findPasswordResult2 > div').append('<button class="inputBtn" id="sendEmailAuth_btn">' + '인증번호 전송' + '</button>');
 						$('#sendEmailAuth_btn').on('click', function() {
							$.ajax({
								url: 'emailAuth.do',
								type: 'post',
								data: JSON.stringify(sendByFindPassword),
								contentType: 'application/json',
								dataType: 'json',
								success: function(responseObj) {
									authKey = responseObj.authKey;
									$('#findPasswordResult2 > div').empty();
									$('#findPasswordResult2 > div').append('<input class="inputBtn" type="text" id="userKey" /> ');
									$('#findPasswordResult2 > div').append('<button class="inputBtn" id="emailAuthConfirm_btn">' + '인증번호 확인' + '</button>');
									$('#emailAuthConfirm_btn').on('click', function() {
										userKey = $('#userKey').val();
										var sendByEmailAuthConfirm = {
												"m_id" : m_id,
												"m_name" : m_name,
												"m_email" : m_email,
												"authKey" : authKey, 
												"userKey" : userKey 
										};
										$.ajax({
											url: 'emailAuthConfirm.do',
											type: 'post',
											data: JSON.stringify(sendByEmailAuthConfirm),
											contentType: 'application/json',
											dataType: 'json',
											success: function(responseObj) {
												if (responseObj.emailAuthConfirmResult == 1) {
													m_pw = responseObj.temporaryPw;
													alert('인증되었습니다.');
													$('#findPasswordResult2').empty();
													$('#findPasswordResult3').empty();
													$('#findPasswordResult3').append('<span style="display:block; font-size: 12px; font-weight: bold; text-align: center;">임시 비밀번호가 고객님 메일로 전송되었습니다.</span><br />');
													$('#findPasswordResult3').append('<table style="font-size: 12px;"></table>');
													$('#findPasswordResult3').append('<br />');
													$('#findPasswordResult3').append('<div id="btnContainer"></div>');
													$('#findPasswordResult3 > table').append('<tr></tr>');
													$('#findPasswordResult3 > table > tr:nth-child(1)').append('<td style="width: 20%"></td>');
													$('#findPasswordResult3 > table > tr:nth-child(1)').append('<td style="line-height: 1.2em">' + m_id + ' 회원님, 임시 비밀번호를<br />' + m_email + ' 으로 보내드렸습니다.<br />고객님 즐거운 쇼핑 하세요!</td>');
													$('#findPasswordResult3 > div').append('<a href="loginPage.do"><button class="inputBtn">' + '로그인' + '</button></a>');
												} else if (responseObj.emailAuthConfirmResult == 0) {
													alert('인증번호를 입력해주세요.');
													$('#userKey').focus();
												} else if (responseObj.emailAuthConfirmResult == -1) {
													alert('인증번호가 일치하지 않습니다.');
													$('#userKey').focus();
												} else {
													alert('emailAuthConfirmResult == null');
												}
											},
											error: function() {
												alert('AJAX FAIL');
											}
										});
									});
								},
								error: function() {
									alert('AJAX FAIL');
								}
							});
						}); 
					} else if (responseObj.findPasswordResult == 0) {
						alert('아이디 항목은 필수 입력값입니다.');
						$('#m_id').focus();
					} else if (responseObj.findPasswordResult == -1) {
						alert('아이디 항목이 아이디 형식이 아닙니다.');
						$('#m_id').focus();
					} else if (responseObj.findPasswordResult == -2) {
						alert('이름을 입력하세요.');
						$('#m_name').focus();
					} else if (responseObj.findPasswordResult == -3) {
						alert('이메일을 입력하세요.');
						$('#m_email').focus();
					} else if (responseObj.findPasswordResult == -4) {
						alert('이메일 항목이 이메일 형식이 아닙니다.');
						$('#m_email').focus();
					} else if (responseObj.findPasswordResult == -5) {
						alert('입력하신 [아이디 : ' + m_id + ']로 가입된 회원 아이디는 존재하지 않습니다.');
						location.reload();
					} else if (responseObj.findPasswordResult == -6) {
						alert('입력하신 정보로 가입된 회원은 존재하지 않습니다.');
						location.reload();
					} else {
						alert('findPasswordResult == null');
					}
				},
				error: function() {
					alert('AJAX FAIL');
				}
			});
		});
	}

</script>

<head>
<style type="text/css">
#inputContainer {
	width: 38%;
	margin: auto;
}

#findPwContainer {
	width: 55%;
	margin: auto;
	border: 1px solid lightgrey;
	padding: 30px;
}

.inputBtn {
	width: 25%;
	font-size: 10px;
	padding: 8px;
	background-color: white;
	border: 1px solid lightgrey;
	color: grey;
}

.textBox {
	border: 1px solid lightgrey;
	width: 100%;
}

#btnContainer {
	margin: auto;
	text-align: center;
}

img {
	width: 10px;
	padding-bottom: 5px;
}
</style>
</head>
<br/><br/>
	<span style="display:block; text-align: center; color: grey; font-size: 12px">
	Find Password
	</span><br /><br /><br />
<div id="findPwContainer">
	<div id="inputContainer">
		<span style="display:block; text-align: center; color: grey;">비밀번호 찾기</span><br />
		
		<span id="findPasswordResult">
			<table style="font-size: 12px;">
				<tbody>
					<tr>
						<td style="line-height: 1.2em" colspan="2">
						<span style="font-size: 11.5px;">가입하신 방법에 따라 아이디 찾기가 가능합니다.<br/>법인사업자 회원 또는 외국인 회원의 경우 법인명과 법인번호 또는 이름과 등록번호를 입력해 주세요.</span><br/><br/>
						</td>
					</tr>
					<tr>
						<td style="width:50%;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;아이디<div style="line-height: 30%"><br/><br/></div></td>
						<td><input class="textBox" type="text" id="m_id" /><div style="line-height: 30%"><br/><br/></div></td>
					</tr>
					<tr>
						<td style="width:50%;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이름<div style="line-height: 30%"><br/><br/></div></td>
						<td><input class="textBox" type="text" id="m_name" /><div style="line-height: 30%"><br/><br/></div></td>
					</tr>
					<tr>
						<td><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이메일로 찾기</td>
						<td><input class="textBox" type="text" id="m_email" /></td>
					</tr>
				</tbody>
			</table>
			<br/>
			<div id="btnContainer">
				<button class="inputBtn" id="findPassword_btn">확인</button>
				<a href="loginPage.do"><button class="inputBtn" >취소</button></a>
			</div>
		</span>
		<span id="findPasswordResult2"></span>
		<span id="findPasswordResult3"></span>
	</div>
</div>
<br/><br/><br/><br/><br/>


<%@ include file="../template/footer.jsp"%>