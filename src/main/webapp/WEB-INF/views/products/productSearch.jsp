<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../template/header.jsp" />
<script>

	$(window).ready(function() {
		fn_search();
	});

	$(document).ready(function() {
		$('#s_button').click(fn_search);
		fn_order();
	});

	var page = 1;

	function fn_search() {

		var p_Category = $('select[name="p_Category"]').val();
		var search_type = $('select[name="search_type"]').val();
		var p_Price1 = $('#p_Price1').val();
		var p_Price2 = $('#p_Price2').val();
		var order_by = $('select[name="order_by"]').val();
		var search = $('#search').val();
		var obj = {
			"p_Category" : p_Category,
			"search_type" : search_type,
			"p_Price1" : p_Price1,
			"p_Price2" : p_Price2,
			"order_by" : order_by,
			"search" : search,
			"page" : page
		};
		$.ajax({
			url : 'productSearch.do',
			type : 'post',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			dataType : 'json',
			success : function(responseObj) {
				$('#searchButton').empty();
				$('#searchResult').empty();
				$('#noData').empty();

				$('<strong>').html(responseObj.search_count).appendTo('#searchResult');

				if (responseObj.result) {
					searchList(responseObj.list);
				} else {
					$('<strong>')
					.html('검색결과가 없습니다')
					.append($('<ul>'))
					.append($('<li>').html('검색어/제외검색어의 입력이 정확한지 확인해 보세요.'))
					.append($('<li>').html('두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.'))
					.append($('<li>').html('검색 옵션을 다시 확인해 보세요.'))
					.appendTo('#noData');
				}

				var paging = responseObj.paging;

				$('#paging').empty();
				if (paging.beginPage <= paging.pagePerBlock) {
					// class 의미
					// disable : css (클릭 안 되는 건 실버색) 적용하려고
					$('#paging').append('<div class="disable"><a>◀</a></div>');
				} else {
					// class 의미
					// 1) prev-block : 이전(◀)으로 이동하려고
					// 2) go-page : css (cursor: pointer) 적용하려고
					$('#paging').append('<div class="prev-block go-page" data-page="' + (paging.beginPage - 1) + '"><a>◀</a></div>');
				}
				// 1 2 3 4 5
				for (let p = paging.beginPage; p <= paging.endPage; p++) {
					if (paging.page == p) { // 현재페이지는 링크가 안 됩니다.
						// class 의미
						// now-page : css (현재 페이지는 녹색) 적용하려고
						$('#paging').append('<div class="now-page"><a>' + p + '</a></div>')
					} else {
						// class 의미
						// go-page : css (cursor: pointer) 적용하려고
						$('#paging').append('<div class="go-page" data-page="' + p + '"><a>' + p + '</a></div>');
					}
				}

				// ▶
				if (paging.endPage >= paging.totalPage) {
					// class 의미
					// disable : css (클릭 안 되는 건 실버색) 적용하려고
					$('#paging').append('<div class="disable"><a>▶</a></div>');
				} else {
					// class 의미
					// 1) next-block : 다음(▶)으로 이동하려고
					// 2) go-page : css (cursor: pointer) 적용하려고
					$('#paging').append('<div class="next-block go-page" data-page="' + (paging.endPage + 1) + '"><a>▶</a></div>');
				}
			},
			error : function() {
				alert('AJAX FAIL');
			}
		});

		// 링크가 걸릴 때 이동할 페이지 번호를 알아내서 다시 목록을 뿌리는 함수들
		$('body').on('click', '.prev-block', function() {
			page = $(this).attr('data-page');
			fn_search();
		});
		$('body').on('click', '.go-page', function() {
			page = $(this).attr('data-page');
			fn_search();
		});
		$('body').on('click', '.next-block', function() {
			page = $(this).attr('data-page');
			fn_search();
		});
		
	}

	function fn_order() {
		$('#p_new').click(function() {
			$('select[name="order_by"]').val('p_Regdate');
			fn_search();
		});

		$('#p_name').click(function() {
			$('select[name="order_by"]').val('p_Name');
			fn_search();
		});
	}

	function searchList(list) {
		$.each(list, function(index, item) {
			var s_List = "";
			s_List += '<li id="anchorBoxId_212" class="xans-record-">';
			s_List += ' <div class="thumbnail">';
			s_List += '<a href="productViewPage.do?p_No=' + item.p_No + '">';
			s_List += '<img src="' + item.p_Image + '"></a></div>';
			s_List += '<div class="description">';
			s_List += '<strong class="name" style="font-weight:normal;text-align:left">';
			s_List += '<a href="productViewPage.do?p_No=' + item.p_No + '">';
			s_List += '<span class="title displaynone"><span style="font-size:12px;color:#000000;">상품명</span> </span>';
			s_List += '<span style="font-size:12px;color:#000000;">' + item.p_Name + '[' + item.p_Color + ']' + '</span></a></strong>';
			s_List += '<ul class="xans-element- xans-search xans-search-listitem spec"><li class=" xans-record-">';
			s_List += '<strong class="title displaynone"><span style="font-size:12px;color:#000000;">판매가</span> </strong>';
			s_List += '<span style="font-size:12px;color:#000000;">₩' + item.p_Price + '</span><span id="span_product_tax_type_text" style=""> </span></li>';
			s_List += '</ul> </li>';
			var $searchButton = $("#searchButton");
			$searchButton.append(s_List);
		});
	}

	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = "";
	}
	
