<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp" />

<script type="text/javascript">
	$(function() {
		$('.statusChange').on("click", function() {
			var tr = $(this).parent().parent();
			var o_idx = tr.find('input#o_idx').val();
			var o_delivery = tr.find('select#o_delivery').val();
			if (o_delivery == 'default') {
				alert('변경 사항이 없습니다.');
			} else {
				$.ajax({
					url : 'deliveryChange.do',
					type : 'post',
					data : 'o_idx=' + o_idx + '&o_delivery=' + o_delivery,
					dataType : 'text',
					success : function(responseText) {
						if (responseText > 0) {
							alert('배송 상태가 변경되었습니다.');
						} else {
							alert('실패');
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				});
			}
		});

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
	}); //onready
</script>
<style>
.container {
	text-align: center;
}

#orderList>tr>td>a {
	color: #F15B5B;
}

#orderList>tr>td>a:hover {
	text-decoration: none;
	color: #00A6A9;
	font-weight: bold;
}

#orderTable {
	width: 100%;
	border-top: white;
	border-left: white;
	border-right: white;
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
	margin-top: 100px;
}

#orderTable {
	text-align: center;
	padding-top: 50px;
}

#orderTable>thead {
	background: #DDE7E7;
	font-weight: bold;
}

#orderList>tr>td {
	padding: 20px 0px;
}
</style>
<div class="container">
	주문 목록
	<form>
		<table id="orderTable" border="1">
			<thead>
				<tr>
					<td><input type="checkbox" id="chkAll"></td>
					<td>회원번호</td>
					<td>주문번호</td>
					<td>주소</td>
					<td>가격</td>
					<td>연락처</td>
					<td colspan="2">배송</td>
				</tr>
			</thead>
			<tbody id="orderList">
				<c:forEach var="orderDto" items="${memberOrderList}">
					<tr>
						<td><input type="checkbox" name="chk" id="chk" 	value="${orderDto.o_idx}"></td>
						<td><a href="adminMemberODPage.do?m_no=${orderDto.o_m_no}">${orderDto.o_m_no}</a></td>
						<td>${orderDto.o_regDate}_${orderDto.o_idx}</td>
						<td>${orderDto.o_addr1} ${orderDto.o_addr2} ${orderDto.o_addr3}</td>
						<td><fmt:formatNumber value="${orderDto.o_price}" pattern="###,###,###" /></td>
						<td>${orderDto.o_cellphone}</td>
						<td>
							<select name="o_delivery" id="o_delivery">
								<option value="default">${orderDto.o_delivery}</option>
								<option value="배송준비중">배송준비중</option>
								<option value="배송중">배송중</option>
								<option value="배송완료">배송완료</option>
							</select>
						</td>
						<td>
							<input type="hidden" name="o_idx" id="o_idx" value="${orderDto.o_idx}" />
							<a href="javascript:void(0)" class="statusChange">변경</a>
						</td>
					</tr>
				</c:forEach>
				<tr>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../template/footer.jsp"%>