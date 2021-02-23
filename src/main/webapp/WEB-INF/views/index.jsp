<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="resources/css/index.css?after" rel="stylesheet">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>LOOKAT</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="resources/css/shop-homepage.css?after" rel="stylesheet">

<style type="text/css">
#lookatfooter {
	margin-top: 100px;
	bottom: 0;
	color: grey;
	font-size: 11px;
}

#leftFooterContainer {
	/* position:absolute; */
	bottom: 0;
	left: 0;
	padding-left: 20px;
	padding-bottom: 20px;
	color: grey;
	float: left;
}

.footerBtn {
	background-color: rgba(255, 255, 255, 0);
	border: none;
	color: white;
}

.footerBtn:hover {
	color: lightgrey;
}

#rightFooterContainer {
	/* position:absolute; */
	bottom: 0;
	right: 0;
	padding-right: 50px;
	padding-bottom: 20px;
	text-align: right;
	float: right;
}

#leftMenu>li>a {
	color: white !important;
}

#rightMenu>li>a {
	color: white;
}

.leftMenuDown>li>a {
	color: white !important;
}

@font-face {
	font-family: 'puren';
	src: url(resources/fonts/PureunJeonnam.ttf);
	font-style: normal;
	font-weight: normal;
}

@font-face {
	font-family: 'puren';
	src: url(resources/fonts/PureunJeonnam-Bold.ttf);
	font-style: normal;
	font-weight: bold;
}

@font-face {
	font-family: "puren";
	src: url(resources/fonts/Typo_SSiGothic150.ttf);
	unicode-range: U+002D, U+005F;
	font-style: normal;
}

@font-face {
	font-family: "puren";
	src: url(resources/fonts/Binggrae-Bold.ttf);
	unicode-range: U+002D !important;
	font-style: normal;
	font-weight: bold!imporatant;
}

* {
	font-family: 'puren';
	font-weight: bold !important;
}

.container-2 input#search {
	width: 0px;
	height: 27px;
	background: #2b303b;
	border: none;
	font-size: 10pt;
	float: left;
	color: #262626;
	padding-left: 5px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	color: #fff;
	-webkit-transition: width .55s ease;
	-moz-transition: width .55s ease;
	-ms-transition: width .55s ease;
	-o-transition: width .55s ease;
	transition: width .55s ease;
}

.container-2 input#search::-webkit-input-placeholder {
	color: #65737e;
}

.container-2 input#search:-moz-placeholder { /* Firefox 18- */
	color: #65737e;
}

.container-2 input#search::-moz-placeholder { /* Firefox 19+ */
	color: #65737e;
}

.container-2 input#search:-ms-input-placeholder {
	color: #65737e;
}

.container-2 .icon {
	/* position: absolute; */
	/* top: 50%;
  margin-left: 17px;
  margin-top: 17px; */
	z-index: 1;
	color: #4f5b66;
	border-radius: 5px;
	margin-right: 20px;
	width: 30px;
	height: 27px;
}

.container-2 input#search:focus, .container-2 input#search:active {
	outline: none;
	width: 150px;
}

.container-2:hover input#search {
	width: 150px;
}

.container-2:hover .icon {
	color: #93a2ad;
}

.fa-search {
	font-size: 17px !important;
}

.container-2 {
	position: relative;
	right: 20px;
	margin-left: 20px;
}

header {
	font-size: 14px !important;
}

.logo>a>img {
	width: 100%;
	margin-left: 1.5em;
}

.container-2>form {
	margin-right: 20px;
	position: absolute;
	right: -30px;
	top: 13px;
}

#topRightMenuContainer {
	margin-right: 5px;
	padding-top: 30px;
}

#topLeftMenuContainer {
	padding-top: 30px;
	margin-left: 30px;
}
</style>
<script>
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 500) {
				$('#MOVE_TOP_BTN').fadeIn();
			} else {
				$('#MOVE_TOP_BTN').fadeOut();
			}
			var scrollTo = $(window).scrollTop(), docHeight = $(document).height(), windowHeight = $(window).height();
			var scrollPercent = parseInt((scrollTo / (docHeight - windowHeight)) * 100);
			//스크롤 표시
			$('#MOVE_TOP_BTN h6').text(scrollPercent + "%");
		});

		$("#MOVE_TOP_BTN").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
	});
