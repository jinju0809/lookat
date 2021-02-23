<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" />

<head>
<style type="text/css">
#shopGuideContainer {
	width: 60%;
	margin: auto;
	font-size: 12px;
	color: grey;
}

#shopGuideTitle {
	text-align: center;
}

.smallTitle {
	font-weight: bold;
	color: FFA9A9A9;
}
</style>
</head>
<div id="shopGuideContainer">
	<div id="shopGuideTitle">SHOP GUIDE</div><br /><br />
	<div id="contentContainer">
		<span class="smallTitle">회원가입 안내</span><br />	<br />
		메뉴를 통해 이용약관, 개인정보보호정책 동의 및 일정 양식의 가입항목을 기입함으로써 회원에 가입되며, 가입 즉시 서비스를 이용하실 수 있습니다.<br />
		회원을 위한 이벤트 및 각종 할인행사에 참여하실 수 있습니다.<br /><br /><br /><br />
		<span class="smallTitle">주문 안내</span><br />	<br />
		상품주문은 다음단계로 이루어집니다.<br /><br />
		- Step1 : 상품검색<br />
		- Step2 : 장바구니에 담기<br />
		- Step3 : 회원ID 로그인 또는 비회원 주문<br />
		- Step4 : 주문서 작성<br />
		- Step5 : 결제방법선택 및 결제<br />
		- Step6 : 주문 성공 화면 (주문번호)<br /><br />
		비회원 주문인 경우 6단계에서 주문번호와 승인번호(카드결제시)를 꼭 메모해 두시기 바랍니다.<br />
		단, 회원인 경우 자동 저장되므로 따로 관리하실 필요가 없습니다.<br /><br /><br /><br />
		<span class="smallTitle">결제안내</span><br /><br />
		고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.<br />
		확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br /><br />
		무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. <br />
		주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 24시간 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br /><br /><br /><br />
		<span class="smallTitle">배송안내</span><br /><br />
		배송 방법 : 택배<br /> 배송 지역 : 전국지역<br />
		배송 비용 : 무료 : 주문 금액에 상관없이 배송비는 무료입니다.<br />
		배송 기간 : 3일 ~ 7일<br />
		배송 안내 : 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br />
		고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다.<br />
		다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br /><br /><br /><br />
		<span class="smallTitle">교환/반품안내</span><br />	<br />
		교환 및 반품이 가능한 경우<br />
		- 상품을 공급 받으신 날로부터 7일 이내<br />
		단, 개인 부주의로인해 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.<br />
		- 상품 불량, 오배송의 경우 30일 이내에 공식홈페이지를 통해 반품 또는 교환 접수를 하셔야 가능합니다.<br />
		보다 자세한 안내를 원하시면 고객센터로 문의 부탁 드립니다.<br /><br />
		교환 및 반품이 불가능한 경우<br />
		- 배송 완료 후 3일 이내에 공식홈페이지에 교환/반품 접수를 하지 않은채 상품을 보낸 경우<br />
		- 배송 완료 후 7일 이내에 상품이 도착하지 않은 경우<br />
		- 고객의 부주의로 상품에 변형이 있거나 훼손된 경우<br />
		(상품 TAG 제거, 향수 냄새, 음식물 냄새, 화장품 냄새, 제품수선 등)<br /><br />
		※ 사이즈 교환, 색상 교환 등 단순 변심에 의한 교환/반품은 고객부담으로 왕복택배비가 발생됩니다.<br /><br /><br /><br />
		<span class="smallTitle">환불안내</span><br /><br />
		환불시 반품 확인여부를 확인한 후 3영업일 이내에 결제 금액을 환불해 드립니다.<br />
		신용카드로 결제하신 경우는 신용카드 승인을 취소하여 결제 대금이 청구되지 않게 합니다.<br />
		신용카드 결제 취소 후 재입금 처리 소요일은 카드사 사정에 따라 1~3일 정도 소요 됩니다.<br />
		1~3일 이후에도 재입금 또는 결제 취소가 되지 않는다면 카드사로 문의 부탁드립니다.<br /><br /><br /><br />
		<span class="smallTitle">적립금 안내</span><br />
		- 적립금 이용기간은 1년입니다.<br />
		- 일반리뷰는 1,500원 지급 됩니다.<br />
		- 포토리뷰는 3,000원 지급 됩니다.<br />
		- 포토리뷰 + 카페 글쓰기(한 곳당 1,000원) = 4,000원 지급 됩니다.<br />
		- 포토리뷰 + 카페 글쓰기 두 곳 = 5,000원<br />
		- 회원탈퇴시 적립금은 자동 소멸됩니다.<br />
	</div>
</div>

<%@ include file="../template/footer.jsp"%>