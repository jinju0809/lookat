<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/qnaTitle.jsp" />
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	function fn_pwConfirm(f) {
		if ('${qnaDto.q_pw}' != f.q_pw.value) {
			alert('비밀번호를 확인하세요.');
			return;
		} else {
			location.href = "qnaViewPage.do?q_no=${qnaDto.q_no}&page=${param.page}";
		}
	}
</script>
<style>
.container {
	height: 300px;
}

.container>table {
	text-align: center;
	width: 100%;
}

table>tbody>tr>td>input[type=button] {
	border-radius: 5px;
	background-color: black;
	color: white;
	width: 6em;
	margin-top: 10px;
	padding: 6px;
}

table>tbody>tr>td>input[type=button]:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

table>tbody>tr>td>input[type=password] {
	margin-top: 20px;
	border-radius: 5px;
	width: 150px;
}

input[type=password] {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto;
}
</style>
</head>
<form>
	<div class="container">
		<table>
			<tbody>
				<tr>
					<td>비밀번호 입력(${qnaDto.q_pw})</td>
				</tr>
				<tr>
					<td><input type="password" name="q_pw" />
				</tr>
				<tr>
					<td><input type="button" value="확인" onclick="fn_pwConfirm(this.form)" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>
<%@ include file="../template/footer.jsp"%>