<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user_idx") != null) {
		session.removeAttribute("user_idx");
	}
	session.setAttribute("user_idx", 2);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	location.href = "feed/feedList"
			
	
</body>
</html>