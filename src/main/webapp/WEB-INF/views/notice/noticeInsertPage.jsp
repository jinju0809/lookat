<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/noticeTitle.jsp" />

<head>
<!--Smart Editor(toolbar)  -->
<script type="text/javascript" src="toolbar/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style type="text/css">
.noticeTitle>td {
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
		action="noticeInsert.do" method="post" enctype="multipart/form-data">
		<input type="text" id="n_title" name="n_title" style="width:1000px"><br/>
		<textarea name="n_content" style="width: 1200px; height: 500px;"></textarea> <br/>
		<input type="file" name="files" multiple/><br/>
		<input type="hidden" name="n_m_no" value="${param.n_m_no}"/>
		<button >GO</button>
	</form>


<hr/> --%>

<form id="noticeWriteForm" action="noticeInsert.do" method="post" enctype="multipart/form-data">
	<div id="noticeWriteContainer" style="width: 80%; margin: auto;">
		<table class="writeTable" style="width: 100%">
			<tbody>
				<tr class="noticeTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">제목</td>
					<td><input type="text" id="n_title" name="n_title" style="width: 88%"></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="jsx-2303464893 editor">
							<div style="width: 100%;" role="application">
								<!-- <div class="fr-wrapper show-placeholder" dir="auto" style="overflow: scroll;"> -->
								<textarea name="n_content" id="smartEditor" style="width: 100%; height: 500px; resize: none;"></textarea>
								<!-- </div>  -->
							</div>
						</div>
					</td>
				</tr>
				<tr class="noticeTitle">
					<td style="width: 12%; padding-left: 10px; text-align: center;">첨부</td>
					<td><input type="file" name="files" multiple /></td>
				</tr>
			</tbody>
		</table>
		<br />
		<!-- hidden -->
		<input type="hidden" name="n_m_no" value="${loginDto.m_no}" />
		<input type="button" id="savebutton" value="완료" />
		<input type="button" value="목록보기" onclick="location.href='noticeListPage.do'" />
	</div>
</form>

<%@ include file="../template/footer.jsp"%>

<!-- Smart Editor -->
<script type="text/javascript" src="resources/js/notice-write.js"></script>