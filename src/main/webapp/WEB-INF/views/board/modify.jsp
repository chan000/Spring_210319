<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
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
		<input type="submit" value="제출" class="btn btn-primary">
	</form>

</body>
</html>