</script>


<div id="contents">
	<div class="titleArea">
		<h2>search</h2>
	</div>
	<div class="xans-element- xans-search xans-search-form">
		<div class="ec-base-box searchbox">
			<fieldset>
				<div class="item">
					<strong>상품분류</strong> <select id="p_Category" name="p_Category" fw-filter="" fw-label="" fw-msg="">
						<option value="" selected="selected">전체카테고리</option>
						<option value="OUTER">Outer</option>
						<option value="TOP">Top</option>
						<option value="SHIRTS">Shirts</option>
						<option value="BOTTOM">Bottom</option>
						<option value="BAG">Bag</option>
						<option value="BLACKFRIDAY">BLACK FRI-DAY</option>
					</select>
				</div>
				<div class="item">
					<strong>검색조건</strong> <select id="search_type" name="search_type" fw-filter="" fw-label="상품검색" fw-msg="">
						<option value="p_Name">상품명</option>
						<option value="p_No">상품번호</option>
						<option value="p_Color">상품색상</option>
					</select>
					<input id="search" name="search" value="${search}" fw-filter="" fw-label="상품명/제조사" fw-msg="" class="inputTypeText" placeholder="" size="15" type="text">
				</div>
				<div class="item">
					<strong>판매가격대</strong>
					<input id="p_Price1" name="p_Price1" fw-filter="isNumber" fw-label="최소판매가격" fw-msg="" class="input1" size="15" value="0" type="text" onFocus="clearText(this)">
					~
					<input id="p_Price2" name="p_Price2" fw-filter="isNumber" fw-label="최대판매가격" fw-msg="" class="input1" size="15" value="9999999" type="text" onFocus="clearText(this)">
				</div>
				<div class="item">
					<strong>검색정렬기준</strong> <select id="order_by" name="order_by" fw-filter="" fw-label="검색정렬기준" fw-msg="">
						<option value="p_Regdate">신상품 순</option>
						<option value="p_Name">상품명순</option>
					</select>
				</div>
				<p class="button">
					<img src="https://i.esdrop.com/d/zw5L1v0RZ9.gif" alt="검색" class="opacity" id="s_button">
				</p>
			</fieldset>
		</div>
		<div class="searchResult">
			<p class="record">
				총 <strong id="searchResult"></strong> 개 의 상품이 검색되었습니다.
			</p>
			<ul class="xans-element- xans-search xans-search-orderby listType">
				<li id="p_new" style="font-weight: bold" class="btn_order xans-record-">신상품</li>
				<li id="p_name" style="font-weight: bold" class="btn_order xans-record-">상품명</li>
			</ul>
		</div>
		<div class="xans-element- xans-search xans-search-result ec-base-product">
			<ul class="prdList grid4" id="searchButton">
			</ul>
		</div>
		<div id="noData"></div>
		<div class="right">
			<div id="paging"></div>
		</div>
	</div>
</div>

<style type="text/css">
#contents {
	width: 68%;
	margin: 0 auto;
	min-width: 300px;
	min-height: 500px;
	padding: 110px 0 50px 30px;
}

.xans-search-form .searchResult {
	overflow: hidden;
	border: 1px solid #d7d5d5;
	text-align: right;
	line-height: 38px;
}

.xans-search-form .searchResult .listType li {
	display: inline;
	padding: 0 6px 0 10px;
	color: #2e2e2e;
	cursor: pointer;
}

.ec-base-product {
	margin: 22px 0 0;
}

.ec-base-product ul.grid4>li {
	width: 25%;
}

.ec-base-product .prdList>li {
	display: inline-block;
	margin: 20px 0;
	color: #757575;
	vertical-align: top;
}

.ec-base-product .prdList {
	display: table;
	width: 100%;
	min-width: 300px;
	margin: -20px 0 0;
	font-size: 0;
	line-height: 0;
}

