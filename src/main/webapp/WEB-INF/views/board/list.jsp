<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="container">
  	<div class="row">
  		<h1 class="text-primary text-center">전체 글 목록</h1>
  	</div>
    <div class="row">
      <table class="table table-hover">
        <thead>
	        <tr>
	          <th>글번호</th>
	          <th>글제목</th>
	          <th>글쓴이</th>
	          <th>작성일</th>
	          <th>수정일</th>
	        </tr>
        </thead>
        <tbody>
          <!-- forEach구문은 반복적으로 html요소를 표현할 때
          사용하는 태그라이브러리 입니다.
          원래 스크립트릿을 써도 같은 기능을 구현할 수 있지만
          자바코드와 html코드가 섞이는 상황을 막기 위해 씁니다. -->
          <c:forEach var="board" items="${list }">
	          <tr>
		          <td>${board.bno }</td>
		          <td><a href="/board/get?bno=${board.bno}">
		          		${board.title }</a></td>
		          <td>${board.writer }</td>
		          <td>${board.regDate }</td>
		          <td>${board.updateDate }</td>
		      </tr>
          </c:forEach>
        </tbody>
      </table>

    </div>
    <div class="row">
	  <ul class="col-md-11 pagination justify-content-center">
	    <li class="page-item disabled"><a class="page-link" href="#">«</a></li>
	    <li class="page-item active"><a class="page-link" href="#">1</a></li>
	    <li class="page-item"><a class="page-link" href="#">2</a></li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    <li class="page-item"><a class="page-link" href="#">4</a></li>
	    <li class="page-item"><a class="page-link" href="#">5</a></li>
	    <li class="page-item"><a class="page-link" href="#">»</a></li>
	  </ul>
	  <a class="col-md-1 btn btn-primary btn-sm" 
	  	href="/board/register">글쓰기</a>
    </div>


  </div><!-- div container end -->
	

</body>
</html>