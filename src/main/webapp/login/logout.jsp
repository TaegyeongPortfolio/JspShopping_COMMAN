<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        session.invalidate();   //세션의 모든 속성 제거
        response.sendRedirect("../shopping/shop_list.jsp");
    %>
</body>
</html>
