<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/cartTitle.jsp" />
<link href="resources/css/cartListPage.css?after" rel="stylesheet">

<script>
	//javascript
	onload = function() {

		//전체선택 시 개별선택 전부 영향
		var chkAll = document.getElementById('chkAll'); //id가 chkAll인 것
		chkAll.addEventListener('click', function() {
			var chk_list = document.getElementsByClassName('chk'); //name이 chk인것들
			for (let i = 0; i < chk_list.length; i++) {
				chk_list[i].checked = chkAll.checked;
			}
		});

		//개별 선택이 전체 선택 결과에 영향
		var chk_list = document.getElementsByClassName('chk');
		for (let i = 0; i < chk_list.length; i++) {
			chk_list[i].addEventListener('click', function() {
				var chkAll = document.getElementById('chkAll');
				for (let j = 0; j < chk_list.length; j++) {
					if (chk_list[j].checked == false) { //checked 속성이 없다면
						chkAll.checked = false;
						return; //반복문탈출
					}
				}
				chkAll.checked = true;
			});
		}
		var cartDelResult = '${cartDelResult}';
		if (cartDelResult != null && cartDelResult > 0) {
			alert('삭제되었습니다.');
		}
	} //onready function
	
	function fn_selectDel(f) {
		var chkList = document.getElementsByName("chk").length;
		var target = '';
		for (var i = 0; i < chkList; i++) {
			if (document.getElementsByName("chk")[i].checked == true) {
				target = (target + document.getElementsByName("chk")[i].value + ',');
			}
		}
		if (target == '') {
			alert('선택된 상품이 없습니다.');
		} else if (target != '') {
			if (confirm('선택하신 상품을 장바구니에서 삭제합니다.')) {
				f.action = "cartDelete.do?target=" + target + "&page=${page}";
				f.submit();
			}
		}
	}
	
	function fn_selectOrd(f) {
		var chkList = document.getElementsByName("chk").length;
		var target = '';
		for (var i = 0; i < chkList; i++) {
			if (document.getElementsByName("chk")[i].checked == true) {
				target = (target + document.getElementsByName("chk")[i].value + ',');
			}
		}
		if (target == '') {
			alert('선택된 상품이 없습니다.');
		} else if (target != '') {
			f.action = "order.do?target=" + target;
			f.submit();
		}
	}
	
	function fn_orderAll(f) {
		var target = 'all';
		f.action = "order.do?target=" + target;
		f.submit();
	}
</script>

<script>
	$(function() {
		$('.cartChange').on('click', function() {
			var tr = $(this).parent().parent();
			var td = tr.children();
			var loginResult = ${loginDto.m_no};
			var crt_amount = td.eq(4).find('input[type="number"]').val();
			var p_No = td.eq(4).find('input[type="hidden"]').val();
			$.ajax({
				url : 'cartChange',
				type : 'post',
				data : 'p_No=' + p_No + '&m_no=' + loginResult + '&crt_amount=' + crt_amount,
				dataType : 'text',
				success : function(responseText) {
					if (responseText == 1) {
						alert('수량이 변경되었습니다.');
						/* alert(p_No +'-' + crt_amount); */
					} else {
						alert('실패');
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		});
	});
</script>
<c:if test="${loginDto.m_no gt 0}">
	<form method="post">
		<div class="container">
			<div class="row">
				<div class="col-lg-9">
					<table class="cartBox" border="1">
						<thead>
							<tr>
								<td><input type="checkbox" id="chkAll" value="chkAll" /></td>
								<td>ITEM</td>
								<td>상품정보</td>
								<td>가격</td>
								<td>수량</td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty cartList}">
								<c:forEach var="cartDto" items="${cartList}" varStatus="l">
									<c:forEach var="productDto" items="${prodList}" varStatus="k">
										<c:if test="${k.index eq l.index}">
											<tr>
												<td>
													<input type="checkbox" name="chk" class="chk" value="${productDto.p_No}" />
												</td>
												<td>
													<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
														<img alt="X" src="${productDto.p_Image}" style="width: 100px;">
													</a>
												</td>
												<td>
													<a href="productViewPage.do?p_No=${productDto.p_No}&checkResult=1">
														${productDto.p_Name} [${productDto.p_Color}] [${productDto.p_Size}] 
													</a>
												</td>
												<td><fmt:formatNumber pattern="#,##0">${productDto.p_Price}</fmt:formatNumber></td>
												<td>
													<input type="number" name="crt_amount" id="crt_amount" min="1" max="${productDto.p_Amount}" value="${cartDto.crt_amount}" /> 
													<input type="hidden" id="p_No" name="p_No" value="${productDto.p_No}" /> 
													<a href="javascript:void()" class="cartChange">변경</a>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:if>
							<tr>
								<td colspan="5">
									<input type="hidden" name="m_no" value="${loginDto.m_no}" />
									<input type="hidden" name="page" value="${page}" />
									<input type="button" id="btndo" value="선택삭제" onclick="fn_selectDel(this.form)" />
									<input type="button" id="btndo" value="선택주문" onclick="fn_selectOrd(this.form)" />
									<input type="button" id="btndo" value="전체주문" onclick="fn_orderAll(this.form)" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="5">${paging}</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</form>
</c:if>

<%@ include file="../template/footer.jsp"%>