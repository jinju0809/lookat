<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/reviewTitle.jsp" />

<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<style type="text/css">
.ReviewContainer, .searchContainer {
	width: 80%;
	margin: auto;
}

a {
	color: black;
}

a:hover {
	color: red;
	text-decoration: none;
	font-weight: 700;
}

#reviewListTable>tbody>tr>td {
	vertical-align: middle;
}

.listPageBtn {
	background-color: black;
	color: white;
	font-weight: 600;
	padding: 5px;
	line-height: -5px;
	font-size: 12px;
}

.listPageBtn:hover {
	background-color: white;
	font-weight: 700;
	color: black;
}
</style>
</head>
<div class="ReviewContainer">
	<form method="get">
		<table id="reviewListTable" class="table table-striped table-hover">
			<thead>
				<tr>
					<td>No.</td>
					<td colspan="2">product</td>
					<td>subject</td>
					<td>Writer</td>
					<td>Date</td>
					<td>Hit</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td style="text-align: center;" colspan="7">없음</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach var="reviewDto" items="${list}" varStatus="k">
						<tr>
							<td style="width: 5%">${totalRecord - ((page - 1) * recordPerPage + k.index)}</td>
							<td style="width: 5%"><a href="productViewPage.do?p_No=${reviewDto.rv_p_no}"><img style="width: 50px;" src="${reviewDto.p_Image}"></a></td>
							<td style="width: 10%"><span style="font-size: 12px;"><a href="productViewPage.do?p_No=${reviewDto.rv_p_no}">${reviewDto.p_Name}&nbsp;[${reviewDto.p_Color}]</a></span></td>
							<td style="width: 50%"><a href="reviewViewPage.do?rv_no=${reviewDto.rv_no}&page=${page}">${reviewDto.rv_title}</a></td>
							<td style="width: 15%">${reviewDto.m_name}</td>
							<td style="width: 10%">${reviewDto.rv_regDate}</td>
							<td style="width: 5%">${reviewDto.rv_hit }</td>
						</tr>
						<input type="hidden" name="rv_m_no" value="${loginDto.m_no}" />
						<!-- 로그인한사람의 m_no  -->
						<%-- <input type="hidden" name="m_name" value="${reviewDto.m_name}"/> --%>
						<!-- 로그인한사람의 m_name-->
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<c:if test="${not empty loginDto}">
					<tr>
						<td style="text-align: right;" colspan="7"><input class="listPageBtn" type="button" value="새 글쓰기" onclick="location.href='reviewInsertPage.do?rv_m_no=${loginDto.m_no}'" /></td>
					</tr>
				</c:if>
				<tr id="paging" style="text-align: center;">
					<td colspan="7">${paging}</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div class="searchContainer" style="text-align: center;">
	<form id="search" method="get">
		<select name="column" id="column" class="column">
			<option value="RV_TITLE">제목</option>
			<option value="RV_CONTENT" <c:if test="${column == 'RV_CONTENT'}">selected='selected'</c:if>>내용</option>
			<option value="M_NAME" <c:if test="${column == 'M_NAME'}">selected='selected'</c:if>>작성자</option>
			<option value="P_NAME" <c:if test="${column == 'P_NAME'}">selected='selected'</c:if>>제품명</option>
			<option value="BOTH" <c:if test="${column == 'BOTH'}">selected='selected'</c:if>>제목+내용</option>
		</select>
		<input type="text" name="query" />
		<%-- hidden --%>
		<input type="hidden" name="page" value="${page}" />
		<input type="button" value="검색" onclick="frv_queryReviewListPage(this.form)" />
	</form>
</div>

<%@ include file="../template/footer.jsp"%>

<script>
	function frv_queryReviewListPage(f) {
		if (f.query.value == '') {
			alert('검색어를 입력하세요.');
			f.query.focus();
			return;
		}
		f.action = 'queryReviewListPage.do';
		f.submit();
	}
</script>