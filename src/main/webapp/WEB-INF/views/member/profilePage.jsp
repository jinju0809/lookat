<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<c:set var="loginPhone" value="${loginDto.m_phone}" />
<c:set var="loginEmail" value="${loginDto.m_email}" />
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
</style>
</head>
<div id="modifyContainer">
	<div id="titleContainer">
	<br/><br/><br/>
	회원 정보<br/>
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
				<td>${loginDto.m_id}</td>
			</tr>
			<tr>
				<td>이름 <span class="essential">*</span></td>
				<td>${loginDto.m_name}</td>
			</tr>
			<tr>
				<td>주소 <span class="essential">*</span></td>
				<td style="line-height: 0.5em">
					${loginDto.m_addr1}
					${loginDto.m_addr2}
					${loginDto.m_addr3}
				</td>
			</tr>
			<tr>
				<td>핸드폰 <span class="essential">*</span></td>
				<td>
					${fn:substring(loginPhone, 0, fn:indexOf(loginPhone,'-'))}-${fn:substring(loginPhone, fn:indexOf(loginPhone,'-') + 1, fn:length(loginPhone) - 5)}-${fn:substring(loginPhone, fn:length(loginPhone) - 4, fn:length(loginPhone))}
				</td>
			</tr>
			<tr>
				<td>이메일 <span class="essential">*</span></td>
				<td>${fn:substring(loginEmail, 0, fn:indexOf(loginEmail, '@'))}@${fn:substring(loginEmail, fn:indexOf(loginEmail, '@') + 1, fn:length(loginEmail))}</td>
			</tr>
			<tr>
				<td>적립금</td>
				<td><fmt:formatNumber value="${loginDto.m_point}" pattern="###,###,###" />원</td>
			</tr>
		</tbody>
	</table>
	<br/>
	<div id="btnContainer">
		<a href="modifyPage.do"><button class="inputBtn">회원정보수정</button></a>
		<a href="changePasswordPage.do"><button class="inputBtn">비밀번호변경</button></a>		
	</div>
</div>

<%@ include file="../template/footer.jsp"%>