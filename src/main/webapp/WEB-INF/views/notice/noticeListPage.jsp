<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/noticeTitle.jsp" />

<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<style type="text/css">
.NoticeContainer, .searchContainer {
	width: 80%;
	margin: auto;
}

a {
	color: #616264;
}

a:hover {
	text-decoration: none;
	color: #F15B5B;
	font-weight: bold;
}

#newWrite {
	border-radius: 5px;
	width: 5em;
	background-color: black;
	color: white;
}

#newWrite:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

#srch {
	border-radius: 5px;
	width: 3em;
	background-color: black;
	color: white;
}

#srch:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

#search>input[type=text] {
	border-radius: 5px;
	width: 8em;
}

#search>select {
	border-radius: 5px;
	width: 5em;
}
</style>
<script>
	function fn_queryNoticeListPage(f) {
		if (f.query.value == '') {
			alert('검색어를 입력하세요.');
			f.query.focus();
			return;
		}
		f.action = 'queryNoticeListPage.do';
		f.submit();
	}
</script>
</head>
<div class="NoticeContainer">
	<form method="get">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<td>No.</td>
					<td>subject</td>
					<td>Writer</td>
					<td>Date</td>
					<td>Hit</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="5">없음</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach var="noticeDto" items="${list}" varStatus="k">
						<tr>
							<td style="width: 5%">${totalRecord - ((page - 1) * recordPerPage + k.index)}</td>
							<td style="width: 65%"><a href="noticeViewPage.do?n_no=${noticeDto.n_no}&page=${page}">${noticeDto.n_title}</a></td>
							<td style="width: 15%">${noticeDto.m_name}</td>
							<td style="width: 10%">${noticeDto.n_date}</td>
							<td style="width: 5%">${noticeDto.n_hit }</td>
						</tr>
						<%-- <input type="hidden" name="n_m_no" value="${loginDto.m_no}"/> --%>
						<!-- 로그인한사람의 m_no  -->
						<%-- <input type="hidden" name="m_name" value="${noticeDto.m_name}"/> --%>
						<!-- 로그인한사람의 m_name-->
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<c:if test="${loginDto.m_grade eq '관리자등급'}">
					<tr>
						<td style="text-align: right;" colspan="5">
							<input type="button" id="newWrite" value="새 글쓰기" onclick="location.href='noticeInsertPage.do'" />
						</td>
					</tr>
				</c:if>
				<tr id="paging" style="text-align: center;">
					<td colspan="5">${paging}</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div class="searchContainer" style="text-align: center;">
	<form id="search" method="get">
		<select name="column" id="column" class="column">
			<option value="N_TITLE">제목</option>
			<option value="N_CONTENT" <c:if test="${column == 'N_CONTENT'}">selected='selected'</c:if>>내용</option>
			<option value="M_NAME" <c:if test="${column == 'M_NAME'}">selected='selected'</c:if>>작성자</option>
			<option value="BOTH" <c:if test="${column == 'BOTH'}">selected='selected'</c:if>>제목+내용</option>
		</select>
		<input type="text" name="query" />
		<%-- hidden --%>
		<input type="hidden" name="page" value="${page}" />
		<input type="button" id="srch" value="검색" onclick="fn_queryNoticeListPage(this.form)" />
	</form>
</div>

<%@ include file="../template/footer.jsp"%>