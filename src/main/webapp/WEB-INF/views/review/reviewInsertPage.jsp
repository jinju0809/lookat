<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/reviewTitle.jsp" />

<head>
<!--Smart Editor(toolbar)  -->
<script type="text/javascript" src="toolbar/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style type="text/css">
.reviewTitle>td {
	margin: 5px;
	padding: 5px 5px 5px 5px;
}

.writeTable>tbody>tr>td {
	border: 1px solid lightgrey;
}
</style>
</head>

<%-- <hr/>

	<form
		action="reviewInsert.do" method="post" enctype="multipart/form-data">
		<input type="text" id="rv_title" name="rv_title" style="width:1000px"><br/>
		<textarea name="rv_content" style="width: 1200px; height: 500px;"></textarea> <br/>
		<input type="file" name="files" multiple/><br/>
		<input type="hidden" name="rv_m_no" value="${param.rv_m_no}"/>
		<button >GO</button>
	</form>


<hr/> --%>

<form id="reviewWriteForm" action="reviewInsert.do" method="post" enctype="multipart/form-data">
	<div id="reviewWriteContainer" style="width: 80%; margin: auto;">
		<table class="writeTable" style="width: 100%">
			<tbody>
				<tr class="reviewTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">제목</td>
					<td><input type="text" id="rv_title" name="rv_title" style="width: 88%; padding-left: 5px;"></td>
				</tr>
				<tr>
					<td style="width: 12%; padding-left: 10px; text-align: center;">품목</td>
					<td>
						<select id="rv_p_no" name="rv_p_no">
							<option value="0">===리뷰작성할 제품 선택===</option>
							<c:if test="${empty prodList}">
								<option value="0">없음</option>
							</c:if>
							<c:forEach var="th" items="${orderList}" varStatus="j">
								<c:if test="${not empty prodList}">
									<c:forEach var="orderDto" items="${list}" varStatus="l">
										<c:forEach var="productDto" items="${prodList}" varStatus="k">
											<c:if test="${k.index eq l.index}">
												<c:if test="${(j.index+2) eq orderDto.o_idx}">
													<option value="${productDto.p_No}">
														제품명 : ${productDto.p_Name} ${productDto.p_Color}
														가격 : ${productDto.p_Price}
														주문일시 : ${orderDto.o_regDate }
													</option>
												</c:if>
											</c:if>
										</c:forEach>
									</c:forEach>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="jsx-2303464893 editor">
							<div style="width: 100%;" role="application">
								<!-- <div class="fr-wrapper show-placeholder" dir="auto" style="overflow: scroll;"> -->
								<textarea name="rv_content" id="smartEditor" style="width: 100%; height: 500px; resize: none; padding: 5px;"></textarea>
							</div>
						</div>
					</td>
				</tr>
				<tr class="reviewTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">첨부</td>
					<td><input type="file" name="files" multiple /></td>
				</tr>
			</tbody>
		</table>
		<br />
		<!-- hidden -->
		<input type="hidden" name="rv_m_no" value="${loginDto.m_no}" />
		<input type="button" id="savebutton" value="완료" />
		<input type="button" value="목록보기" onclick="location.href='reviewListPage.do'" />
	</div>
</form>

<%@ include file="../template/footer.jsp"%>

<!-- Smart Editor -->
<script type="text/javascript" src="resources/js/review-write.js"></script>