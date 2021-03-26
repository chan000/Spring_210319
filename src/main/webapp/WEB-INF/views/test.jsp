<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax 테스트</h2>
	<ul id="replies">
	</ul>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var bno = 5;

		$.getJSON("/replies/all/ " + bno, function(data) {

			// <ul> 내부에 집어넣을 <li> 요소를 그리기 위해 사용
			var str = "";
			console.log(data.length);

			// 자바의 forEach와 유사한 구문.
			// data내부의 요소들을 하나하나 순서대로 뽑아서
			// 내부코드를 실행합니다.
			$(data).each(
					function() {
						str += "<li data-rno='" + this.rno+"' class='replyLi'>"
								+ this.rno + ":" + this.replytext + "</li>";
					});
			$("#replies").html(str);
		});
	</script>
</body>
</html>