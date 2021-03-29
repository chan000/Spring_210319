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
	<div>
	<div>
		REPLYER <input type="text" name="replyer" id="newReplyWriter">
	</div>
	<div>
		REPLY TEXT <input type="text" name="replytext" id="newReplyText">
	</div>
	<button id="replyAddBtn">ADD REPLY</button>
	<ul id ="replies">
	</ul>
	<button id="addReplyList">열기.</button>
	<ul id ="replies">
	</ul>
	<button id="addReply">닫기</button>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var bno = 5;
	function getAllList() {
		
	

		$.getJSON("/replies/all/ " + bno, function(data) {

			// <ul> 내부에 집어넣을 <li> 요소를 그리기 위해 사용
			var str = "";
			console.log(data.length);

			// 자바의 forEach와 유사한 구문.
			// data내부의 요소들을 하나하나 순서대로 뽑아서
			// 내부코드를 실행합니다.
			$(data).each(
					function() {
						// 특정요소.html("문자열");을 실행하면
						// <>문자열</>과 같이 태그사이에 넣을 문자열을
						// 지정할 수 있고, 그 문자열은 실제로 삽입될때는
						// html요소로 간주되어 들어갑니다.
						// ul태그 내에 li형태로 댓글정보를 넣기 위해
						// 아래와 같이 설정합니다.
						str += "<li data-rno='" + this.rno+"' class='replyLi'>"
								+ this.rno + ":" + this.replytext 
								+ "<button>수정/삭제</button></li>";
					});
			$("#replies").html("<h1>"+str+"</h1>");
		});
	}
	$("#replyAddBtn").on("click", function() {
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
		    dataType : 'text',
		    data : JSON.stringify({
		    	bno : bno,
		    	replyer: replyer,
		    	replytext : replytext
		    }),
		    success : function(result) {
		    	if(result == 'SUCCESS'){
		    		alert("등록 되었습니다.");
		    	}
		    }
		});
	});
	$("#addReplyList").on("click", function() {
		getAllList();
	
	});
	$("#addReply").on("click", function() {
			$("#replies").html("<h1>"+""+"</h1>");
			
			//이벤트 위임
			$("#replies").on("click",".replyLi button", function() {
				var reply = $(this).parent();
				
				var rno = reply.attr("data-rno");
				bar replytext=reply.text();
				
				alert(rno+" : " + replytext);
			});
	
	});
	
	</script>
</body>
</html>