</script>
</head>
<body>
	<a id="MOVE_TOP_BTN" href="#">
		<div class="circle">
			<h6></h6>
			<span>↑</span>
		</div>
	</a>
	<header>
		<div style="color: white;">
			<div class="logo">
				<a href="index.do" class="opacity"><img src="https://i.esdrop.com/d/9XInY5Pspn.png" alt="LOOKAT" width="250px"></a>
			</div>
			<!-- top left 메뉴바-->
			<div id="topLeftMenuContainer">
				<ul id="leftMenu">
					<li><a href="productListPage.do" class="h2">Shop</a>
						<ul class="leftMenuDown">
							<li><a href="productCategoryPage.do?p_Category=OUTER">Outer</a></li>
							<li><a href="productCategoryPage.do?p_Category=TOP">Top</a></li>
							<li><a href="productCategoryPage.do?p_Category=SHIRTS">Shirts</a></li>
							<li><a href="productCategoryPage.do?p_Category=BOTTOM">Bottom</a></li>
							<li><a href="productCategoryPage.do?p_Category=BAG">Bag</a></li>
							<li><a href="productCategoryPage.do?p_Category=BLACKFRIDAY">BLACK FRI-DAY</a></li>
						</ul>
					</li>
					<li><a href="#" class="h2">Board</a>
						<ul class="leftMenuDown">
							<li><a href="noticeListPage.do">Notice</a></li>
							<li><a href="reviewListPage.do">Review</a></li>
							<li><a href="qnaListPage.do">Q&amp;A</a></li>
						</ul>
					</li>
					<li><a href="#" class="h2">Member</a>
						<ul class="leftMenuDown">
							<c:if test="${loginDto.m_no gt 0}">
								<li><a href="myPage.do?m_no=${loginDto.m_no}">MyPage</a></li>
								<li><a href="cartListPage.do?m_no=${loginDto.m_no}">Cart</a></li>
								<li><a href="orderListPage.do?m_no=${loginDto.m_no}">Order</a></li>
							</c:if>
							<c:if test="${empty loginDto.m_no}">
								<li><a href="loginPage.do">MyPage</a></li>
								<li><a href="loginPage.do">Cart</a></li>
								<li><a href="loginPage.do">Order</a></li>
							</c:if>
							<li><a href="https://www.cjlogistics.com/ko/tool/parcel/tracking" target="_blank" target="_blank">Delivery</a></li>
						</ul>
					</li>
					<c:if test="${loginDto.m_grade eq '관리자등급'}">
						<li><a href="adminPage.do" class="h2" style="color: #D77964 !important">&nbsp;&nbsp;Admin</a></li>
					</c:if>
				</ul>
			</div>
			<!-- top-right 메뉴바 -->
			<div id="topRightMenuContainer">
				<ul id="rightMenu">
					<c:if test="${loginDto.m_no gt 0}">
						<li><a href="cartListPage.do?m_no=${loginDto.m_no}">Cart <span>(${crt_count})</span></a></li>
					</c:if>
					<c:if test="${empty loginDto.m_no}">
						<li><a href="loginPage.do">Cart</a></li>
					</c:if>
					<c:if test="${not empty loginDto}">
						<li><a href="logout.do">Logout</a></li>
						<li><a href="profilePage.do">Profile</a></li>
					</c:if>
					<c:if test="${empty loginDto}">
						<li><a href="loginPage.do" class="log">Sign Up</a></li>
					</c:if>
				</ul>
				<br />
				<div class="container-2">
					<form id="fm" action="search.do" method="GET">
						<input id="search" type="text" name="search" placeholder="Search">
						<button class="icon">
							<i class="fas fa-search" style="line-height: 17px"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</header>
	
<!-- Bootstrap core JavaScript -->
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script src="resources/ViewVendor/jquery/jquery.min.js"></script>
<script src="resources/ViewVendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<div class="flubox">
	<div id="carouselExampleIndicators" class="carousel slide my-9" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			<!-- 리스트를 늘릴수록 아래의 하이픈바가 늘어나가면서 슬라이드가 추가되는방식. -->
		</ol>
		<!-- 중앙 900x350 배너 -->
		<div class="carousel-inner" role="listbox">
			<div class="carousel-item active">
				<img class="d-block img-fluid" src="https://i.esdrop.com/d/LidOKVTOmt.jpg" alt="First slide">
			</div>
			<div class="carousel-item">
				<img class="d-block img-fluid" src="https://i.esdrop.com/d/F04fbsYHAd.jpg" alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class="d-block img-fluid" src="https://i.esdrop.com/d/ddk2lEN8f0.jpg" alt="Third slide">
			</div>
		</div>
		<!-- 중앙 900x350 배너 화살표 -->
		<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> 
			<span class="sr-only">Next</span>
		</a>
	</div>
	<div class="row"></div>
</div>
<footer id="lookatfooter">
	<div id="leftFooterContainer">
		<input type="button" class="footerBtn" value="instagram" />
		<input type="button" class="footerBtn" value="facebook" /><br /><br />
		<span style="color: white;" id="leftFooterText">
			Opening Hours.Mon-Fri. 11:00 ~ 18:00. Closed, Sat Sun Holidays<br />
			Bank Info. 신한은행 1234-1234-1234. Account Holder : 김룩앳
		</span>
	</div>
	<div id="rightFooterContainer">
		<span id="rightFooterText">
			<input type="button" class="footerBtn" value="Shop Guide" onclick="location.href='shopGuide.do'" /><br />
			Company : Lookat(룩앳) Ceo : 윤세한 윤진주 이지상 임화경 김동욱 조재익 Tel : 010-1234-1234<br />
			Address : 서울특별시 마포구 서강로 136 아이비티워 2층,3층 E-mail : lookatspring@gmail.com<br />
			copyright © 2021 Lookat. All rights reserved. [Operator information]
		</span>
	</div>
</footer>
</body>
</html>