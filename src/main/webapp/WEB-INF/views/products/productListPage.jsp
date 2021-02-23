<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../template/header.jsp" />

<link href="resources/css/productListPage.css?after" rel="stylesheet">

<!-- Page Content -->
<div class="container">
	<div class="row">
		<div class="col-lg-3">
			<!-- 좌측바 -->
			<div class="list-group">
				<!-- <h5 id="list-top"><a href="productListPage.do">Shop</a></h5> -->
				<h5 id="list-top">Shop</h5>
				<ul class="list-g">
					<li id="list"><a href="productCategoryPage.do?p_Category=OUTER">Outer</a></li>
					<li id="list"><a href="productCategoryPage.do?p_Category=BOTTOM">Bottom</a></li>
					<li id="list"><a href="productCategoryPage.do?p_Category=BAG">Bag</a></li>
					<li id="list"><a href="productCategoryPage.do?p_Category=BLACKFRIDAY">BLACK FRIDAY</a></li>
				</ul>
			</div>
		</div>
		<!-- /.col-lg-3 -->
		<div class="col-lg-9">
			<div class="row">
				<!-- 카드상자들  -->
				<c:forEach var="productDto" items="${list}">
					<c:if test="${empty p_Category}">
						<c:set var="size" value="${productDto.p_Size}" />
						<c:if test="${size eq 'S' or size eq 'FREE'}">
							<div class="col-lg-4 col-md-6 mb-4">
								<div class="card h-100">
									<!-- 상품 사진 -->
									<a href="productViewPage.do?p_No=${productDto.p_No}">
										<img class="card-img-top" src="${productDto.p_Image}" alt="">
									</a>
									<div class="card-body">
										<h6 class="card-title">
											<!-- 상품 이름 -->
											<a href="productViewPage.do?p_No=${productDto.p_No}">
												${productDto.p_Name} [${productDto.p_Color}]
											</a>
										</h6>
										<div>
											<!-- 상품 가격 -->
											&#8361;
											<fmt:formatNumber value="${productDto.p_Price}" pattern="###,###,###" />
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</c:if>
					<c:if test="${productDto.p_Category eq p_Category}">
						<c:set var="size" value="${productDto.p_Size}" />
						<c:if test="${size eq 'S' or size eq 'FREE'}">
							<div class="col-lg-4 col-md-6 mb-4">
								<div class="card h-100">
									<!-- 상품 사진 -->
									<a href="productViewPage.do?p_No=${productDto.p_No}">
										<img class="card-img-top" src="${productDto.p_Image}" alt="">
									</a>
									<div class="card-body">
										<h6 class="card-title">
											<!-- 상품 이름 -->
											<a href="productViewPage.do?p_No=${productDto.p_No}">
												${productDto.p_Name} [${productDto.p_Color}]
											</a>
										</h6>
										<h6 style="font-size: 12px;">
											<!-- 상품 가격 -->
											&#8361;
											<fmt:formatNumber value="${productDto.p_Price}" pattern="###,###,###" />
										</h6>
									</div>
								</div>
							</div>
						</c:if>
					</c:if>
				</c:forEach>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.col-lg-9 -->
	</div>
	<!-- /.row -->
</div>
<!-- /.container -->
<%@ include file="../template/footer.jsp"%>