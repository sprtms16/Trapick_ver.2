<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	if (session.getAttribute("user_idx") != null) {
		session.removeAttribute("user_idx");
	}
	session.setAttribute("user_idx", 2);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>
</head>
<body>

	<h2>회원 정보</h2>
	<div class="user">
		<c:forEach items="${user }" var="user">
			<li>Idx		<c:out value="${user.user_idx }"></c:out></li>
			<li>ID		<c:out value="${user.id }"></c:out></li>
			<li>PW		<c:out value="${user.pw }"></c:out></li>
			<li>Email	<c:out value="${user.email }"></c:out></li>
		</c:forEach>
	</div>

	<h2>마이페이지</h2>

	<div class="schedule">
		<table class="schedule">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>출발일</th>
					<th>도착일</th>
				</tr>
			</thead>
			<c:forEach items="${list }" var="schedule">
				<tr>
					<td><c:out value="${schedule.schd_idx }"></c:out></td>
					<td><c:out value="${schedule.title }"></c:out></td>
			 		<td><c:out value="${schedule.schd_start }"></c:out></td>
					<td><c:out value="${schedule.schd_end }"></c:out></td> 
					<td><button id="mypage">삭제</button></td>
					<td><button id="mypage">공유</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>