<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<jsp:include page="../template/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../template/orderViewTitle.jsp" />


<link href="resources/css/orderViewPage.css" rel="stylesheet">
<style type="text/css">
		#OrderView_Information>tbody>tr>td{
			padding: 10px;
		}
		#OrderView_Information{
			width : 100%;
		}
		#numbering{
			padding-left: 20px;
			padding-top: 0px;
		}
		.ec-base-help>table{
			border: 1px solid silver;
		}
		#span{
			font-size: 15px;
			padding-bottom:0px;
		}
	</style>

<script>

	function fn_cancel(f){
		if(confirm('주문을 취소하시겠습니까?')){
			f.action='orderCancel.do';
			f.submit();
		}
	}
	
	function fn_list(f){
		f.action = "orderListPage.do";
		f.submit();
	}

</script>


 <!-- Page Content -->
  <div class="container">
    <div class="row">
	<form action="orderListPage.do">
		<div class="col-lg-9">
		<span>주문 상품 정보</span>
		<div class="order-info">
			<table border="1" class="info">
			<c:forEach var="orderDto" items="${orderViewList}" varStatus="k">
				<c:if test="${k.index eq 0}">
				<tr>
					<td class="td1">주문일자</td>
					<td>${orderDto.o_regDate}</td>
				</tr>				
				<tr>
					<td>주문자</td>
					<td>${orderDto.o_name}</td> 
				</tr>				
				<tr>
					<td>주문처리상태</td>
					<c:if test="${orderDto.o_delivery ne '입금대기'}">
						<td>입금확인</td>
					</c:if>
					<c:if test="${orderDto.o_delivery eq '입금대기'}">
						<td>입금대기</td>
					</c:if>
				</tr>
				<tr>
					<td>사용 포인트</td>
					<td>
					<c:if test="${orderDto.o_point eq 0}">
					
					</c:if>
					<c:if test="${orderDto.o_point ne 0}">
					<fmt:formatNumber pattern="#,##0">${orderDto.o_point}</fmt:formatNumber> 
					</c:if>
					</td>
				</tr>
				</c:if>
				<input type="hidden" value="${orderDto.o_idx}" name="o_idx"/>
			</c:forEach>				
			</table>
		</div>
			<div class="prod-info">
				<table border="1" id="bocen">
					<thead >
						<tr id="trs">
							<td>이미지</td>
							<td>제품정보</td>
							<td>수량</td>
							<td>판매가</td>
							<td>배송구분</td>
							<td>주문처리상태</td>
							<td>취소/교환/반품</td>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty prodList}">
					<c:forEach var="orderDto" items="${orderViewList}" varStatus="j">
					<c:forEach var="productDto" items="${prodList}" varStatus="k">
					<c:if test="${k.index eq j.index}">
						<tr>
							<td id="cen">
								<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
									<img alt="" src="${productDto.p_Image}" style="width:100px">
								</a>
							</td>
							<td id="bold">
								<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">${productDto.p_Name} ${productDto.p_Color}<br/>[${productDto.p_Size}]</a>
							</td>
							<td>${orderDto.o_amount}</td>
							<td id="bold"><fmt:formatNumber value="${productDto.p_Price}" pattern="#,##0" /></td>
							<td>${orderDto.o_delivery}</td>
							<c:if test="${orderDto.o_delivery ne '입금대기'}">
							<td>입금확인</td>
							</c:if>
							<c:if test="${orderDto.o_delivery eq '입금대기'}">
							<td>입금대기</td>
							</c:if>
							<td>-</td>
						</tr>
					</c:if>
					</c:forEach>
					</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div> 
			<div class="rcp-info">
				<table border="1" class="info">
				<c:forEach var="orderDto" items="${orderViewList}" varStatus="k">
				<c:if test="${k.index eq 0}">
					<span>배송지 정보</span>
					<thead>
						<tr>
							<td class="td1">받는 사람</td>
							<td>${orderDto.o_name}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>연락처</td>
							<td>${orderDto.o_cellphone}</td>
						</tr>
						<tr>
							<td>받는 주소</td>
							<td>${orderDto.o_addr1} ${orderDto.o_addr2} ${orderDto.o_addr3}</td>
						</tr>
						<tr>
							<td>기타 사항</td>
							<td>
								<c:forEach var="deposit_name" items="${o_deposit}" varStatus="k">
									<c:if test="${k.count < 2}">${deposit_name}</c:if>
								</c:forEach>
							</td>
						</tr>
					</tbody>
					</c:if>
					</c:forEach>
				</table>
			</div>
			
			<div class="move-to-list" style="margin-bottom: 50px;">
					<input type="hidden" name="m_no" value="${loginDto.m_no}"/>
					<input type="button" value="주문취소 >" onclick="fn_cancel(this.form)"/>
					<input type="button" value="목록으로 이동" onclick="fn_list(this.form)"/>
			</div>
</form>
	
	<!-- 이용안내 -->
	<div class="ec-base-help">
	<table id="OrderView_Information">
		<tr>
			<td style="font-weight:700; background-color: #DDE7E7; border-bottom: 1px solid silver">
			이용안내
			</td>
		</tr>
		<tr>
			<td>
			<span id="span">신용카드매출전표 발행 안내</span>
			<p>신용카드 결제는 사용하는 PG사 명의로 발행됩니다.</p>
			</td>
		</tr>
		<tr>
			<td>
				<span id="span">세금계산서 발행 안내</span>
				<ol id="numbering">
					<li class="item1">부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</li>
					<li class="item2">세금계산서는 사업자만 신청하실 수 있습니다.</li>
					<li class="item3">배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
					<li class="item4">[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</li>
					<li class="item5">[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
					<li class="item6">세금계산서는 실결제금액에 대해서만 발행됩니다.(구매적립금과 할인금액은 세금계산서 금액에서 제외됨)</li>
				</ol>
			</td>
		</tr>
		<tr>
			<td>
				<span id="span">부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경 안내</span>
				<ol id="numbering">
					<li class="item1">변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며<br/>신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
					<li class="item2">상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
				</ol>
			</td>
		</tr>
		<tr>
			<td>
				<span id="span">현금영수증 이용안내</span>
				<ol id="numbering">
					<li class="item1">현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</li>
					<li class="item2">현금영수증 발행 금액에는 배송비는 포함되고, 구매적립금사용액은 포함되지 않습니다.</li>
					<li class="item3">발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
					<li class="item4">현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</li>
					<li class="item5">현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
				</ol>
			</td>
		</tr>
	</table>
	</div>
	
	</div><%-- col-la-9 --%>
	</div>
    <!-- /.row -->
  </div>
  <!-- /.container -->

 <%@ include file="../template/footer.jsp" %>