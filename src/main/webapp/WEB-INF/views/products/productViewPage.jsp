<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../template/header.jsp" />

<link href="resources/css/productViewPage.css?after" rel="stylesheet">

<script>
	$(function() {
		$("#std_Size").on("change", function() {
			// 선택된 데이터의 텍스트값 가져오기
			var p_No = $("select option:selected").val();
			var text = $("select option:selected").text();
			$('#p_No').val(p_No);
		});
	
		
		$('.getContent').on("click", function() {
			var currentRow = $(this).closest('tr');
			var detail = currentRow.next('tr');
			if (detail.is(":visible")) {
				detail.hide();
			} else {
				detail.show();
			}
		});
	});

	function fn_order(f) {
		var p_No = $("select option:selected").val();
		var m_no = $('#m_no').val();
		var size = $('#std_Size').val();
		var loginResult = $('#m_no').val();
		if (loginResult == '') {
			alert('로그인하세요');
			location.href = 'loginPage.do';
		} else if (size == "") {
			alert('사이즈를 선택하세요.');
		} else if (size == "out-of-stock") {
			alert('해당 제품은 품절입니다.');
		} else {
			$.ajax({
				url : 'getText', //RequestMapping의 value 작성한다.
				type : 'post', //RequestMapping의 method 작성
				data : 'p_No=' + p_No + '&m_no=' + loginResult, //controller로 보내는 값(파라미터로 보냄)
				dataType : 'text', //controller에게서 받아오는 값의 타입 (text/plain..)
				success : function(responseText) { //responseText: controller에게서 결과로 받아오는 값
					if (responseText == 1) {
						if (confirm('장바구니에 같은 상품이 담겨 있습니다. 지금 확인하시겠습니까?')) {
							location.href = "cartListPage.do?m_no="
									+ loginResult;
						} else {
							f.action = "order.do";
							f.submit();
						}
					} else {
						f.action = "order.do";
						f.submit();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		}
	}

	function fn_cart(f) {
		var p_No = $("select option:selected").val();
		var size = $('#std_Size').val();
		var loginResult = $('#m_no').val();
		if (loginResult == '') {
			alert('로그인하세요');
			location.href = 'loginPage.do';
		} else if (size == "") {
			alert('사이즈를 선택하세요.');
		} else if (size == "out-of-stock") {
			alert('해당 제품은 품절입니다.');
		} else {
			$.ajax({
				url : 'getText', //RequestMapping의 value 작성한다.
				type : 'post', //RequestMapping의 method 작성
				data : 'p_No=' + p_No + '&m_no=' + loginResult, //controller로 보내는 값(파라미터로 보냄)
				dataType : 'text', //controller에게서 받아오는 값의 타입 (text/plain..)
				success : function(responseText) { //responseText: controller에게서 결과로 받아오는 값
					if (responseText == 1) {
						if (confirm('장바구니에 같은 상품이 담겨 있습니다. 지금 확인하시겠습니까?')) {
							location.href = "cartListPage.do?m_no=" + loginResult;
						}
					} else {
						f.action = "cart.do";
						f.submit();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		}
	}
</script>
<form method="post">
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<!--    <h1 class="my-4">Shop Name</h1> -->
				<div class="list-group">
					<caption>기본 정보</caption>
					<table border="1" summary="">
						<tbody>
							<tr class=" xans-record-">
								<c:forEach var="productDto" items="${prodViewlist}">
									<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
										<td colspan="2">
											<span style="font-size: 13px; color: #000000;">
												${productDto.p_Name} [${productDto.p_Color}]
											</span>
										</td>
									</c:if>
								</c:forEach>
							</tr>
							<tr class=" xans-record-">
								<td colspan="2">
									<span style="font-size: 12px; color: #555555;"><br /><br />
										<h6>FABRIC</h6>
										<c:forEach var="productDto" items="${prodViewlist}">
											<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
												${productDto.p_Fabric}
											</c:if>
										</c:forEach><br /><br />
										<h6>INFORMATION</h6>
										<c:forEach var="productDto" items="${prodViewlist}">
											<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
												${productDto.p_Information}
											</c:if>
										</c:forEach><br /><br /><br />
									</span>
								</td>
							</tr>
							<tr class=" xans-record-">
								<th scope="row"><span style="font-size: 12px; color: #000000;">price</span></th>
								<td>
									<span style="font-size: 12px; color: #000000;">
										<strong id="span_product_price_text">
											<c:forEach 	var="productDto" items="${prodViewlist}">
												<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
													₩<fmt:formatNumber value="${productDto.p_Price}" pattern="###,###,###" />
												</c:if>
											</c:forEach>
										</strong>
										<input id="product_price" name="product_price" value="" type="hidden">
									</span>
								</td>
							</tr>
							<tr class=" xans-record-">
								<th scope="row"><span style="font-size: 12px; color: #555555;">적립금</span></th>
								<td>
									<span style="font-size: 12px; color: #555555;">
										<img src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_pay_money.gif" alt="무통장 입금 결제" style="margin-bottom: 2px;">
										<img src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_pay_card.gif" alt="신용카드 결제" style="margin-bottom: 2px;">
										<c:forEach var="productDto" items="${prodViewlist}">
											<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
												<fmt:formatNumber value="${productDto.p_Price * 0.01}" pattern="###,###,###" />원 (1%)
											</c:if>
										</c:forEach>
										<input id="product_price" name="product_price" value="" type="hidden">
									</span>
								</td>
							</tr>
							<tr class=" xans-record-">
								<th scope="row"><span style="font-size: 12px; color: #555555;">배송비</span></th>
								<td><span style="font-size: 12px; color: #555555;">무료</span></td>
							</tr>
							<tr id="inav">
								<td>SIZE</td>
								<td>
									<select id="std_Size" name="std_Size">
										<option value="">[필수] 옵션을 선택해 주세요</option>
										<c:forEach var="productDto" items="${prodViewlist}">
											<c:set var="ea" value="EA" />
											<c:if test="${productDto.p_Amount ne 0}">
												<option value="${productDto.p_No}">${productDto.p_Size} 남은재고:${productDto.p_Amount}</option>
												<c:set var="max" value="${productDto.p_Amount}"/>
											</c:if>
											<c:if test="${productDto.p_Amount eq 0}">
												<option value="out-of-stock">${productDto.p_Size} --품절</option>
												<%-- <span div="display-none" class="out-of-stuck">out-of-stuck</span> --%>
											</c:if>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr id="inav">
								<td>
									<div>구입 수량</div>
								</td>
								<!-- max 값 남은재고 최대수량으로 변경해주기 -->
								<td><input type="number" name="o_amount" id="o_amount" min="1" max="10" value="1" /><br/>
									</td>
							</tr>  
							<tr class="btntr">
								<td colspan="2">
									<input type="hidden" name="m_no" id="m_no" value="${loginDto.m_no}" />
									<!--수정  -->
									<input type="hidden" name="p_No" id="p_No" value="" /><br />
									<input type="button" id="btndo" class="addCart_btn" value="카트에 담기" onclick="fn_cart(this.form)" />
									<input type="button" id="btndo" value="구매하기" onclick="fn_order(this.form)" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- /.col-lg-3 -->
			<div class="col-lg-9">
				<div class="card mt-4">
					<c:forEach var="productDto" items="${prodViewlist}">
						<c:if test="${productDto.p_Size eq 'S' or productDto.p_Size eq 'FREE'}">
							<img src="${productDto.p_Image}" alt="">
						</c:if>
					</c:forEach>
					<div class="review">
						<div class="review-header">Review</div>
						<table class="review-table">
							<thead>
								<tr>
									<td id="number">번호</td>
									<td id="title">제목</td>
									<td>작성일</td>
									<td id="number">조회</td>
								</tr>
							</thead>
							<c:set var="count" value="1" />
							<c:if test="${not empty list}">
								<c:forEach var="reviewDto" items="${list}" varStatus="k">
									<c:forEach var="productDto" items="${prodViewlist}">
										<c:if test="${reviewDto.rv_p_no eq productDto.p_No}">
											<tr>
												<td id="number"><c:out value="${count}"/></td>
												<td><a href="javascript:void(0)" class="getContent">${reviewDto.rv_title}</a></td>
												<td>${reviewDto.rv_regDate}</td>
												<td id="number">${reviewDto.rv_hit}</td>
												<c:set var="count" value="${count + 1}" />
											</tr>
											<tr style="display: none;">
												<td colspan="4">
													<div id="imgs">
														<c:set var="uploadFileNames" value="${fn:split(reviewDto.rv_filename,'^')}" />
														<p>${reviewDto.rv_content}</p>
														<c:forEach var="uploadFileName" items="${uploadFileNames}">
															<img style="width: 300px;" alt="${uploadFileName}" src="resources/storage/${uploadFileName}"><br /><br />
														</c:forEach>
													</div>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:if>
							<c:if test="${count eq 0}">
								<tr>
									<td colspan="4">작성된 리뷰가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
					<!-- /.card -->
					
					<!-- QNA 만들기 -->
					<!-- QNA -->
					<div class="qna-header">Q / A</div>
						<table class="qna-table">
							<thead>
								<tr>
									<td id="number">번호</td>
									<td id="title">제목</td>
									<td>작성일</td>
									<td id="number">조회</td>
								</tr>
							</thead>
							<c:set var="count" value="0" />
							<c:if test="${not empty qnaList}">
								<c:set var="count" value="1" />
								<c:forEach var="qnaDto" items="${qnaList}" varStatus="p">
									<c:forEach var="productDto" items="${prodViewlist}">
										<c:if test="${qnaDto.q_p_no eq productDto.p_No}">
											<tr>
												
												<td id="number"><c:out value="${count}"/></td>
												<td><a href="javascript:void(0)" class="getContent">${qnaDto.q_title}</a></td>
												<td>${qnaDto.q_date}</td>
												<td id="number">${qnaDto.q_hit}</td>
												<c:set var="count" value="${count + 1}"/>
											</tr>
											<tr style="display: none;">
												<td colspan="4">
													<div id="imgs">
														<c:set var="uploadFileNames" value="${fn:split(qnaDto.q_filename,'^')}" />
														<p>${qnaDto.q_content}</p>
														<c:forEach var="uploadFileName" items="${uploadFileNames}">
															<img style="width: 300px;" alt="${uploadFileName}" src="resources/storage/${uploadFileName}"><br /><br />
														</c:forEach>
													</div>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:if>
							<c:if test="${count eq 0}">
								<tr>
									<td colspan="4">작성된 리뷰가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>
				<!-- /.qna -->
			</div>
			<!-- /.col-lg-9 -->
		</div>
	<!-- /.container -->
</form>

<%@ include file="../template/footer.jsp"%>