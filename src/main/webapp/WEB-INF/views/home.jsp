<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head> 
<%@ page isELIgnored="false" %>
<title>Home</title> 
</head> 
<body> 
<jsp:include page="/WEB-INF/views/header.jsp" />
<jsp:include page="/WEB-INF/views/fuelchart.jsp" />
<jsp:include page="/WEB-INF/views/rpm_chart.jsp" />
<jsp:include page="/WEB-INF/views/donut_17.jsp" />
<jsp:include page="/WEB-INF/views/table_selected.jsp" />   
</body> 
</html>
