<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index Page</title>

<style>
    body{
        background:url("${pageContext.request.contextPath}/img/bg.jpg") no-repeat center center fixed;
        background-size:cover;
    }
    .one{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    button {
        background-color: #8dc4e8;
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        cursor: pointer;
    }

    button:hover {
        background-color: #8dc4e8;
    }

    form {
        background-color: #fff;
        padding: 20px;
        /*float: left;*/
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    input {
        margin-bottom: 10px;
        padding: 8px;
        width: 100%;
        box-sizing: border-box;
    }

    input[type="submit"] {
        background-color: #8dc4e8;
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #8dc4e8;
    }
</style>
</head>
<body>
<div class="one">
<h1>Welcome to the Index Page</h1>
</div>
<div class="two">
<!-- 按钮，点击后执行后端的@RequestMapping("/toAdminIndex")指令 -->
<form action="${pageContext.request.contextPath}/admin/toAdminIndex" method="get">
    <button type="submit">Go to Admin Index Page</button>
</form>
<form action="${pageContext.request.contextPath}/admin/plane/toPlaneIndex" method="get">
    <button type="submit">Go to Plane Index Page</button>
</form>
<form action="${pageContext.request.contextPath}/admin/type/toTypeIndex" method="get">
    <button type="submit">Go to Type Index Page</button>
</form>
</div>
</body>
</html>
