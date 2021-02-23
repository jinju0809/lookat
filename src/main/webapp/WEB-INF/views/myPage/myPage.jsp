<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- 머리글 포함(파라미터, title)가 있으므로 동적 페이지 포함 --%>
<jsp:include page="../template/header.jsp" />

<style type="text/css">
#container {
	margin: 0 auto;
	padding: 0;
}

#contents {
	width: 68%;
	margin: 0 auto;
	min-width: 300px;
	min-height: 500px;
	padding: 110px 0 50px 30px;
}

.path {
	display: none;
	overflow: hidden;
	height: 30px;
	line-height: 30px;
}

.titleArea h2 {
	display: inline-block;
	padding: 0 0;
	*display: inline;
	*zoom: 1;
	font-size: 12px;
	line-height: 20px;
	color: #000;
	font-weight: 300;
	letter-spacing: 0.5px;
	text-transform: capitalize;
}

.titleArea {
	min-height: 30px;
	margin: 0 0 50px;
	text-align: center;
}

.ec-base-box.typeMember .information {
	display: table;
	table-layout: fixed;
	padding: 10px 0;
	width: 100%;
	box-sizing: border-box;
	font-size: 11px;
}

.ec-base-box.typeMember .information .description {
	display: table-cell;
	padding: 0 10px 0 30px;
	width: auto;
	line-height: 1.5em;
	vertical-align: middle;
}

.ec-base-box {
	padding: 0px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #ddd;
	color: #777;
}

.xans-myshop-asyncbankbook .title {
	float: left;
	width: 32%;
	padding: 0 0 0 10px;
	font-weight: normal;
	box-sizing: border-box;
}

.xans-myshop-asyncbankbook ul li {
	float: left;
	margin: 5px 0;
	padding: 0 3%;
	width: 50%;
	height: 20px;
	font-size: 11px;
	line-height: 1.6;
	vertical-align: top;
	box-sizing: border-box;
}

li {
	list-style: none;
}

.xans-myshop-asyncbankbook .data {
	float: left;
	width: 47%;
	padding: 0 10px 0 10px;
	text-align: right;
	box-sizing: border-box;
	font-weight: normal;
}

.ec-base-box.gHalf {
	position: relative;
	padding: 0px 0;
}

.ec-base-box.gHalf:before {
	position: absolute;
	top: 0;
	left: 50%;
	display: block;
	content: "";
	width: 1px;
	height: 100%;
	background-color: #e6e6e6;
}

ul {
	display: block;
	list-style-type: disc;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	padding-inline-start: 40px;
}

.xans-myshop-orderstate {
	margin: 20px 0 0;
	border: 1px solid #ddd;
}

.xans-myshop-orderstate .title {
	padding: 11px 21px;
	margin: 0;
	border-bottom: 1px solid #e9e9e9;
	background: #fff;
}

.xans-myshop-orderstate .title h3 {
	padding: 0 0 0 8px;
	font-size: 12px;
	color: #555;
	font-weight: normal;
}

.xans-myshop-orderstate .desc {
	padding: 0 0 0 4px;
	font-weight: normal;
	font-size: 11px;
	color: #777;
}

.xans-myshop-orderstate .state {
	overflow: hidden;
	padding: 0px 0;
}

.xans-myshop-orderstate .order {
	float: left;
	width: 80%;
}

.xans-myshop-orderstate .order li {
	float: left;
	width: 25%;
	padding: 0 0 4px;
	margin: 0 -1px 0 0;
	border-right: 1px dotted #c9c7ca;
	text-align: center;
}

.xans-myshop-orderstate .order .count {
	font-size: 11px;
	color: #777;
}

#myshopMain {
	margin: 30px 0 0;
	border: 1px solid #ddd;
}

#myshopMain .shopMain {
	height: 120px;
	padding: 27px 0 0 30px;
	border-bottom: 1px solid #e9e9e9;
}

#myshopMain .shopMain p a {
	font-size: 11px;
	line-height: 18px;
	color: #aaa;
}

#myshopMain .shopMain h3 {
	padding: 0 0 5px;
	font-size: 11px;
	color: #888;
	font-weight: normal;
}

a {
	text-decoration: none;
	color: #000;
}

a:-webkit-any-link {
	cursor: pointer;
}

div, ul, li, p {
	margin: 0;
	padding: 0;
}

