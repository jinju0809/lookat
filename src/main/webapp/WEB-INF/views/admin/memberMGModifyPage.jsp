<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="../template/header.jsp" />

<%
	request.setCharacterEncoding("UTF-8");
	String m_no = request.getParameter("m_no");
%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(window).ready(function() {
		fn_onload_memberProfile();
	});

	$(document).ready(function() {
		fn_selectEmail();
		fn_postCode();
		fn_memberUpdate();
		fn_sendByPw();
	});

	function fn_onload_memberProfile() {
		var m_no = $('input:hidden[id="m_no"]').val();
		var m_phone;
		var m_email;
		$.ajax({
			url : 'member/' + m_no,
			type : 'get',
			dataType : 'json',
			success : function(responseObj) {
				if (responseObj.result == true) {
					m_phone = (responseObj.memberDto.m_phone).split('-');
					m_email = (responseObj.memberDto.m_email).split('@');
					$('input:text[id="m_id"]').val(responseObj.memberDto.m_id);
					$('input:hidden[id="m_pw"]').val(responseObj.memberDto.m_pw);
					$('input:text[id="m_name"]').val(responseObj.memberDto.m_name);
					$('input:text[id="m_addr1"]').val(responseObj.memberDto.m_addr1);
					$('input:text[id="m_addr2"]').val(responseObj.memberDto.m_addr2);
					$('input:text[id="m_addr3"]').val(responseObj.memberDto.m_addr3);
					$('input:text[id="m_phone1"]').val(m_phone[0]);
					$('input:text[id="m_phone2"]').val(m_phone[1]);
					$('input:text[id="m_phone3"]').val(m_phone[2]);
					$('input:text[id="m_email1"]').val(m_email[0]);
					$('input:text[id="m_email2"]').val(m_email[1]);
					$('select[id="m_grade"]').val(responseObj.memberDto.m_grade);
				}
			},
			error : function() {
				alert('AJAX FAIL');
			}
		});
	}

	function fn_selectEmail() {
		$('#selectEmail').change(function() {
			if ($('#selectEmail').val() == 'directly') {
				$('#m_email2').attr('disabled', false);
				$('#m_email2').attr('placeholder', '이메일을 입력하세요.')
				$('#m_email2').val('');
				$('#m_email2').focus();
			} else {
				$('#m_email2').val($('#selectEmail').val());
				$('#m_email2').attr('disabled', true);
			}
		});
	}

	function fn_memberUpdate() {
		$('#update_btn').on('click', function() {
			var m_no = $('#m_no').val();
			var m_id = $('#m_id').val();
			var m_name = $('#m_name').val();
			var m_addr1 = $('#m_addr1').val();
			var m_addr2 = $('#m_addr2').val();
			var m_addr3 = $('#m_addr3').val();
			var m_phone1 = $('#m_phone1').val();
			var m_phone2 = $('#m_phone2').val();
			var m_phone3 = $('#m_phone3').val();
			var m_phone = m_phone1 + '-' + m_phone2 + '-' + m_phone3;
			var m_email1 = $('#m_email1').val();
			var m_email2 = $('#m_email2').val();
			var m_email = m_email1 + '@' + m_email2;
			var m_grade = $('#m_grade').val();
			var sendByUpdate = {
				"m_no" : m_no,
				"m_id" : m_id,
				"m_name" : m_name,
				"m_addr1" : m_addr1,
				"m_addr2" : m_addr2,
				"m_addr3" : m_addr3,
				"m_phone" : m_phone,
				"m_email" : m_email,
				"m_grade" : m_grade
			};
			var updateCheck = confirm('회원정보를 수정하시겠습니까?');
			if (updateCheck) {
				$.ajax({
					url : 'memberMGUpdate.do',
					type : 'post',
					data : JSON.stringify(sendByUpdate),
					contentType : 'application/json',
					dataType : 'json',
					success : function(responseObj) {
						if (responseObj.result == 1) {
							alert('회원정보 수정이 완료되었습니다.');
							location.href = 'memberMGPage.do';
						} else if (responseObj.result == -1) {
							alert('이름 항목은 필수 입력값입니다.');
							$('#m_name').focus();
						} else if (responseObj.result == -2) {
							alert('휴대전화를 입력해주세요.');
							$('#m_phone').focus();
						} else if (responseObj.result == -3) {
							alert('이메일을 입력하세요.');
							$('#m_email').focus();
						} else if (responseObj.result == -4) {
							alert(m_email + '는 이미 사용중인 이메일입니다.');
							$('#m_email').focus();
						} else if (responseObj.result == -5) {
							alert('입력하신 이메일을 사용할 수 없습니다.');
							$('#m_email').focus();
						} else {
							alert('result == null');
						}
					},
					error : function() {
						alert('AJAX FAIL');
					}
				});
			}
		});
	}

	function fn_sendByPw() {
		$('#sendByPw_btn').on('click', function() {
			var m_id = $('#m_id').val();
			var m_email = $('#m_email1').val() + '@' + $('#m_email2').val();
			var sendByEmail = {
				"m_id" : m_id,
				"m_email" : m_email
			};
			var pwCheck = confirm('임시 비밀번호를 전송하시겠습니까?');
			if (pwCheck) {
				$.ajax({
					url : 'sendByPw.do',
					type : 'post',
					data : JSON.stringify(sendByEmail),
					contentType : 'application/json',
					dataType : 'json',
					success : function(responseObj) {
						alert(responseObj.m_email + '로 임시 비밀번호를 전송했습니다.');
						location.href = 'memberMGPage.do';
					},
					error : function() {
						alert('AJAX FAIL');
					}
				});
			}
		});

	}

	function fn_postCode() {
		$('#postCode_btn').on('click', function() {
			new daum.Postcode({
				oncomplete : function(data) {
					var roadAddr = data.roadAddress;
					var extraRoadAddr = '';
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					if (extraRoadAddr !== '') {
						extraRoadAddr = '(' + extraRoadAddr + ')';
					}
					document.getElementById('m_addr1').value = '(' + data.zonecode + ')';
					document.getElementById('m_addr2').value = roadAddr;
					if (roadAddr !== '') {
						document.getElementById('m_addr3').value = extraRoadAddr;
					} else {
						document.getElementById('m_addr3').value = '';
					}
				}
			}).open();
		});
	}
