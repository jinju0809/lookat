<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
<style type="text/css">
#lookatfooter {
	margin-top: 100px;
	bottom: 0;
	color: grey;
	font-size: 11px;
}

#leftFooterContainer {
	padding-left: 20px;
	padding-bottom: 20px;
	color: grey;
	float: left;
}

.footerBtn {
	background-color: white;
	border: none;
	color: grey;
}

.footerBtn:hover {
	color: lightgrey;
}

#rightFooterContainer {
	padding-right: 20px;
	padding-bottom: 20px;
	text-align: right;
	float: right;
}
</style>
</head>

<!-- Bootstrap core JavaScript -->
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script src="resources/ViewVendor/jquery/jquery.min.js"></script>
<script src="resources/ViewVendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<footer id="lookatfooter">
	<div id="leftFooterContainer">
		<input type="button" class="footerBtn" value="instagram" />
		<input type="button" class="footerBtn" value="facebook" /><br />
		<span id="leftFooterText"> 
			Opening Hours. Mon-Fri. 11:00 ~ 18:00. Closed, Sat Sun Holidays<br />
			Bank Info. 신한은행 1234-1234-1234. Account Holder : 김룩앳
		</span>
	</div>
	<div id="rightFooterContainer">
		<span id="rightFooterText">
			<input type="button" class="footerBtn" value="Shop Guide" /><br />
			Company : Lookat(룩앳) Ceo : 윤세한 윤진주 이지상 임화경 김동욱 조재익 Tel : 010-1234-1234<br />
			Address : 서울특별시 마포구 서강로 136 아이비티워 2층,3층 E-mail : lookatspring@gmail.com<br />
			copyright © 2021 Lookat. All rights reserved. [Operator information]
		</span>
	</div>
</footer>
</body>
</html>