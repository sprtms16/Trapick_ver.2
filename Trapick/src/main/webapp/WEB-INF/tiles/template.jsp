<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Trapick</title>
<style>
</style>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.10/css/all.css">
<!--  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<div style="width: 100%; height: 100%;">
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="main">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
</body>
</html>