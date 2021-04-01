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
 <form action="/user/joinmemberPost" method="post">
 <div class="form-group">
      <label>아이디
      <input type="text"></label>
 </div>
 <div class="form-group">
      <label>비밀번호
      <input type="password"></label>
 </div>
 <div class="form-group">
      <label>닉네임
      <input type="text"></label>
 </div>
      <div class="col-xs-4">
				<button type="submit" class="btn btn-primary btn-block btn-flat">가입</button>
			</div>
      </form>
</body>
</html>