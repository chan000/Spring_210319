<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
#uploadResult {
	width: 100%;
	background-color: gray;
}

#uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

#uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

#uploadResult ul li img {
	width: 100px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${board.bno }번 글 수정</h1>
	<form action="/board/modifyrun" method="post">
		글쓴이<input name="writer" type="text" class="form-control"
			readonly=true value="${board.writer }"><br>
			
		글 제목<input name="title" type="text" class="form-control"  
			 value="${board.title }"><br>
			
		본문<br>
		<textarea name="content" class="form-control">
					${board.content }</textarea><br>
					
		등록날짜<input name="regDate" type="text" class="form-control" 
			readonly=true value=${board.regDate }><br>
			
		수정날짜<input name="updateDate" type="text" class="form-control"
			readonly=true value=${board.updateDate }><br>
		<input type="hidden" name="bno" value=${board.bno } />
		<input type="hidden" name="page" value=${cri.page } />
		<input type="hidden" name="searchType" value=${cri.searchType } />
		<input type="hidden" name="keyword" value=${cri.keyword } />
		<input type="hidden" name="">
		<input type="submit" id="submitBtn" value="제출" class="btn btn-primary">
		
		
	</form>
	<div class="row">
		<h3 class="text-primary">첨부파일</h3>
		<div class="form-group uploadDiv">
			<input type="file" name="uploadFile" multiple>
			<button id="uploadBtn">등록</button>
		</div>
		<div id="uploadResult">
			<ul>
				<!-- 첨부파일이 들어갈 위치 -->
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	var bno = ${board.bno};
	(function() {
		
	$.getJSON("/board/getAttachList",{bno:bno},function(arr){
		
		console.log(arr);	
		
		var str="";
		
		$(arr).each(function(i, attach) {
			if (attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+
						attach.uuid+"_" + attach.fileName);
				str +="<li data-path='"+attach.uploadPath+"'data-uuid='"
				+ attach.uuid+"'data-filename='" + attach.fileName
				+ "'data-type='"+attach.fileType+"'><div>"
				+ "<span>"+attach.fileName + "</span>"
				+ "<button type='button' data-file=\'"+ fileCallPath+"\'data-type='image"
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'> X </i></button><br>"
				+ "<img src='/display?fileName="+fileCallPath+"'>"
				+ "</div>"
				+ "</li>";
				
			} else{
				str +="<li data-path='"+attach.uploadPath+"'data-uuid='"
				+ attach.uuid+"'data-filename='" + attach.fileName
				+ "'data-type='"+attach.fileType+"'><div>"
				+"<span>"+ attach.fileName+"</span>"
				+"<button type='button' data-file=\'" + fileCallPath +"\'data-type='image'"
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'> X </i></button><br>"
				+ "<img src='/resources/attachicon.png' width='100px' height='100px'>"
				+ "</div>"
				+ "</li>";
			}
		});
		$("#uploadResult ul").html(str);
	}); // end getJSON
})(); // end anonymous
$("#uploadResult").on("click","button",function(e){
	if (confirm("선택한 파일을 삭제하시겠습니까?")) {
		var targetLi = $(this).closest("li");
		targetLi.remove();
		}
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	var cloneObj = $(".uploadDiv").clone();
	
	$('#uploadBtn').on("click", function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		console.log("============");
		console.log(inputFile);
		
		var files = inputFile[0].files;
		
		// 파일 데이터를 폼에 집어넣기
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		console.log(formData);
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
				
				showUploadedFile(result);
				
				$(".uploadDiv").html(cloneObj.html());
			}
		});//ajax
	});//onclick uploadBtn		
	
	var uploadResult = $("#uploadResult ul");
	
	function showUploadedFile(uploadResultArr){
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			if(!obj.fileType){
			var fileCallPath = encodeURIComponent(
								obj.uploadPath + "/"
							  + obj.uuid + "_" + obj.fileName);
			str +="<li data-path='"+obj.uploadPath+"'data-uuid='"
			+ obj.uuid+"'data-filename='" + obj.fileName
			+ "'data-type='"+obj.fileType+"'><div>"
			+"<span>"+ obj.fileName+"</span>"
			+"<button type='button' data-file=\'" + fileCallPath +"\'data-type='image'"
			+ "class='btn btn-warning btn-circle'><i class='fa fa-times'> X </i></button><br>"
			+ "<img src='/resources/attachicon.png' width='100px' height='100px'>"
			+ "</div>"
			+ "</li>";
			
			}else{
				//str += "<li>" + obj.fileName +"</li>";
				// 수정 후 코드
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" +
										obj.uuid + "_" + obj.fileName);
				console.log("파일경로:" + fileCallPath);
				
				str +="<li data-path='"+obj.uploadPath+"'data-uuid='"
				+ obj.uuid+"'data-filename='" + obj.fileName
				+ "'data-type='"+obj.fileType+"'><div>"
				+ "<span>"+obj.fileName + "</span>"
				+ "<button type='button' data-file=\'"+ fileCallPath+"\'data-type='image"
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'> X </i></button><br>"
				+ "<img src='/display?fileName="+fileCallPath+"'>"
				+ "</div>"
				+ "</li>";
			}
			
			
		});
		
		uploadResult.append(str);
	}//showUpliadedFile
	
	$("#submitBtn").on("click", function(e) {
		e.preventDefault();
		
		var formObj = $("form");

		var str = "";
		$("#uploadResult ul li").each(function(i, obj){
			
			var jobj = $(obj);
			
			str += "<input type='hidden' name='attachList[" + i + "].fileName'"
				+ " value='" + jobj.data("filename") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].uuid'"
				+ " value='" + jobj.data("uuid") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
				+ " value='" + jobj.data("path") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].fileType'"
				+ " value='" + jobj.data("type") + "'>"
		});
		
		formObj.append(str);
		
		console.log(formObj);
		
		formObj.submit();
	});
});// document
</script>
</html>