<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp" />

<%
	request.setCharacterEncoding("UTF-8");
	String m_no = request.getParameter("m_no");
%>

<style>
.container {
	text-align: center;
	white-space: nowrap;
	overflow-x: scroll;
}

.container>table {
	width: 100%;
	border-top: white;
	border-left: white;
	border-right: white;
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
	margin-top: 100px;
}

.ordertable>tr>td {
	padding: 20px 10px;
}

.ordertable>tbody>tr>td>a {
	color: #F15B5B;
}

.ordertable>tbody>tr>td>a:hover {
	text-decoration: none;
	color: #00A6A9;
	font-weight: bold;
}
</style>
<div class="container">
	<strong>
		구매내역 <br />
		회원 번호 :<%= m_no %>
	</strong>
	<table border="1" class="ordertable">
		<c:forEach var="th" items="${orderList}" varStatus="j">
			<thead style="background-color: #DDE7E7;">
				<tr>
					<td>주문번호 ${th.o_regDate}_${th.o_no}</td>
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
											${orderDto.o_regDate} ${i.count}<br />
											<input type="hidden" value="${orderDto.o_idx}" name="o_idx" />
											<input type="hidden" value="${orderDto.o_no}" name="o_no" />
											<input type="hidden" value="${loginDto.m_no}" name="m_no" />
										</td>
										<td>
											<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
												${productDto.p_Name} ${productDto.p_Color}<br />
												[${productDto.p_Size}]
											</a>
										</td>
										<td><fmt:formatNumber pattern="#,###,##0">${productDto.p_Price}</fmt:formatNumber></td>
										<td>${orderDto.o_amount}</td>
										<c:set var="sum" value="${sum + orderDto.o_price}" />
									</tr>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
			</tbody>
		</c:forEach>
	</table>
	<div>
		총 합계:
		<fmt:formatNumber pattern="#,###,##0">
			<c:out value="${sum}" />
		</fmt:formatNumber>
		원
	</div>
</div>
<%@ include file="../template/footer.jsp"%>