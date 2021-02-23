<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		fn_findId();
	});
	
	function fn_findId() {
		$('#findId_btn').on('click', function() {
			var m_id;
			var m_name = $('#m_name').val();
			var m_email = $('#m_email').val();
			var m_grade;
			var m_regdate;
			var year;
			var month;
			var day;
			var sendByFindId = {
				"m_name" : m_name,
				"m_email" : m_email
			};
			$.ajax({
				url: 'findId.do',
				type: 'post',
				data: JSON.stringify(sendByFindId),
				contentType: 'application/json',
				dataType: 'json',
				success: function(responseObj) {
					if (responseObj.findIdResult == 1) {
						m_id = responseObj.findIdId;
						m_grade = responseObj.findIdGrade;
						m_regdate = new Date(responseObj.findIdRegDate);
					    year = m_regdate.getFullYear();
					    month = (1 + m_regdate.getMonth());
					    month = month >= 10 ? month : '0' + month;
					    day = m_regdate.getDate();
					    day = day >= 10 ? day : '0' + day; 
						$('#findIdResult').empty();
						$('#findIdResult').append('<span style="display:block; font-size: 12px; font-weight: bold; text-align: center;">고객님 아이디 찾기가 완료 되었습니다.</span><br />');
						$('#findIdResult').append('<table style="font-size: 12px;"></table>');
						$('#findIdResult').append('<br/>');
						$('#findIdResult').append('<div id="btnContainer"></div>');
						$('#findIdResult > table').append('<tr></tr>');
						$('#findIdResult > table').append('<tr></tr>');
						$('#findIdResult > table').append('<tr colspan="2"></tr>');
						$('#findIdResult > table').append('<tr colspan="2"></tr>');
						$('#findIdResult > table > tr:nth-child(1)').append('<td style="width: 30%;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이름</td>');
						$('#findIdResult > table > tr:nth-child(1)').append('<td>' + m_name + '</td>');
						$('#findIdResult > table > tr:nth-child(2)').append('<td style="height: 30px;"><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;이메일</td>');
						$('#findIdResult > table > tr:nth-child(2)').append('<td>' + m_email + '</td>');
						$('#findIdResult > table > tr:nth-child(3)').append('<td><img src="https://i.esdrop.com/d/ig4sv0wXCF.png"/>&nbsp;아이디</td>');
						$('#findIdResult > table > tr:nth-child(3)').append('<td>' + m_id + ' (' + m_grade + ', ' + year + '-' + month + '-' + day + ' 가입)' + '</td>');
						$('#findIdResult > div').append('<a href="loginPage.do"><button class="inputBtn" >' + '로그인' + '</button></a> ');
						$('#findIdResult > div').append('<a href="findPasswordPage.do"><button class="inputBtn" >' + '비밀번호 찾기' + '</button></a>');
					} else if (responseObj.findIdResult == 0) {
						alert('이름을 입력하세요.');
						$('#m_name').focus();
					} else if (responseObj.findIdResult == -1) {
						alert('이메일을 입력하세요.');
						$('#m_email').focus();
					} else if (responseObj.findIdResult == -2) {
						alert('이메일 항목이 이메일 형식이 아닙니다.');
						$('#m_email').focus();
					} else if (responseObj.findIdResult == -3) {
						alert('입력하신 정보로 가입된 회원 아이디는 존재하지 않습니다.');
						location.reload();
					} else {
						alert('findIdResult == null');
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

#findIdContainer {
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
	Find Id
	</span><br /><br /><br />
<div id="findIdContainer">
	<div id="inputContainer">
		<span style="display:block; text-align: center; color: grey;">아이디 찾기</span><br />
		
		<span id="findIdResult">
			<table style="font-size: 12px;">
				<tbody>
					<tr>
						<td style="line-height: 1.2em" colspan="2">
						<span style="font-size: 11.5px;">가입하신 방법에 따라 아이디 찾기가 가능합니다.<br/>법인사업자 회원 또는 외국인 회원의 경우 법인명과 법인번호 또는 이름과 등록번호를 입력해 주세요.</span><br/><br/>
						</td>
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
				<button class="inputBtn" id="findId_btn">확인</button>
				<a href="loginPage.do"><button class="inputBtn" >취소</button></a>
			</div>
		</span>
	</div>
</div>
<br/><br/><br/><br/><br/>
<%@ include file="../template/footer.jsp"%>