.ec-base-product .prdList .thumbnail {
	position: relative;
	margin: 0 7px 10px;
	text-align: center;
	letter-spacing: 0;
	letter-spacing: 0;
}

.xans-search-form .searchResult .listType li:first-child {
	background: none;
}

.ec-base-product .prdList .description {
	margin: 0 auto;
	padding: 0 7px;
	font-size: 12px;
	line-height: 18px;
	text-align: center;
}

.ec-base-product .prdList .description .name {
	display: block;
	text-align: center;
}

.ec-base-product .prdList .description .name a {
	color: #2e2e2e;
	text-decoration: none;
	letter-spacing: 0;
	letter-spacing: 0;
}

Style Attribute {
	font-weight: normal;
	text-align: left;
}

.ec-base-product .spec {
	margin: 0;
}

.ec-base-product .spec li {
	text-align: left;
}

.ec-base-product .prdList .thumbnail a img {
	max-width: 100%;
	box-sizing: border-box;
}

.ec-base-product img {
	vertical-align: middle;
}

.ec-base-product .title {
	margin: 0 0 17px;
}

.ec-base-product .spec li .title {
	font-weight: normal;
	vertical-align: top;
}

.ec-base-product .spec li .title span {
	vertical-align: top;
}

.displaynone {
	display: none;
}

ul ul {
	list-style-type: circle;
	margin-block-start: 0px;
	margin-block-end: 0px;
}

.right {
	width: 200px;
	padding: 0;
	text-align: center;
	margin-left: 41%;
}

#paging {
	display: flex;
	text-align: center;
	margin: 0 auto;
}

#paging div {
	width: 40px;
	height: 20px;
}

#paging .go-page:hover {
	cursor: pointer;
}

#paging .now-page {
	color: black;
	margin: 0 0;
}

#paging .disable {
	color: black;
}

.xans-search-form .searchResult {
	overflow: hidden;
	border: 1px solid #d7d5d5;
	text-align: right;
	line-height: 38px;
}

.xans-search-form .searchResult .record {
	float: left;
	padding: 0 0 0 8px;
	color: #000;
}

.xans-search-form .searchResult .listType {
	display: inline;
	margin: 0 4px 0 0;
}

.xans-search-form .searchbox {
	margin: 21px 0 20px;
	padding: 30px 20px 35px 30px;
}

.xans-search-form .searchbox .item {
	margin: 5px 0 0;
	color: #353535;
	line-height: 20px;
	text-align: center;
	*zoom: 1;
}

.ec-base-box {
	padding: 20px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #ddd;
	color: #777;
}

.titleArea h2 {
	display: inline-block;
	padding: 0 0;
	*display: inline;
	*zoom: 1;
	font-size: 20px;
	line-height: 20px;
	color: #000;
	font-weight: 300;
	letter-spacing: 0.5px;
	text-transform: capitalize;
}

.titleArea {
	min-height: 30px;
	margin: 0 0 50px;
	text-align: center;
}

input[type=text] {
	height: 18px;
	line-height: 20px;
	padding: 2px 4px;
	border: 1px solid #d5d5d5;
	color: #353535;
	font-size: 12px;
}

.xans-search-form .searchbox .item input {
	padding-left: 10px;
}

.xans-search-form .searchbox #keyword {
	width: 260px;
}

.xans-search-form .searchbox .item strong {
	width: 160px;
	padding: 2px 10px 0 0;
	text-align: right;
}

.xans-search-form .searchbox .item {
	margin: 5px 0 0;
	color: #353535;
	line-height: 20px;
	*zoom: 1;
}

.xans-search-form .searchbox .item:after {
	content: "";
	display: block;
	clear: both;
}

select {
	height: 24px;
	border: 1px solid #d5d5d5;
}

.xans-search-form .searchbox #category_no, .xans-search-form .searchbox #order_by
	{
	width: 295px;
}

input[type="image" i] {
	appearance: initial;
	background-color: initial;
	cursor: pointer;
	padding: initial;
	border: initial;
}

input {
	-webkit-writing-mode: horizontal-tb !important;
	text-rendering: auto;
	letter-spacing: normal;
	word-spacing: normal;
	text-transform: none;
	text-indent: 0px;
	text-shadow: none;
	text-align: start;
	-webkit-rtl-ordering: logical;
	font: 400 13.3333px Arial;
}

.xans-search-form .searchbox .button {
	margin: 30px;
	text-align: center;
}

.xans-search-form .searchResult .listType li {
	display: inline;
	padding: 0 6px 0 10px;
	color: #2e2e2e;
	cursor: pointer;
}

li {
	list-style: none;
}

fieldset {
	margin: 0;
	padding: 0;
}
</style>

<%@ include file="../template/footer.jsp"%>