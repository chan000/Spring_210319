<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		<div class="uploadDiv">
			<input type="file" name="uploadFile" multiple>
		</div>
		<input type="submit" value="제출" id="uploadBtn" class="btn btn-primary">
	</form>
<script type="text/javascript">
		$(document).ready(function() {
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;

			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.")
					return false;
				}
				return true;
			}

			$('#uploadBtn').on("click", function(e) {
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;

				console.log(files);
				
				for (var i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}

				

				$.ajax({
					url : '/board/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						alert("Uploaded");
					}
				});//ajax
			});
		});
	</script>
</body>
</html>