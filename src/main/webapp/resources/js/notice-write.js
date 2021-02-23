var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors, elPlaceHolder : "smartEditor", //textarea의 id
		sSkinURI : "toolbar/SmartEditor2Skin.html", //경로 주의
		fCreator : "createSEditor2",
		htParams : { 
					bUseToolbar : true,	// 툴바 사용 여부 (true:사용/ false:사용하지 않음)  
					bUseVerticalResizer : false, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)  
					bUseModeChanger : false // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					} 
	});
	$(function() {
		$("#savebutton").click(function() {
			oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); //textarea의 id를 적어줍니다. 
			var selcatd = $("#selcatd > option:selected").val(); 
			var title = $("#n_title").val(); 
			var content = document.getElementById("smartEditor").value;
			
			if (selcatd == "") { 
				alert("카테고리를 선택해주세요."); 
				return; 
			} 
			if (title == null || title == "") {
				alert("제목을 입력해주세요."); 
				$("#n_title").focus(); 
				return; 
			} if(content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br/>' || content == '<p>&nbsp;</p>'){
				alert("본문을 작성해주세요."); 
				oEditors.getById["smartEditor"].exec("FOCUS"); //포커싱 
				return; 
			} // 스마트에디터 유효성 검사 
			
			var result = confirm("작성하시겠습니까?"); 
			if(result){  
			$("#noticeWriteForm").submit();
			}else{ 
				return; 
			} 
		}); 
	})

