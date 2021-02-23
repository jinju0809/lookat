<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../template/header.jsp" />

<style>
.into {
	text-align: center;
	font-weight: bold;
	height: 400px;
	padding: 170px 0px;
}

.into>div>input[type="button"] {
	border-radius: 5px;
	background-color: black;
	color: white;
	width: 20em;
	height: 5em;
	padding: 6px;
}

.into>div>input[type="button"]:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

.into {
	height: 500px;
}
</style>

<div class="into">
	<div>
		<input type="button" onclick="location.href='memberMGPage.do'" value="회원정보" />
	</div>
	<br />
	<div>
		<input type="button" onclick="location.href='memberDeliveryPage.do'" value="배송정보" />
	</div>
</div>

<%@ include file="../template/footer.jsp"%>