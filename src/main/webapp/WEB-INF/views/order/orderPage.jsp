<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../template/header.jsp" />

<%
	request.setCharacterEncoding("UTF-8");
	String o_amount = request.getParameter("o_amount");
%>

<script>
	$(document).ready(function() {
		var p_Price = $('.p_Price').val(); //물품가격
		var pp_Price = $('.pp_Price').text(); //물품전체가격
		var ps_Price = pp_Price; //배송비포함가격
		var pst_Price = ps_Price; //전체가격
		if (Number(pp_Price) < 50000) {
			ps_Price = Number(pp_Price) + 3000;
		}
		var ps_Price_comma = fn_addComma(ps_Price);
		var pst_Price_comma = fn_addComma(pst_Price);
		var pp_Price_comma = fn_addComma(pp_Price);
		$('.pp_Price_comma').text(pp_Price_comma);
		$('.ps_Price').html(ps_Price_comma);
		$('.pst_Price').text(pst_Price_comma);

		var myPoint = ${
			loginDto.m_point
		};
		var inputPoint = 0;
		var totalSalePoint = 0;
		$('#inputPoint').val(inputPoint);
		var prodPoint = $('.prodPoint').text();
		$('#prodPoint').html(prodPoint);

		var shipping_Fee = '무료';
		if (Number(pp_Price) < 50000) {
			shipping_Fee = '3000';
		}
		$('.shipping_Fee').text(shipping_Fee);
		$('#o_Price').val($.trim(pst_Price));
		
		//적립금 사용 기능
		$("#inputPoint").change(function() {
			inputPoint = $('#inputPoint').val();
			if (inputPoint > 2000) {
				alert('사용가능 구매적립금보다 많습니다. 구매적립금 사용금액을 다시 입력해주세요.');
				$('#inputPoint').val(0);
				$('.pst_Price').html(fn_addComma(ps_Price));
				$('#o_Price').val($.trim(pst_Price));
				$('.totalSalePoint').text(0);
			} else {
				$('.inputPoint').text(fn_addComma(inputPoint));
				totalSalePoint = fn_addComma(inputPoint);
				var x = Number(pst_Price) - Number(inputPoint); //Number(inputPoint) 
				$('.pst_Price').html(fn_addComma(x));
				$('#o_Price').val($.trim(x));
				$('.totalSalePoint').text(totalSalePoint);
			}
		});

		//결제수단 선택 기능
		$('.payment-deposit').css('display', 'none');
		$('input[type="radio"][name="payment"]').on('click', function() {
	 		var payment = $('input[type="radio"][name="payment"]:checked').val();
			if (payment == "1") {
				$('.payment-card').css('display', 'inline');
				$('.payment-deposit').css('display', 'none');
			}
			if (payment == "2") {
				$('.payment-card').css('display', 'none');
				$('.payment-deposit').css('display', 'inline');
			}
		});

		$('#newAddr').on('click', function() {
			$('#raddr1').val('');
			$('#raddr2').val('');
			$('#raddr3').val('');
			$('#rnote').val('');
		});
		fn_oldAddr();
	}); //ready function
	
	//가격표현
	function fn_addComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d)+)/g;
		return num.toString().replace(regexp, ',');
	}

	function fn_oldAddr() {
		var m_phone = '${memberDto.m_phone}';
		var first_phone = m_phone.substring(4, 8); // 수정필요
		var last_phone = m_phone.substring(m_phone.lastIndexOf("-") + 1);
		$('#rphone1_2').val(first_phone);
		$('#rphone1_3').val(last_phone);
		var raddr1 = '${memberDto.m_addr1}';
		var raddr2 = '${memberDto.m_addr2}';
		var raddr3 = '${memberDto.m_addr3}';
		$('#raddr1').val(raddr1);
		$('#raddr2').val(raddr2);
		$('#raddr3').val(raddr3);
		var rname = '${memberDto.m_name}';
		$('#rname').val(rname);
		var remail = '${memberDto.m_email}';
		$('#remail').val(remail);
	}

	function fn_pay(f) {
		var chkList = document.getElementsByName("chk").length;
		var target = '';
		for (var i = 0; i < chkList; i++) {
			target = (target + document.getElementsByName("chk")[i].value + ',');
		}
		var payment = $('input[type="radio"][name="payment"]:checked').val();
		if (!$('#raddr1').val() || !$('#raddr2').val()) {
			alert('주소를 입력하세요.');
		} else if (payment == "2") {
			if (!$('#deposit_name').val()) {
				alert('입금자명을 입력하세요');
			} else if ($('#bankaccount').val() != "1") {
				alert('은행 계좌를 선택하세요');
			} else if (!$('#payment-agree').is(":checked")) {
				alert('구매진행 동의여부를 확인하여 주시기 바랍니다.');
			} else {
				f.action = "orderInsert.do?target=" + target;
				f.submit();
			}
		} else {
			f.action = "orderInsert.do?target=" + target;
			f.submit();
		}
	}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function Postcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				if (extraRoadAddr !== '') {
					extraRoadAddr = '(' + extraRoadAddr + ')';
				}
				document.getElementById('raddr1').value = data.zonecode;
				document.getElementById('raddr2').value = roadAddr;
				if (roadAddr !== '') {
					document.getElementById('raddr3').value = extraRoadAddr;
				} else {
					document.getElementById('raddr3').value = '';
				}
			}
		}).open();
	}
