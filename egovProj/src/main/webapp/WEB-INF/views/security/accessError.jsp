<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Access Denied Page</title>
</head>
<body>
<h3>Access Denied</h3>
<h2>${SPRING_SECURITY_403_EXCEPTION.getMessage()}</h2>
<!-- model.addAttribute("msg","Access Denied"); -->
<h2>${msg}</h2>
</body>
</html>