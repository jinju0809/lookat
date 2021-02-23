<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/qnaTitle.jsp" />
<head>
<!--Smart Editor(toolbar)  -->
<script type="text/javascript" src="toolbar/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style type="text/css">
.qnaTitle>td {
	margin: 5px;
	padding: 5px 5px 5px 5px;
}

.writeTable>tbody>tr>td {
	border: 1px solid lightgrey;
}

#qnaUpdateContainer {
	width: 80%;
	margin: auto;
}
</style>
</head>

<br /><br />

<%-- <hr/>

	<form
		action="qnaInsert.do" method="post" enctype="multipart/form-data">
		<input type="text" id="q_title" name="q_title" style="width:1000px"><br/>
		<textarea name="q_content" style="width: 1200px; height: 500px;"></textarea> <br/>
		<input type="file" name="files" multiple/><br/>
		<input type="hidden" name="q_m_no" value="${param.q_m_no}"/>
		<button >GO</button>
	</form>


<hr/> --%>

<div id=qnaUpdateContainer>
	<form id="qnaWriteForm" action="qnaUpdate.do" method="post" enctype="multipart/form-data">
		<table class="writeTable" style="width: 100%">
			<tbody>
				<tr class="qnaTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">제목</td>
					<td><input type="text" id="q_title" name="q_title" style="width: 88%" value="${qnaDto.q_title}"></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="jsx-2303464893 editor">
							<div style="width: 100%;" role="application">
								<!-- <div class="fr-wrapper show-placeholder" dir="auto" style="overflow: scroll;"> -->
								<textarea name="q_content" id="smartEditor" style="width: 100%; height: 500px;">${qnaDto.q_content}</textarea>
							</div>
						</div>
					</td>
				</tr>
				<tr class="qnaTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">첨부</td>
					<td>
						<input type="file" name="files" multiple /><br />
						<c:if test="${empty qnaDto.q_filename}">
							[기존 첨부파일: 없음]
						</c:if>
						<c:set var="uploadFileNames" value="${fn:split(qnaDto.q_filename,'^')}" />
						<c:forEach 	var="uploadFileName" items="${uploadFileNames}">
							<c:if test="${not empty uploadFileName}">
								[기존 첨부파일: ${uploadFileName}]<br />
							</c:if>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		<br />
		<!-- hidden -->
		<input type="hidden" name="q_m_no" value="${param.q_m_no}" />
		<input type="hidden" name="q_no" value="${qnaDto.q_no}" />
		<input type="hidden" name="q_filename2" value="${qnaDto.q_filename}" />
		<input type="hidden" name="page" value="${param.page}" />
		<input type="button" id="savebutton" value="완료" />
		<input type="button" value="목록보기" onclick="location.href='qnaListPage.do?page=${param.page}'" />
	</form>
</div>

<%@ include file="../template/footer.jsp"%>

<!-- Smart Editor -->
<script type="text/javascript" src="resources/js/qna-write.js"></script>