</script>
<head>
<link href="resources/css/orderPage.css" rel="stylesheet">
<style type="text/css">
#orderPageContainer {
	width: 70%;
	margin: auto;
	font-size: 12px;
}

#order_form {
	width: 100%;
}

#tableContainer {
	width: 100%;
	margin: auto;
}

#order_form>h3 {
	font-size: 12px;
	margin: 20px 0px;
	text-align: center;
}

#order_form .login-info {
	width: 100%;
	border: 1px solid silver;
}

#order_form .login-info>tbody>tr>td {
	padding: 10px;
}

#order_form .prod-info2 {
	width: 100%;
	border-top: 1px solid silver;
}

#order_form .prod-info {
	width: 100%;
}

#order_form .ship-info {
	width: 100%;
}

#order_form .pay-info {
	width: 100%;
}

#order_form .prod-info>tbody {
	border: 1px solid silver;
}

#prod-infoTitle>th {
	padding: 10px;
}

#center>td {
	padding: 8px;
}

.prodPoint, .o_amount {
	color: grey;
}

#orderResultTableRow>td {
	padding: 20px;
	background: #fbfafa;
	border-top: 1px solid silver;
}

#order_form .ship-info>tbody>tr>.title {
	padding-left: 20px;
	width: 10%
}

#order_form .ship-info>tbody>tr>td {
	border: 1px solid silver;
	padding: 10px;
}

.ship-info input {
	padding: 2px;
	border: 1px solid lightgrey;
}

.pay-info-1, .pay-info-2 {
	width: 100%;
}

.pay-info {
	border: 1px solid silver;
}

.pay-info>tbody>tr>td {
	padding: 10px;
}

.pay-info-1>tbody {
	text-align: center;
	border: 1px solid grey;
}

.pay-info-1>tbody>tr>td {
	padding: 20px;
}

.pay-info-2>tbody>tr>.title {
	width: 10%;
	font-weight: 700;
	padding-left: 20px;
}

.pay-info-2>tbody>tr>td {
	border: 1px solid silver;
	padding: 10px;
}

