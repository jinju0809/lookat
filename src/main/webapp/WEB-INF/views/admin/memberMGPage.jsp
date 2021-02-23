<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../template/header.jsp" />

<script type="text/javascript">
	$(window).ready(function() {
		fn_onload_memberList();
	});

	$(document).ready(function() {
		fn_memberList();
		fn_memberDelete();
	});

	function fn_onload_memberList() {
		var member_type = $('#member_type').val();
		var search_member = $('#search_member').val();
		var sendByList = {
			"member_type" : member_type,
			"search_member" : search_member
		};
		$.ajax({
			url : 'memberMG.do',
			type : 'post',
			data : JSON.stringify(sendByList),
			contentType : 'application/json',
			dataType : 'json',
			success : function(responseObj) {
				if (responseObj.listResult == true) {
					fn_memberListTable(responseObj.list);
				} else {
					$('#memberList').empty();
					$('<tr>')
					.append($('<td colspan="7">').html('검색된 회원 내역이 없습니다.'))
					.appendTo('#memberList');
				}
			},
			error : function() {
				alert('AJAX FAIL')
			}
		});
	}

	function fn_memberList() {
		$('#search_btn').on('click', '', function() {
			fn_onload_memberList();
		});
	}

	function fn_memberListTable(list) {
		$('#memberList').empty();
		$.each(list, function(idx, member) {
			if (member.m_grade != ('관리자등급')) {
				$('<tr>')
				.append($('<td>').html(member.m_id))
				.append($('<td>').html(member.m_name))
				.append($('<td>').html(member.m_addr1 + ' ' + member.m_addr2 + '<br/>' + member.m_addr3))
				.append($('<td>').html(member.m_phone))
				.append($('<td>').html(member.m_email))
				.append($('<td>').html(member.m_point))
				.append($('<td>').html(member.m_grade))
				.append($('<td>').html(member.m_regdate))
				.append($('<input type="hidden" id="m_no" />').val(member.m_no))
				.append($('<input type="hidden" id="m_id" />').val(member.m_id))
				.append($('<td>').html('<a href="memberMGModifyPage.do?m_no=' + member.m_no + '"><button id="update_btn">수정</button></a>'))
				.append($('<td>').html('<button id="delete_btn">삭제</button>'))
				.appendTo('#memberList');
			}
		});
	}

	function fn_memberDelete() {
		$('body').on('click', '#delete_btn', function() {
			var m_no = $(this).parents('tr').find('input:hidden[id="m_no"]').val();
			var m_id = $(this).parents('tr').find('input:hidden[id="m_id"]').val();
			var deleteCheck = confirm(m_id + '님 정보를 삭제할까요?');
			if (deleteCheck) {
				$.ajax({
					url : 'memberMG/' + m_no,
					type : 'delete',
					dataType : 'json',
					success : function(responseObj) {
						if (responseObj.result == 1) {
							alert('회원 정보가 삭제되었습니다.');
							fn_onload_memberList();
						} else {
							alert('회원 정보 삭제가 실패했습니다.');
						}
					},
					error : function() {
						alert('AJAX FAIL')
					}
				});
			}
		});
	}
</script>
<style>
.container {
	text-align: center;
	white-space: nowrap;
	overflow-x: scroll;
}

.container>button {
	border-radius: 5px;
	background-color: black;
	color: white;
	width: 3em;
	padding: 1px;
}

.container>button:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

#update_btn, #delete_btn {
	border-radius: 5px;
	background-color: black;
	color: white;
	width: 3em;
	padding: 1px;
}

#update_btn:hover, #delete_btn:hover {
	background-color: white;
	color: black;
	transition-property: background-color, color;
	transition-duration: 0.6s;
}

.container>table {
	width: 100%;
	border-top: white;
	border-left: white;
	border-right: white;
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
	margin-top: 100px;
}

#memberList>tr>td {
	padding: 20px 5px;
}

#memberTable {
	text-align: center;
	padding-top: 50px;
}

#memberTable>thead {
	background: #DDE7E7;
	font-weight: bold;
}
</style>
<div class="container">
	검색어
	<select id="member_type">
		<option value="M_ID">아이디</option>
		<option value="M_NAME">이름</option>
		<option value="M_PHONE">핸드폰</option>
		<option value="M_EMAIL">이메일</option>
	</select>
	<input type="text" id=search_member />
	<button id="search_btn">검색</button>
	<br /><br /><br /><br /><br />
	
	회원 목록
	<table id="memberTable" border="1">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>주소</th>
				<th>핸드폰</th>
				<th>이메일</th>
				<th>적립금</th>
				<th>회원등급</th>
				<th>가입일</th>
				<th colspan="2">비고</th>
			</tr>
		</thead>
		<tbody id="memberList">
			<tr>
				<td colspan="7">검색된 회원 내역이 없습니다.</td>
			</tr>
		</tbody>
	</table>
</div>
<%@ include file="../template/footer.jsp"%>