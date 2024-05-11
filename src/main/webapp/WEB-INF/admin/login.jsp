<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>用户登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body{
            background:url("${pageContext.request.contextPath}/img/bg.jpg") no-repeat center center fixed;
            background-size:cover;
        }
    </style>
</head>
<body>
<div class="context">
    <form action="${pageContext.request.contextPath}/checkLogin/doget" method="post">
    用户名：<input type="text" name="username" value="${username}"><br>
    密码：<input type="password" name="password" value="${password}"><br>
    <input type="submit" value="登录"></form>
</div>


</body>
</html>