#payBtn {
	width: 100%;
	height: 40px;
	border: none;
	background-color: black;
	color: white;
}
</style>
</head>
<div id="orderPageContainer">
	<!-- col-la-9 우측전체 -->
	<div id="tableContainer">
		<form id="order_form" name="order_form" method="post">
			<h3>
				ORDER/PAY <small>주문/결제</small>
			</h3>
			<div class="op-body">
				<div class="op-login-info">
					<table class="login-info">
						<tbody>
							<tr>
								<td rowspan="2" style="width: 10%; border-right: none; text-align: center;">
									<div class="rcp-body-left">혜택정보</div>
								</td>
								<td style="border-bottom: 1px solid silver;">
									<div class="rcp-body-right">${loginDto.m_name}님은 [${loginDto.m_grade}] 회원입니다.</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="rcp-body-right">가용구매적립금: <fmt:formatNumber value="${loginDto.m_point}" pattern="#,##0" /> &nbsp;&nbsp;&nbsp;&nbsp; 쿠폰: ${loginDto.m_coupon}개</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="op-prod-info">
					<table class="prod-info2" id="option">
						<tr style="background-color: #fff8f5;">
							<td style="padding: 10px; width: 100%;" colspan="9">
								<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
								상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
							</td>
						</tr>
					</table>
					<table class="prod-info" id="info">
						<thead>
							<tr id="prod-infoTitle" style="background-color: #FFE6E6; border: 1px solid silver;">
								<th></th>
								<th>이미지</th>
								<th>상품정보</th>
								<th>판매가</th>
								<th>수량</th>
								<th>구매적립금</th>
								<th>배송구분</th>
								<th>배송비</th>
								<th>합계</th>
							<tr>
						</thead>
						<tbody>
							<c:if test="${empty cartList}">
								<tr id="center">
									<td><input type="checkbox" name="chk" class="chk" value="${productDto.p_No}" /></td>
									<td style="width: 7%;"><img alt="" src="${productDto.p_Image}" style="width: 100%"></td>
									<td id="bor" style="text-align: left;">
										<span style="font-weight: bold">${productDto.p_Name} [${productDto.p_Color}]</span><br />
										<span style="font-weight: 400">| 옵션 : ${productDto.p_Size } |</span>
									</td>
									<td id="bor">
										<span class="p_Price">
											<fmt:formatNumber pattern="#,##0">${productDto.p_Price}</fmt:formatNumber>
										</span>
									</td>
									<td id="bor">
										<span class="o_amount">
											<input type="hidden" name="o_amount" id="o_amount" value="${o_amount}" />${o_amount}
										</span>
									</td>
									<td id="bor">
										<span class="prodPoint">
											<fmt:formatNumber value="${productDto.p_Price * 0.01}" pattern="#,##0" />원
										</span>
									</td>
									<td>기본배송</td>
									<td><span class="shipping_Fee"></span></td>
									<td>
										<span id="bor" class="p_Price">
											&#8361;
											<fmt:formatNumber value="${productDto.p_Price * o_amount}" pattern="#,##0" />원
										</span>
										<span class="p_Price_empty" style="display: none;">${productDto.p_Price * o_amount}</span>
									</td>
								</tr>
							</c:if>
							<c:if test="${not empty cartList}">
								<c:set var="sum" value="0" />
								<c:set var="pointsum" value="0" />
								<c:forEach var="cartDto" items="${cartList}" varStatus="l">
									<c:forEach var="productDto" items="${prodList}" varStatus="k">
										<c:if test="${k.index eq l.index}">
											<tr id="center">
												<td><input type="checkbox" name="chk" class="chk" value="${productDto.p_No}" /></td>
												<td><img alt="" src="${productDto.p_Image}" style="width: 100px"></td>
												<td>${productDto.p_Name}[${productDto.p_Color}] [${productDto.p_Size}]</td>
												<td id="bor">
													<span class="p_Price">
														<fmt:formatNumber pattern="#,##0">${productDto.p_Price}</fmt:formatNumber>
													</span>
												</td>
												<td>
													<span class="o_amount">
														<input type="hidden" name="o_amount" id="o_amount" value="${cartDto.crt_amount}" />${cartDto.crt_amount}
													</span>
												</td>
												<td>
													<span class="prodPoint">
														<fmt:formatNumber value="${productDto.p_Price * 0.01 * cartDto.crt_amount}" pattern="#,##0" />
													</span>
												</td>
												<td>기본배송</td>
												<td><span class="shipping_Fee"></span></td>
												<td>
													<span class="p_Price">
														<fmt:formatNumber value="${productDto.p_Price * cartDto.crt_amount}" pattern="#,##0" />원
													</span>
												</td>
											</tr>
											<c:set var="sum" value="${sum + (productDto.p_Price * cartDto.crt_amount)}" />
											<c:set var="pointsum" value="${pointsum + (productDto.p_Price * 0.01 * cartDto.crt_amount)}" />
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:if>
							<tr id="orderResultTableRow">
								<td style="text-align: center;" colspan="2">
									<span>[기본배송]</span>
									<span class="test"></span>
								</td>
								<td style="text-align: right;" colspan="7">
									<span>
										상품구매금액
										<strong>&#8361;
											<span class="pp_Price" style="display: none;">
											<c:if test="${not empty cartList}">
												<c:out value="${sum}" />
											</c:if>
											<c:if test="${empty cartList}">
												${productDto.p_Price * o_amount}
											</c:if>
											</span>
											<span class="pp_Price_comma"></span>
										</strong>
										+ 배송비
										<span class="shipping_Fee"></span>
										= 합계 :
										<strong>&#8361;
											<c:if test="${not empty cartList}">
												<span class="ps_Price"></span>
											</c:if>
											<c:if test="${empty cartList}">
												<span class="ps_Price"></span>
											</c:if>
										</strong>
									</span>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr style="background-color: #fff8f5; border-bottom: 1px solid silver;">
								<td style="padding: 10px; width: 100%;" colspan="9">
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
									상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
				<%-- op-prod-info --%>
				<div class="op-ship-info">
					<div class="order-rcp-info-head">
						<strong><span style="text-align: left">배송정보</span></strong>
						<div style="float: right;">
							<img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">는 필수 입력입니다.
						</div>
					</div>
					<br />
					<table class="ship-info">
						<tbody>
							<tr>
								<td class="title">배송지선택</td>
								<td>
									<input type="radio" id="addr" name="address" value="address" onclick="fn_oldAddr()" checked />기존배송지
									<input type="radio" id="newAddr" name="address" value="newAddress" onclick="fn_newAddress()" />새로운 배송지
								</td>
							</tr>
							<tr>
								<td class="title">
									받으시는 분
									<img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
								</td>
								<td>
									<input type="text" name="rname" id="rname" value="${loginDto.m_name}" />
								</td>
							</tr>
							<tr>
								<td class="title">
									주소
									<img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
								</td>
								<td>
									<input type="text" name="raddr1" id="raddr1" placeholder="우편번호" readonly />
									<a href="#none" onclick="Postcode()">
										<img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/btn_zipcode.gif" alt="우편번호" />
									</a><br /> 
									<!-- <input type="img" src="" onclick="Postcode()" value="우편번호 찾기" /><br/> -->
									<input type="text" name="raddr2" id="raddr2" size="30" placeholder="도로명주소" readonly /><br />
									<input type="text" name="raddr3" id="raddr3" size="30" placeholder="상세주소" />
									<span style="font-size: 13px; color: gray;">추가 주소를 입력해주세요</span>
								</td>
							</tr>
							<tr>
								<td class="title">
									휴대전화
									<img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
								</td>
								<td>
									<select style="border: 1px solid silver; padding: 2px;" id="rphone1_1" name="rphone1_1" fw-filter="isNumber&isFill" fw-label="수취자 전화번호" fw-alone="N" fw-msg="">
										<option value="010" checked>010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
										<option value="070">070</option>
									</select>
									-
									<input id="rphone1_2" name="rphone1_2" maxlength="4" fw-filter="isNumber&isFill" fw-label="수취자 전화번호" fw-alone="N" fw-msg="" size="4" type="text" />
									-
									<input id="rphone1_3" name="rphone1_3" maxlength="4" fw-filter="isNumber&isFill" fw-label="수취자 전화번호" fw-alone="N" fw-msg="" size="4" type="text" />
								</td>
							</tr>
							<tr>
								<td class="title">
									이메일
									<img src="//img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
								</td>
								<td><input type="text" name="remail" id="remail" value="" /></td>
							</tr>
							<tr>
								<td class="title">배송메시지</td>
								<td><textarea style="resize: none; border: 1px solid silver" id="rnote" name="rnote" maxlength="255" cols="70"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
				<br /><br />
				<%-- op-ship-info --%>
				<div class="op-payment">
					<div class="op-pay-price">
						<span style="font-size: 12px; font-weight: 600; padding: 10px;">결제 예정 금액</span><br />
						<table class="pay-info-1">
							<tr	style="background-color: #fbfafa; border-bottom: 1px solid silver;">
								<td>총 주문 금액</td>
								<td>총 할인 + 부가결제 금액</td>
								<td>총 결제예정 금액</td>
							</tr>
							<tr style="font-weight: 500; font-size: 14px">
								<td><strong>&#8361;<span class="ps_Price"></span></strong></td>
								<td><strong><span>&#8361;</span><span class="totalSalePoint"><fmt:formatNumber pattern="#,##0">0</fmt:formatNumber></span></strong></td>
								<td><strong><span>=&#8361;</span><span class="pst_Price"></span></strong></td>
							</tr>
						</table>
						<table class="pay-info-2">
							<tr>
								<td class="title">총 할인금액</td>
								<td style="font-weight: 700;"><span>&#8361;</span><span class="totalSale">0</span></td>
							</tr>
							<tr>
								<td class="title">총 부가결제금액</td>
								<td style="font-weight: 700;"><span>&#8361;</span><span class="inputPoint">0</span></td>
							</tr>
							<tr>
								<td class="title">구매적립금</td>
								<td>
									<input style="border: 1px solid silver" type="text" name="inputPoint" id="inputPoint" value="" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
									원 (총 사용가능 구매적립금 : <strong><fmt:formatNumber value="${loginDto.m_point}" pattern="#,##0" /></strong>원)<br /><br />
									- 구매적립금은 최소 0 이상일 때 결제가 가능합니다.<br />
									- 최대 사용금액은 제한이 없습니다.<br />
									- 1회 구매시 구매적립금 최대 사용금액은 2,000원입니다.<br />
									- 구매적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.<br />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<br /><br />
				<%-- op-pay-price --%>
				<div class="op-pay-method">
					<div style="padding: 5px; font-weight: 700;">
						<span>결제수단</span>
					</div>
					<table class="pay-info" id="paytable">
						<tr>
							<td style="border-bottom: 3px double silver; border-right: 1px solid black;">
								<div class="payment-choice">
									<input type="radio" name="payment" id="card" value="1" checked />
									<label for="card">&nbsp;카드결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="payment" id="deposit" value="2" />
									<label for="deposit">&nbsp;무통장입금</label>
								</div>
							</td>
							<td style="width: 20%;" colspan="2" id="bor">
								<span class="payment-card" id="bor">카드결제</span>
								<span class="payment-deposit" id="bor">무통장입금</span><br/>
								최종 금액
							</td>
						</tr>
						<tr>
							<td rowspan="4" style="border-right: 1px solid black; vertical-align: top;">
								<div class="payment-deposit">
									<div class="deposit-info" id="intable">
										입금자명&nbsp;&nbsp;&nbsp;
										<input style="width: 20%" type="text" name="deposit_name" id="deposit_name" /><br />
										<div style="line-height: 50%">
											<br />
										</div>
										입금은행&nbsp;&nbsp;&nbsp;
										<select style="padding: 2px; width: 20%;" id="bankaccount" name="bankaccount">
											<option value="-1">::: 선택해 주세요 :::</option>
											<option value="1">신한은행:110-123-12345 김사장</option>
										</select>
									</div>
									<br />
									<span>
										<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
										최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다
									</span><br />
									<span>
										<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
										소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
									</span>
								</div>
								<div class="payment-card">
									<div class="card-div">
										<span>
											<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
											최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.
										</span><br />
										<span>
											<img src="//img.echosting.cafe24.com/skin/base/common/ico_info.gif" />
											소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
										</span>
									</div>
								</div>
							</td>
							<td id="bor" colspan="2" style="text-align: right;">
								<span>&#8361;</span>
								<span class="pst_Price"></span>
								<input type="hidden" name="o_price" id="o_Price" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<span class="payment-deposit">
								<input type="checkbox" name="payment-agree" id="payment-agree" value="agree" />
								결제정보를 확인하였으며,<br />
								구매진행에 동의합니다.
								</span>
								<input type="hidden" name="prodPoint" id="prodPoint" value="" />
								<input type="hidden" name="m_no" value="${loginDto.m_no}" />
								<input type="hidden" name="p_No" value="${productDto.p_No}" />
								<input id="payBtn" type="button" class="pay" value="결제하기" onclick="fn_pay(this.form)" />
							</td>
						</tr>
						<tr style="border-bottom: 1px solid silver; border-top: 1px solid silver;">
							<td>총 적립예정금액</td>
							<td>
								<fmt:formatNumber pattern="#,##0">
									<c:if test="${not empty cartList}">
										<c:out value="${pointsum}" />
									</c:if>
									<c:if test="${empty cartList}">
										${productDto.p_Price * 0.01}
									</c:if>
								</fmt:formatNumber>원
							</td>
						</tr>
						<tr>
							<td>
								상품별 구매적립금<br />
								회원 구매적립금
							</td>
							<td>
								<fmt:formatNumber pattern="#,##0">
									<c:if test="${not empty cartList}">
										<c:out value="${pointsum}" />
									</c:if>
									<c:if test="${empty cartList}">
										${productDto.p_Price * 0.01}
									</c:if>
								</fmt:formatNumber>원<br />
								<span class="inputPoint"></span>원
							</td>
						</tr>
					</table>
				</div>
				<%-- op-pay-method --%>
			</div>
			<%-- op-body --%>
			<br />
			<jsp:include page="../order/orderTemplate/use-info.jsp" />
		</form>
	</div>
</div>
<%@ include file="../template/footer.jsp"%>