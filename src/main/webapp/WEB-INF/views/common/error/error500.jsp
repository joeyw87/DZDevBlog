<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	<head>
	</head>
	<body>
		<span>ERROR 500!</span>
		<h3>${exception.getMeggege()}</h3>
		<h3>${url}</h3>
		<c:forEach items="${exception.getStackTrace() }" var="stack">
			<li>${stack.toString()}</li>
		</c:forEach>
	</body>
</html>
