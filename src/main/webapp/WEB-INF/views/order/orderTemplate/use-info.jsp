<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<head>
<style type="text/css">
#installment_UsingInformation {
	width: 100%;
}

#installment_UsingInformation>tbody>tr>td {
	border: 1px solid silver;
	padding: 10px;
}

#Homepage_UsingInformation>tbody>tr>td {
	padding: 10px;
}

#Homepage_UsingInformation {
	width: 100%;
}

#numbering {
	padding-left: 20px;
}

.tableHead {
	font-weight: 700;
	background-color: #fbfafa;
}

#crossBrowsingInfo {
	width: 100%;
}

#crossBrowsingInfo>tbody>tr>td {
	padding: 10px;
}

.ec-base-help>table {
	border: 1px solid silver;
}

.ec-base-help span {
	font-size: 15px;
}
</style>
</head>
<div class="use-info">
	<!-- 무이자 할부 이용안내 -->
	<div class="ec-base-help">
		<table id="installment_UsingInformation">
			<tbody>
				<tr>
					<td class="tableHead">무이자 할부 이용안내</td>
				</tr>
				<tr>
					<td style="padding-left: 20px; color: grey;">
					- 무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.<br />
					- 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br />
	<!-- 이용안내 -->
	<div class="ec-base-help">
		<table id="Homepage_UsingInformation">
			<tbody>
				<tr>
					<td style="font-weight: 700; background-color: #fbfafa; border-bottom: 1px solid silver">이용안내</td>
				</tr>
				<tr>
					<td>
						<span>WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.</span>
						<ol id="numbering">
							<li class="item">
								<a href="javascript:;" onClick="window.open('https://service-api.echosting.cafe24.com/shop/notice_XP_ActiveX.html','','width=795,height=500,scrollbars=yes',resizable=1);">
									안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치
								</a>
							</li>
							<li>
								<a href="http://www.microsoft.com/korea/windowsxp/sp2/default.asp" target="_blank">
									Service Pack 2에 대한 Microsoft사의 상세안내
								</a>
							</li>
						</ol>
					</td>
				</tr>
				<!-- 크로스 브라우징 지원 -->
				<tr>
					<td>
						<span>아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</span>
						<ol id="numbering">
							<li><strong>KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</strong></li>
							<li>
								결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능<br />
								(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)
							</li>
							<li>
								최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.<br />
								(무통장, 휴대폰결제 포함)
							</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td>
						<span>세금계산서 발행 안내</span>
						<ol id="numbering">
							<li class="item1">부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</li>
							<li class="item2">세금계산서는 사업자만 신청하실 수 있습니다.</li>
							<li class="item3">배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
							<li class="item4">[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</li>
							<li class="item5">[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td>
						<span>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</span>
						<ol id="numbering">
							<li class="item1">변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며</li>
							<li class="item2">신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
							<li class="item3">상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td>
						<span>현금영수증 이용안내</span>
						<ol id="numbering">
							<li class="item1">현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</li>
							<li class="item2">현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</li>
							<li class="item3">발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
							<li class="item4">현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</li>
							<li class="item5">현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
						</ol>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
