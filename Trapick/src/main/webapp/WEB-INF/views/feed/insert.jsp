<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
<script type="text/javascript" src="/resources/style/js/insert_from.js"></script>
<script type="text/javascript">
	/* let sock = new SockJS("<c:url value="/echoHandshake"/>"); */
</script>
</head>
<body>
	<article>
		<div class="container" role="main">
			<h2>글쓰기</h2>
			<!-- <form action="insertAction" method="post"></form> -->

			<form name="uploadForm" id="uploadForm" enctype="multipart/form-data"
				method="post">
				<input type="hidden" name="schd_idx" id="schd_idx"
					value="${schd_idx }">
				<div class="mb-3">
					<label for="title">제목</label> <input type="text"
						class="form-control" name="title" id="title"
						placeholder="제목을 입력해 주세요">
				</div>



				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="contents"
						id="contents" placeholder="내용을 입력해 주세요"></textarea>
				</div>
				<div>
					<button onclick="uploadFile(); return false;" type="submit"
						class="btn btn-sm btn-primary" id="btnSave">저장</button>
					<!-- //sock.send(); -->
					<button type="button" class="btn btn-sm btn-primary"
						onClick="history.go(-1)">목록</button>
				</div>
				<table class="table" style="width: 100%; border: 1px">
					<tbody id="fileTableTbody">
						<tr>
							<td id="dropZone">파일을 드래그 하세요</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</article>
</body>
</html>