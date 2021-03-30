<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#modDiv {
		width: 300px;
		height: 100px;
		background-color: green;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
	}
</style>
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
		<button id="replyAddBtn">ADD Reply</button>
	</div>
	<ul id="replies">
	
	</ul>
	<button id="addReplyList">리플 표출</button>

	<!-- 모달창 위치 -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replytext">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">Delete</button>
			<button type="button" id="closeBtn">Close</button>			
		</div>
	</div>
	
	
	<!-- jquery CDN 입력 -->	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var bno = 3;
		
		function getAllList(){
			$.getJSON("/replies/all/" + bno, function(data){
				
				console.log(data.length);
				
				// <ul> 내부에 집어넣을 <li> 요소를 그리기 위해 사용
				var str = "";
				
				// 자바의 forEach와 유사한 구문.
				// data내부의 요소들을 하나하나 순서대로 뽑아서
				// 내부 코드를 실행합니다.
				$(data).each(function() {
					// 특정요소.html("문자열"); 을 실행하면
					// <>문자열</> 과 같이 태그사이에 넣을 문자열을
					// 지정할 수 있고, 그 문자열은 실제로 삽입될때는
					// html요소로 간주되어 들어갑니다.
					// ul태그 내에 li형태로 댓글정보를 넣기 위해
					// 아래와 같이 설정합니다.
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
						+ this.rno + ":" + this.replytext
						+ "<button>수정/삭제</button></li>";
					
				});
				
				// id값이 replies인 ul 사이에 문자열을 끼워넣는 문법
				$("#replies").html(str);
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
						getAllList();
			    	}
			    }
			});
		});
		
		//리플 표출 버튼
		$("#addReplyList").on("click", function(){
			getAllList();
		})

		//이벤트 위임
		//위임은 여러 요소를 독립적으로 기능시키면서도 하나의 이벤트로 처리할때
		//사용하는 개념으로 아래와 같이 "button"이 클릭의 대상일때
		//버튼을 모두 포함하고 있는 가장 가까운 부모쪽 태그를 onclick의 타겟으로
		//잡고 대신 2번째 파라미터에 최종 버튼과 그 사이의 요소를 기술합니다.
		$("#replies").on("click", ".replyLi button", function(){
			//"클릭한 버튼"의 부모요소만 특정지어 가져옴
			var reply = $(this).parent();
			
			//.attr()는 파라미터를 하나 받은 경우 해당 속성의 값을 가져옴
			var rno = reply.attr("data-rno");
			//.text()는 해당 태그의 <와 >사이의 모든 자료를 삭제하고
			//남는 요소만 가져옴
			var replytext = reply.text();
			
			$(".modal-title").html(rno);
			$("#replytext").val(replytext);
			$("#modDiv").show("slow");
		});
		
		//삭제버튼 이벤트 처리
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				success : function(result){
					console.log("result : " + result);
					if(result === 'SUCCESS'){
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});

		//수정버튼 이벤트 처리
		$("#replyModBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				contentType : "application/json",
				data : JSON.stringify({replytext:replytext}),
				dataType : 'text',
				success : function(result){
					console.log("result : " + result);
					if(result === 'SUCCESS'){
						alert("수정 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		//모달창 닫기
		$("#closeBtn").on("click", function(){
			$("#modDiv").hide("slow");
		});
		
		
		
		
		
		</script>
	

	
	
</body>
</html>