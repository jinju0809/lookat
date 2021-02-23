<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		fn_pwCheck();
		fn_changePassword();
	});
  	
  	function fn_pwCheck() {
		$('#c_pw2').keyup(function() {
			var regPw = /^(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9`~!@#$%^&*()-_=+]{8,16}$/;
			var c_pw = $('#c_pw').val();
			var c_pw2 = $('#c_pw2').val();
			if (regPw.test($('#c_pw').val()) && c_pw == c_pw2) {
				$('#pwCheckResult').text('비밀번호가 일치합니다.').css('color', 'blue');
			} else if (regPw.test($('#c_pw').val()) && c_pw != c_pw2) {
				$('#pwCheckResult').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
			} else {
				$('#pwCheckResult').text('');
			}
		});
  	}
	
	function fn_changePassword() {
		$('#changePassword_btn').on('click', function() {
			var m_id = $('#m_id').val();
			var m_pw = $('#m_pw').val();
			var c_pw = $('#c_pw').val();
			var c_pw2 = $('#c_pw2').val();
			var sendByChangePassword = {
				"m_id" : m_id,
				"m_pw" : m_pw,
				"c_pw" : c_pw,
				"c_pw2" : c_pw2
			};
			$.ajax({
				url: 'changePassword.do',
				type: 'post',
				data: JSON.stringify(sendByChangePassword),
				contentType: 'application/json',
				dataType: 'json',
				success: function(responseObj) {
					if (responseObj.changePasswordResult == 1) {
						alert('비밀번호를 변경하였습니다.');
						location.href = 'profilePage.do';
					} else if (responseObj.changePasswordResult == 0) {
						alert('비밀번호 항목은 필수 입력값입니다.');
						$('#m_pw').focus();
					} else if (responseObj.changePasswordResult == -1) {
						alert('새 비밀번호 항목은 필수 입력값입니다.');
						$('#c_pw').focus();
					} else if (responseObj.changePasswordResult == -2) {
						alert('새 비밀번호 입력 조건을 다시 한번 확인해주세요.\n\n'
								+ '※ 비밀번호 입력 조건\n'
								+ '- 영문 대소문자/숫자 조합, 8~16자\n'
								+ '- 입력 가능 특수문자\n'
								+ '   ` ~ ! @ # $ % ^ & * ( ) - _ = +');
						$('#c_pw').focus();
					} else if (responseObj.changePasswordResult == -3) {
						alert('새 비밀번호 확인 항목은 필수 입력값입니다.');
						$('#c_pw2').focus();
					} else if (responseObj.changePasswordResult == -4) {
						alert('새 비밀번호가 일치하지 않습니다.');
						$('#m_pw').focus();
					} else {
						alert('회원님의 현재 비밀번호가 일치하지 않습니다.');
						location.reload();
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
#changePasswordContainer {
	width: 40%;
	margin: auto;
}

#changePwTable {
	width: 100%;
}

#changePwTable>tbody>tr>td {
	border: 1px solid lightgrey;
	font-size: 12px;
	padding: 10px;
}

#pageTitleContainer {
	font-size: 12px;
}

.inputBtn {
	width: 20%;
	font-size: 10px;
	padding: 8px;
	background-color: white;
	border: 1px solid lightgrey;
	color: grey;
}

#btnContainer {
	text-align: center;
}

input {
	border: 1px solid lightgrey;
}
input[type=password] {
	font-family:-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto;
}
</style>
</head>
<div id="changePasswordContainer">
	<div id="pageTitleContainer">
		<div style="text-align: center;">비밀번호 변경</div><br /><br />
		회원님의 개인정보를 안전하게 보호하고, 개인정보 도용으로 인한 피해를 예방하기 위해<br />
		30일 이상 비밀번호를 변경하지 않은 경우 비밀번호 변경을 권장하고 있습니다.<br /><br />
	</div>
	<table id="changePwTable">
		<tbody>
			<tr>
				<td style="width:30%">아이디</td>
				<td>${loginDto.m_id}</td>
			</tr>
			<tr>
				<td>현재 비밀번호</td>
				<td><input type="password" id="m_pw" />	</td>
			</tr>
			<tr>
				<td>새 비밀번호 </td>
				<td><input type="password" id="c_pw" /> <span style="font-size: 11px ">(영문 대소문자/숫자 조합, 8~16자)</span></td>
			</tr>
			<tr>
				<td>새 비밀번호 확인</td>
				<td><input type="password" id="c_pw2" /> <span id="pwCheckResult" style="font-size: 11px" ></span></td>
			</tr>
			
		</tbody>
	</table>
	<br/>
	<div id="btnContainer">
		<button class="inputBtn" id="changePassword_btn">비밀번호 변경하기</button>
		<a href="profilePage.do"><button class="inputBtn">다음에 변경하기</button></a>
	</div>
	
	<!-- hidden -->
	<input type="hidden" id="m_id" value="${loginDto.m_id}" />
</div>
<br/>
<%@ include file="../template/footer.jsp"%>