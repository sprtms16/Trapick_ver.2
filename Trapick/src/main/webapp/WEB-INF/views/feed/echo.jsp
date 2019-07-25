<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery CDN-->
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<!-- Web socket CDN -->
<!-- <script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
</head>
<body>
	<input type="text" id="message" />
	<input type="button" id="sendBtn" value="전송" />
	<div id="data"></div>
	<input type="text" id="message2" />
	<input type="button" id="sendBtn2" value="전송" />
	<div id="data2"></div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sendBtn").click(function() {
			sendMessage();
			$('#message').val('')
		});
		$("#message").keydown(function(key) {
			if (key.keyCode == 13) {// 엔터
				sendMessage();
				$('#message').val('')
			}
		});
		$("#sendBtn2").click(function() {
			sendMessage2();
			$('#message2').val('')
		});
		$("#message2").keydown(function(key) {
			if (key.keyCode == 13) {// 엔터
				sendMessage2();
				$('#message2').val('')
			}
		});
	});

	// 웹소켓을 지정한 url로 연결한다.

	let sock = new SockJS("<c:url value="/echoHandshake"/>");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	// 메시지 전송
	function sendMessage() {
		sock.send($("#message").val());
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		$("#data").append(data + "<br/>");
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
	
	
	let sock2 = new SockJS("<c:url value="/echoHandshake2"/>");
	sock2.onmessage = onMessage2;
	sock2.onclose = onClose2;
	// 메시지 전송
	function sendMessage2() {
		sock2.send($("#message2").val());
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage2(msg) {
		var data = msg.data;
		$("#data2").append(data + "<br/>");
	}
	// 서버와 연결을 끊었을 때
	function onClose2(evt) {
		$("#data2").append("연결 끊김");
	}
</script>

</html>