</script>

<head>
<style type="text/css">
#modifyContainer {
	width: 60%;
	margin: auto;
}

#titleContainer {
	color: grey;
	margin: auto;
	font-size: 12px;
	text-align: center;
}

#greetingContainer {
	border: 1px solid lightgrey;
	padding: 10px;
	padding-left: 30px;
	font-size: 12px;
	color: grey;
}

.essential {
	color: red;
	font-weight: bold;
}

#myInfo {
	width: 100%;
}

#myInfo>tbody>tr>td {
	border: 1px solid lightgrey;
	padding: 10px 5px 10px 20px;
	font-size: 12px;
}

td>input {
	border: 1px solid lightgrey;
}

#btnContainer {
	margin: auto;
	text-align: center;
}

.inputBtn {
	width: 10%;
	font-size: 10px;
	padding: 8px;
	background-color: white;
	border: 1px solid lightgrey;
	color: grey;
}

#m_addr1 {
	width: 45px;
	text-align: center;
}

#m_addr2, #m_addr3 {
	width: 400px;
	margin: 3px 0 0;
}
</style>
</head>

<!-- hidden -->
<input type="hidden" id="m_no" value="<%=m_no%>" />

<div id="modifyContainer">
	<div id="titleContainer">
		<br /><br /><br />
		회원 정보 수정
		<br /><br /><br /><br />
	</div>
	<table id="myInfo">
		<tbody>
			<tr>
				<td style="width: 10%">아이디 <span class="essential">*</span></td>
				<td><input type="text" id="m_id" readonly /></td>
			</tr>
			<tr>
				<td>이름 <span class="essential">*</span></td>
				<td><input type="text" id="m_name" /></td>
			</tr>
			<tr>
				<td>주소 <span class="essential">*</span></td>
				<td style="line-height: 0.5em">
					<input type="text" id="m_addr1" 	placeholder="우편번호" readonly />
					<button class="inputBtn" id="postCode_btn">우편번호 찾기</button><br />
					<input type="text" id="m_addr2" placeholder="도로명 주소" readonly /><br />
					<input type="text" id="m_addr3" placeholder="상세주소" /><br />
				</td>
			</tr>
			<tr>
				<td>핸드폰 <span class="essential">*</span></td>
				<td>
					<input type="hidden" id="firstPhone" />
					<select id="m_phone1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					-
					<input type="text" id="m_phone2" size="5" />
					-
					<input type="text" id="m_phone3" size="5" />
				</td>
			</tr>
			<tr>
				<td>이메일 <span class="essential">*</span></td>
				<td>
					<input type="text" id="m_email1" />
					@
					<input id="m_email2" placeholder="이메일을 선택하세요." />
					<select id="selectEmail">
						<option value="" disabled selected>E-Mail 선택</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="kakao.com">kakao.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.com">yahoo.com</option>
						<option value="directly" id="m_email2">직접 입력하기</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>등급</td>
				<td>
					<select id="m_grade">
						<option value="일반등급">일반등급</option>
						<option value="실버등급">실버등급</option>
						<option value="골드등급">골드등급</option>
						<option value="VIP등급">VIP등급</option>
						<option value="VVIP등급">VVIP등급</option>
						<option value="관리자등급">관리자등급</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	<br />
	<div id="btnContainer">
		<button class="inputBtn" id="update_btn">회원정보수정</button>
		<button class="inputBtn" id="sendByPw_btn">비밀번호전송</button>
		<a href="memberMGPage.do"><button class="inputBtn">취소하기</button></a>
	</div>
</div>

<%@ include file="../template/footer.jsp"%>