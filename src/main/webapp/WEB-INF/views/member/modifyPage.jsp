<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	$(window).ready(function() {
		$('#m_phone1').val($('#firstPhone').val()).prop('selected', true);
	});
	
	$(document).ready(function() {
		fn_pwCheck();
		fn_pwCheck2();
		fn_selectEmail();
		fn_update();
		fn_delete();
		fn_postCode();
	});
	
  	function fn_pwCheck() {
		$('#m_pw').keyup(function() {
			// 영문 대소문자/숫자 조합, 8~16자
			var regPw = /^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9`~!@#$%^&*()-_=+]{8,16}$/;
			if (!(regPw.test($('#m_pw').val()))) {
				$('#pwCheckResult').text('영문 대소문자/숫자 조합, 8~16자').css('color', 'red');
			} else {
				$('#pwCheckResult').text('');
			}
		});
	}
  	
  	function fn_pwCheck2() {
		$('#m_pw2').keyup(function() {
			var regPw = /^(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9`~!@#$%^&*()-_=+]{8,16}$/;
			var m_pw = $('#m_pw').val();
			var m_pw2 = $('#m_pw2').val();
			if (regPw.test($('#m_pw').val()) && m_pw == m_pw2) {
				$('#pwCheckResult2').text('비밀번호가 일치합니다.').css('color', 'blue');
			} else if (regPw.test($('#m_pw').val()) && m_pw != m_pw2) {
				$('#pwCheckResult2').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
			} else {
				$('#pwCheckResult2').text('');
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
	
	function fn_update() {
		$('#update_btn').on('click', function() {
			var m_no = ${loginDto.m_no};
			var m_id = $('#m_id').val();
			var m_pw = $('#m_pw').val();
			var m_pw2 = $('#m_pw2').val();
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
			var sendByUpdate = {
				"m_no" : m_no,
				"m_id" : m_id,
				"m_pw" : m_pw,
				"m_pw2" : m_pw2,
				"m_name" : m_name,
				"m_addr1" : m_addr1,
				"m_addr2" : m_addr2,
				"m_addr3" : m_addr3,
				"m_phone" : m_phone,
				"m_email" : m_email
			};
			$.ajax({
				url: 'update.do',
				type: 'put',
				data: JSON.stringify(sendByUpdate),  // JSON -> String 형변환 후 컨트롤러로 보내는 String 타입의 JSON 데이터
				contentType: 'application/json',  // 컨트롤러로 보내는 데이터의 타입을 알려주기 위해
				dataType: 'json',
				success: function(responseObj) {  // 성공하면 받아오는 데이터
					if (responseObj.updateResult == 1) {
						alert('회원정보 수정이 완료되었습니다.');
						location.href = 'profilePage.do';
					} else if (responseObj.updateResult == 0) {
						alert('비밀번호 항목은 필수 입력값입니다.');
						$('#m_pw').focus();
					} else if (responseObj.updateResult == -1) {
						alert('비밀번호가 일치하지 않습니다.');
						$('#m_pw2').focus();
					} else if (responseObj.updateResult == -2) {
						alert('입력하신 패스워드 정보가 올바르지 않습니다.');
						$('#m_pw').focus();
					} else if (responseObj.updateResult == -3) {
						alert('이름 항목은 필수 입력값입니다.');
						$('#m_name').focus();
					} else if (responseObj.updateResult == -4) {
						alert('휴대전화를 입력해주세요.');
						$('#m_phone').focus();
					} else if (responseObj.updateResult == -5) {
						alert('이메일을 입력하세요.');
						$('#m_email').focus();
					} else if (responseObj.updateResult == -6) {
						alert(m_email + '는 이미 사용중인 이메일입니다.');
						$('#m_email').focus();
					} else if (responseObj.updateResult == -7) {
						alert('입력하신 이메일을 사용할 수 없습니다.');
						$('#m_email').focus();
					} else {
						alert('updateResult == null');
					} 
				},
				error: function() {
					alert('AJAX FAIL');
				}
			});
		});

	}
	
	function fn_delete() {
		$('#delete_btn').on('click', function() {
			var m_no = ${loginDto.m_no};
			var m_id = $('#m_id').val();
			var m_pw = $('#m_pw').val();
			var m_pw2 = $('#m_pw2').val();
			var sendByDelete = {
				"m_id" : m_id,
				"m_pw" : m_pw,
				"m_pw2" : m_pw2
			};
			var m_point = ${loginDto.m_point};
			var deleteCheck = confirm('[현재 적립금] ' + m_point + '\n탈퇴하면 적립금이 삭제 됩니다.\n정말로 탈퇴 하시겠습니까?');
			if (deleteCheck) {
				$.ajax({
					url: 'member/' + m_no,
					type: 'delete',
					data: JSON.stringify(sendByDelete),  // JSON -> String 형변환 후 컨트롤러로 보내는 String 타입의 JSON 데이터
					contentType: 'application/json',
					dataType: 'json',
					success: function(responseObj) {  // 성공하면 받아오는 데이터
						if (responseObj.deleteResult == 1) {
							alert('탈퇴처리되었습니다. 그동안 이용해주셔서 감사합니다.');
							location.href = 'index.do';
						} else if (responseObj.deleteResult == 0) {
							alert('비밀번호를 입력하세요.');
							$('#m_pw').focus();
						} else if (responseObj.deleteResult == -1) {
							alert('비밀번호가 일치하지 않습니다.');
							$('#m_pw2').focus();
						} else if (responseObj.deleteResult == -2) {
							alert('입력하신 패스워드 정보가 올바르지 않습니다.');
							$('#m_pw').focus();
						} else {
							alert('탈퇴처리가 실패했습니다.');
							location.reload();
						}
					},
					error: function() {
						alert('AJAX FAIL');
					}
				});
			}
		});
	}
	
	function fn_postCode() {
		$('#postCode_btn').on('click', function() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = '(' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('m_addr1').value = '(' + data.zonecode + ')';
					document.getElementById('m_addr2').value = roadAddr;

					// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
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
input[type=password] {
	font-family:-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto;
	width: 161px;
}
</style>
</head>
<c:set var="loginPhone" value="${loginDto.m_phone}" />
<c:set var="loginEmail" value="${loginDto.m_email}" />
<div id="modifyContainer">
	<div id="titleContainer">
	<br/><br/><br/>
	회원 정보 수정<br/>
	<br/><br/><br/>
	</div>
	<div id="greetingContainer">
	저희 쇼핑몰을 이용해 주셔서 감사합니다. ${loginDto.m_name} 님은 <span style="font-weight: bold">[${loginDto.m_grade}]</span> 회원이십니다.
	</div>
	<br/>
	<table id="myInfo">
		<tbody>
			<tr>
				<td style="width:10%">아이디 <span class="essential">*</span></td>
				<td><input type="text" id="m_id" value="${loginDto.m_id}"  readonly /></td>
			</tr>
			<tr>
				<td>비밀번호 <span class="essential">*</span></td>
				<td>
					<input type="password" id="m_pw" />
					<span id="pwCheckResult"></span>
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인 <span class="essential">*</span></td>
				<td>
					<input type="password" id="m_pw2" />
					<span id="pwCheckResult2"></span>
				</td>				
			</tr>
			<tr>
				<td>이름 <span class="essential">*</span></td>
				<td><input type="text" id="m_name" value="${loginDto.m_name}" /></td>
			</tr>
			<tr>
				<td>주소 <span class="essential">*</span></td>
				<td style="line-height: 0.5em">
					<input type="text" id="m_addr1" value="${loginDto.m_addr1}" placeholder="우편번호" readonly />
					<button class="inputBtn" id="postCode_btn">우편번호 찾기</button><br />
					<input type="text" id="m_addr2" value="${loginDto.m_addr2}" placeholder="도로명 주소" readonly /><br />
					<input type="text" id="m_addr3" value="${loginDto.m_addr3}" placeholder="상세주소" /><br />
				</td>
			</tr>
			<tr>
				<td>핸드폰 <span class="essential">*</span></td>
				<td>
					<input type="hidden" id="firstPhone" value="${fn:substring(loginPhone, 0, fn:indexOf(loginPhone,'-'))}" />	
					<select id="m_phone1" >
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					-
					<input type="text" id="m_phone2" value="${fn:substring(loginPhone, fn:indexOf(loginPhone,'-') + 1, fn:length(loginPhone) - 5)}" size="5" />
					-
					<input type="text" id="m_phone3" value="${fn:substring(loginPhone, fn:length(loginPhone) - 4, fn:length(loginPhone))}" size="5" />
				</td>
			</tr>
			<tr>
				<td>이메일 <span class="essential">*</span></td>
				<td>
					<input type="text" id="m_email1" value="${fn:substring(loginEmail, 0, fn:indexOf(loginEmail, '@'))}" />
					@
					<input id="m_email2" placeholder="이메일을 선택하세요." value="${fn:substring(loginEmail, fn:indexOf(loginEmail, '@') + 1, fn:length(loginEmail))}">
					<select id="selectEmail" >
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
		</tbody>
	</table>
	<br/>
	<div id="btnContainer">
		<button class="inputBtn" id="update_btn">회원정보수정</button>
		<a href="profilePage.do"><button class="inputBtn">취소하기</button></a>
		<button class="inputBtn" id="delete_btn">회원탈퇴</button>
	</div>
</div>

<%@ include file="../template/footer.jsp"%>