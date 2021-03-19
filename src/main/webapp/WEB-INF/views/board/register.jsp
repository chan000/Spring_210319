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
	<h1>글 작성하기</h1>
	<!-- 타겟 주소(action), 전송방식(method)를 작성해주세요
	그리고, 내부 폼에서는
	input태그의 text로 title 파라미터에 글제목을
	textarea태그로 content 파라미터에 글내용을
	input태그의 text로 writer 파라미터에 글쓴이를 적은 뒤
	input태그의 submit으로 제출하도록 작성해보세요. -->
	
	<form action="/board/register" method="post">
		제목 : <input class="form-control" type="text" name="title" /><br>
		본문: <br><textarea class="form-control" name="content"></textarea><br>
		글쓴이:<input class="form-control" type="text" name="writer" /><br>
		<input class="btn btn-primary" type="submit" value="제출">
	</form>


</body>
</html>