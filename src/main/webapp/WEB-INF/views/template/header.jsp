<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
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
<style>
.logo>a>img {
	width: 100%;
	margin-left: 1.5em;
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
	unicode-range: U+002D;
	font-style: normal;
}

@font-face {
	font-family: "puren";
	src: url(resources/fonts/Typo_SSiGothic150.ttf);
	unicode-range: U+005F;
	font-style: normal;
}

* {
	font-family: 'puren', -apple-system, Roboto, "Helvetica Neue", Arial,
		"Noto Sans";
	font-style: normal;
}

.container-2 input#btninput {
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

.container-2 input#btninput::-webkit-input-placeholder {
	color: #65737e;
}

.container-2 input#btninput:-moz-placeholder { /* Firefox 18- */
	color: #65737e;
}

.container-2 input#btninput::-moz-placeholder { /* Firefox 19+ */
	color: #65737e;
}

.container-2 input#btninput:-ms-input-placeholder {
	color: #65737e;
}

.container-2 .icon {
	z-index: 1;
	color: #4f5b66;
	border-radius: 5px;
	margin-right: 20px;
	width: 30px;
	height: 27px;
}

.container-2 input#btninput:focus, .container-2 input#search:active {
	outline: none;
	width: 150px;
}

.container-2:hover input#btninput {
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

#leftMenu>li>a {
	font-weight: bold;
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
		<div>
			<div class="logo">
				<a href="index.do" class="opacity"><img src="https://i.esdrop.com/d/P3oalCVU2X.png" alt="LOOKAT"></a>
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
						<li><a href="adminPage.do" class="h2" style="color: #9F494C">&nbsp;&nbsp;Admin</a>
						</li>
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
					<form action="search.do" method="GET">
						<input id="btninput" type="text" name="search" placeholder="Search">
						<button class="icon" id="btnsearch">
							<i class="fas fa-search" style="line-height: 17px"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</header>
	<br />
	<br />
	<br />
	<br />
	<br />