<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/qnaTitle.jsp" />
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<style type="text/css">
.QnaContainer, .searchContainer {
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

#qnaListTable>tbody>tr>td {
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

<div class="QnaContainer">
	<form method="get">
		<table id="qnaListTable" class="table table-striped table-hover">
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
				<c:if test="${empty qnaList}">
					<tr>
						<td style="text-align: center;" colspan="7">없음</td>
					</tr>
				</c:if>
				<c:if test="${not empty qnaList}">
					<c:forEach var="qnaDto" items="${qnaList}" varStatus="k">
						<tr>
							<td style="width: 5%">${totalRecord - ((page - 1) * recordPerPage + k.index)}</td>
							<td style="width: 5%"><a href="productViewPage.do?p_No=${qnaDto.q_p_no}"><img style="width: 50px;" src="${qnaDto.p_Image}"></a></td>
							<c:if test="${qnaDto.q_p_no ne 0}">
								<td style="width: 5%"><span style="font-size: 12px;"><a href="productViewPage.do?p_No=${qnaDto.q_p_no}">${qnaDto.p_Name}&nbsp;[${qnaDto.p_Color}]</a></span></td>
							</c:if>
							<c:if test="${qnaDto.q_p_no eq 0}">
								<td style="width: 5%"></td>
							</c:if>
							<td style="width: 55%">
								<c:if test="${qnaDto.q_secret != 'y'}">
									<a href="qnaViewPage.do?q_no=${qnaDto.q_no}&page=${page}">${qnaDto.q_title}</a>
								</c:if>
								<c:if test="${qnaDto.q_secret == 'y'}">
									<c:if test="${loginDto.m_no == qnaDto.q_m_no}">
										<a href="qnaViewPage.do?q_no=${qnaDto.q_no}&page=${page}">${qnaDto.q_title}</a>
									</c:if>
									<c:if test="${loginDto.m_no != qnaDto.q_m_no}">
										<a href="qnaPasswordInsertPage.do?q_no=${qnaDto.q_no}&page=${page}">${qnaDto.q_title}</a>
									</c:if>
									<i class="fas fa-lock"></i>
								</c:if>
							</td>
							<td style="width: 15%">${qnaDto.m_name}</td>
							<td style="width: 10%">${qnaDto.q_date}</td>
							<td style="width: 5%">${qnaDto.q_hit }</td>
						</tr>
						<input type="hidden" name="q_m_no" value="${loginDto.m_no}" />
						<!-- 로그인한사람의 m_no  -->
						<%-- <input type="hidden" name="m_name" value="${qnaDto.m_name}"/> --%>
						<!-- 로그인한사람의 m_name-->
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<c:if test="${not empty loginDto}">
					<tr>
						<td style="text-align: right;" colspan="7">
							<input class="listPageBtn" type="button" value="새 글쓰기" onclick="location.href='qnaInsertPage.do?q_m_no=${loginDto.m_no}'" />
						</td>
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
			<option value="Q_TITLE">제목</option>
			<option value="Q_CONTENT" <c:if test="${column == 'Q_CONTENT'}">selected='selected'</c:if>>내용</option>
			<option value="M_NAME" <c:if test="${column == 'M_NAME'}">selected='selected'</c:if>>작성자</option>
			<option value="P_NAME" <c:if test="${column == 'P_NAME'}">selected='selected'</c:if>>제품명</option>
			<option value="BOTH" <c:if test="${column == 'BOTH'}">selected='selected'</c:if>>제목+내용</option>
		</select>
		<input type="text" name="query" />
		<%-- hidden --%>
		<input type="hidden" name="page" value="${page}" />
		<input type="button" value="검색" onclick="fq_queryQnaListPage(this.form)" />
	</form>
</div>

<%@ include file="../template/footer.jsp"%>

<script>
	function fq_queryQnaListPage(f) {
		if (f.query.value == '') {
			alert('검색어를 입력하세요.');
			f.query.focus();
			return;
		}
		f.action = 'queryQnaListPage.do';
		f.submit();
	}
</script>