.xans-myshop-asyncbankbook .title {
	float: left;
	width: 32%;
	padding: 0 0 0 10px;
	font-weight: normal;
	background:
		url(//img.echosting.cafe24.com/skin/base/common/ico_arrow.png)
		no-repeat 0 6px;
	box-sizing: border-box;
}

.xans-myshop-asyncbenefit .description {
	min-height: 70px;
}

.xans-myshop-asyncbenefit {
	margin: 0 0 20px;
	color: #353535;
}

.xans-myshop-asyncbankbook ul:after {
	content: "";
	display: block;
	clear: both;
}

ul {
	display: block;
	list-style-type: disc;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.xans-myshop-orderstate .order li strong {
	display: block;
	margin: 2px 0 7px;
	font-size: 11px;
	color: #777;
	font-weight: normal;
}

.xans-myshop-orderstate .cs strong {
	font-weight: normal;
	font-size: 11px;
	color: #777;
}

.xans-myshop-orderstate .cs {
	float: left;
	width: 20%;
}

.xans-myshop-orderstate .cs li {
	margin: 0 0 5px 41px;
	letter-spacing: 0.04em;
	word-spacing: 4px;
}

li {
	text-align: -webkit-match-parent;
}

strong {
	word-break: break-all;
}

#myshopMain .shopMain h3 strong {
	font-size: 12px;
	padding: 0 8px 0 0;
	font-weight: normal;
	text-transform: uppercase;
}
</style>
<div id="contents">
	<div class="titleArea">
		<h2>MY PAGE</h2>
	</div>
	<div style="width: 80%; min-width: 588px; margin: 0 auto;">
		<div class="xans-element- xans-myshop xans-myshop-asyncbenefit">
			<div class="ec-base-box typeMember gMessage ">
				<div class="information">
					<div class="description">
						<span>
							저희 쇼핑몰을 이용해 주셔서 감사합니다.
							<strong class="txtEm">
							<span>
								<span class="xans-member-var-name"></span>
							</span>
							</strong>
							${loginDto.m_name}님은
							<strong>
								[
								<span class="displaynone"><img src="" alt="" class="myshop_benefit_group_icon_tag"></span>
								<span class="xans-member-var-group_name">${loginDto.m_grade}</span>
								<span class="myshop_benefit_ship_free_message"></span>
								]
							</strong>
							회원이십니다.
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="xans-element- xans-myshop xans-myshop-asyncbankbook ec-base-box gHalf">
			<ul>
				<li>
					<strong class="title">가용구매적립금</strong>
					<strong class="data use">
						<span id="xans_myshop_bankbook_avail_mileage"><fmt:formatNumber value="${loginDto.m_point}" pattern="###,###,###" />원</span>
					</strong>
				</li>
				<li>
					<strong class="title">총구매적립금</strong>
					<strong class="data">
						<span id="xans_myshop_bankbook_total_mileage"><fmt:formatNumber value="${loginDto.m_point}" pattern="###,###,###" />원</span>
					</strong>
				</li>
				<li>
					<strong class="title">쿠폰</strong>
					<strong class="data">
						<span id="xans_myshop_bankbook_total_mileage">${loginDto.m_coupon}개</span>
					</strong>
				</li>
			</ul>
		</div>
		<div class="xans-element- xans-myshop xans-myshop-orderstate ">
			<div class="title">
				<h3>나의 주문처리 현황</h3>
			</div>
			<div class="state">
				<ul class="order">
					<li>
						<strong>입금전</strong>
						<a href="orderCheckPage.do?m_no=${loginDto.m_no}&od=입금대기" class="count">
							<span id="xans_myshop_orderstate_shppied_before_count">${a}</span>
						</a>
					</li>
					<li>
						<strong>배송준비중</strong>
						<a href="orderCheckPage.do?m_no=${loginDto.m_no}&od=배송준비중" class="count">
							<span id="xans_myshop_orderstate_shppied_standby_count">${b}</span>
						</a>
					</li>
					<li>
						<strong>배송중</strong>
						<a href="orderCheckPage.do?m_no=${loginDto.m_no}&od=배송중" class="count">
							<span id="xans_myshop_orderstate_shppied_begin_count">${c}</span>
						</a>
					</li>
					<li>
						<strong>배송완료</strong>
						<a href="orderCheckPage.do?m_no=${loginDto.m_no}&od=배송완료" class="count">
							<span id="xans_myshop_orderstate_shppied_complate_count">${d}</span>
						</a>
					</li>
				</ul>
				<ul class="cs">
					<li>
						<span class="icoDot"></span>
						<strong>취소 : </strong>
						<a href="#" class="count">
							<span id="xans_myshop_orderstate_order_cancel_count">-</span>
						</a>
					</li>
					<li>
						<span class="icoDot"></span>
						<strong>교환 : </strong>
						<a href="#" class="count">
							<span id="xans_myshop_orderstate_order_exchange_count">-</span>
						</a>
					</li>
					<li>
						<span class="icoDot"></span>
						<strong>반품 : </strong>
						<a href="#" class="count">
							<span id="xans_myshop_orderstate_order_return_count">-</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="myshopMain" class="xans-element- xans-myshop xans-myshop-main">
			<div class="shopMain order">
				<h3>
					<a href="orderListPage.do?m_no=${loginDto.m_no}"><strong>order</strong>주문내역 조회</a>
				</h3>
				<p>
					<a href="orderListPage.do?m_no=${loginDto.m_no}">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</a>
				</p>
			</div>
			<div class="shopMain profile">
				<h3>
					<a href="profilePage.do"><strong>profile</strong>회원 정보</a>
				</h3>
				<p>
					<a href="profilePage.do">
						회원이신 고객님의 개인정보를 관리하는 공간입니다.<br>
						개인정보를 최신 정보로 유지하시면 보다 간편히 쇼핑을 즐기실 수 있습니다.
					</a>
				</p>
			</div>
			<div class="shopMain wishlist">
				<h3>
					<a href="cartListPage.do?m_no=${loginDto.m_no}"><strong>cart</strong>장바구니</a>
				</h3>
				<p>
					<a href="cartListPage.do?m_no=${loginDto.m_no}">장바구니에 담으신 상품의 목록을 보여드립니다.</a>
				</p>
			</div>
			<div class="shopMain board">
				<h3>
					<a href="queryReviewListPage.do?column=M_NO&query=${loginDto.m_no}"><strong>review</strong>리뷰</a>
				</h3>
				<p>
					<a href="queryReviewListPage.do?column=M_NO&query=${loginDto.m_no}">고객님께서 작성하신 리뷰를 한번에 볼 수 있습니다</a>
				</p>
			</div>
			<div class="shopMain address">
				<h3>
					<a href="profilePage.do"><strong>address</strong>배송 주소록 관리</a>
				</h3>
				<p>
					<a href="profilePage.do">회원정보페이지에서 배송지를 등록하고 관리하실 수 있습니다.</a>
				</p>
			</div>
		</div>
	</div>
</div>
<%@ include file="../template/footer.jsp"%>