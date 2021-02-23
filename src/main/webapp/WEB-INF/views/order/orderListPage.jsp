<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/orderListTitle.jsp" />

<link href="resources/css/orderListPage.css" rel="stylesheet">

<script>
	$(function() {
		var orderResult = ${orderResult};
		if (orderResult > 0) {
			alert('결제가 완료되었습니다.');
		}
		var deleteResult = ${deleteResult};
		if (deleteResult > 0) {
			alert('주문이 취소되었습니다.');
		}
	});

	function fn_cancel(f) {
		if (confirm('주문을 취소하시겠습니까?')) {
			f.action = 'orderCancel.do';
			f.submit();
		}
	}
</script>

<form>
	<c:if test="${empty loginDto.m_no}">
		로그인 후에 주문조회를 이용할 수 있습니다.
	</c:if>
	<c:if test="${not empty loginDto.m_no}">
		<!-- Page Content -->
		<div class="container">
			<div class="row">
				<div class="col-lg-9">
					<div id="info">주문 상품 정보</div>
					<table border="1" class="ordertable">
						<c:forEach var="th" items="${orderList}" varStatus="j">
							<thead style="background-color: #DDE7E7;">
								<tr>
									<td><a href="orderView.do?o_idx=${th.o_idx}">주문번호 ${th.o_regDate}_${th.o_no}</a></td>
									<td>ITEM</td>
									<td>상품정보</td>
									<td>가격</td>
									<td>수량</td>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty prodList}">
									<c:forEach var="orderDto" items="${list}" varStatus="l">
										<c:forEach var="productDto" items="${prodList}" varStatus="k">
											<c:if test="${k.index eq l.index}">
												<c:if test="${th.o_idx eq orderDto.o_idx}">
													<tr>
														<td>
															${orderDto.o_regDate}${i.count}<br />
															<input type="hidden" value="${orderDto.o_idx}" name="o_idx" />
															<input type="hidden" value="${orderDto.o_no}" name="o_no" />
															<input type="hidden" value="${loginDto.m_no}" name="m_no" />
														</td>
														<td>
															<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
																<img alt="" src="${productDto.p_Image}" style="width: 100px">
															</a>
														</td>
														<td>
															<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
																${productDto.p_Name} ${productDto.p_Color}<br />
																[${productDto.p_Size}]
															</a>
														</td>
														<td><fmt:formatNumber value="${productDto.p_Price}" pattern="###,###,###" /></td>
														<td>${orderDto.o_amount}</td>
													</tr>
												</c:if>
											</c:if>
										</c:forEach>
									</c:forEach>
								</c:if>
							</tbody>
						</c:forEach>
					</table>
					<table>
						<tr>
							<td colspan="5">${paging}</td>
						</tr>
					</table>
				</div>
				<!-- /.col-lg-9 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</c:if>
</form>

<%@ include file="../template/footer.jsp"%>