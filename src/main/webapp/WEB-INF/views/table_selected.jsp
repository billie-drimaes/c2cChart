<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html>
<head>
<title>Home</title>
</head>
<body>
<table  style="width: 500px; height: 300px;margin-top: 80px;margin-left:10;">
    <tbody>
            <c:set var="route" value="route1" />
            <c:forEach items="${infoList}" var="info">
            <c:set var="infoRoute" value="${info.route}" />
       	 <c:if test="${infoRoute eq route}" >
	        <tr>
	            <td bgcolor="gray">운전자</td>
	            <td>${info.driver}</td>
	            <td bgcolor="gray">경로ID</td>
        	     <td>${info.route}</td>
	        </tr>
	         <tr>
	            <td bgcolor="gray">운행일자</td>
	             <c:set var="driveDate" value="${info.UTCdate}"/>
	            <td>${fn:substring(driveDate,0,6)}</td>	            
	            <td bgcolor="gray">운행 시작시간</td>
	            <c:set var="driveTime" value="${info.UTCtime}"/>
	            <td>${fn:substring(driveTime,0,6)}</td>	            
	        </tr>
	        </c:if>
	        </c:forEach>           
    </tbody>
</table>
 
<!-- 
<table style="width: 500px; height: 300px;margin: 30px; " >
    <tbody>
         <tr>
            <td bgcolor="gray">트립ID</td>
            <td>#277</td>
            <td bgcolor="gray">날짜</td>
            <td>220117</td>
        </tr>
         <tr>
            <td bgcolor="gray">차량번호 </td>
            <td>11라1234</td>
            <td bgcolor="gray">주행거리 </td>
            <td>32km</td>
        </tr>
    </tbody>
</table> 
 -->
</body>
</html>

