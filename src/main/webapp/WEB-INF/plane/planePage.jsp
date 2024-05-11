<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>飞机详细信息</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: rgb(209, 213, 219);
        }

        h2, h3, p {
            margin-bottom: 10px;
        }

        #planeContainer {
            display: flex;
            flex-direction: row; /* 设置水平方向排列 */
            align-items: center; /* 在交叉轴上居中对齐 */
        }

        img {
            max-width: 600px; /* 设置图片的最大宽度 */
            max-height: 450px; /* 设置图片的最大高度 */
            width: auto;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-right: 15px; /* 右边距用于分隔图片和文本信息 */
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin-bottom: 10px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        h4 {
            margin-top: 15px;
        }


        :root {
            --red: #c91212;
        }

        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background-color: rgb(17, 24, 39);
            backdrop-filter: blur(5px);
            z-index: 1000;
            /* 设置导航栏模块元素层级最高，以免被其他内容覆盖 */
            display: flex;
            /* flex布局 */
            align-items: center;
            /* 在交叉轴上居中对齐 */
            justify-content: center;
            /* 间距相等排列，两边留白等于间距的一半 */
            padding: 2rem 9%;

        }

        header .navbar a {
            color: white;
            font-size: 2rem;
            margin: 0 .8rem;
        }

        header .icons i {
            font-size: 2.5rem;
            color: #fff;
            cursor: pointer;
            /* 改变指针样式 */
            margin-right: 2rem;
        }

        header .icons i:hover {
            color: var(--red);
        }
        .demo{
            margin-top: 100px;
        }
    </style>
</head>

<body>


<header>
    <div id="menu-bar" class="fa-solid fa-ellipsis-vertical"></div>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/admin/index">首页</a>
        <a href="${pageContext.request.contextPath}/admin/toAdminIndex">管理员</a>
        <a href="${pageContext.request.contextPath}/admin/type/toTypeIndex">飞机类型</a>
        <a href="${pageContext.request.contextPath}/admin/plane/toPlaneIndex">飞机</a>
        <a href="${pageContext.request.contextPath}/index">返回用户界面</a>
    </nav>
</header>
<div class="demo">

<div id="planeContainer"></div>
</div>
<script>
    function getQueryParams() {
        var params = {};
        var queryString = window.location.search.substring(1);
        var pairs = queryString.split("&");

        for (var i = 0; i < pairs.length; i++) {
            var pair = pairs[i].split("=");
            params[pair[0]] = decodeURIComponent(pair[1]);
        }

        return params;
    }

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log("服务器响应内容:", xhr.responseText);

                try {
                    var planeData = JSON.parse(xhr.responseText);
                    displayPlane(planeData);
                } catch (error) {
                    console.error("解析JSON时发生错误:", error);
                }
            } else {
                console.error("获取数据时出错。状态码：" + xhr.status);
            }
        }
    };

    <% String plane_id = request.getParameter("plane_id"); %>
    xhr.open("GET", `${pageContext.request.contextPath}/admin/plane/getPlaneById?id=<%= Integer.parseInt(plane_id) %>`, true);
    xhr.send();

    function displayPlane(plane) {
        var planeContainer = document.getElementById("planeContainer");

        var planeDiv = document.createElement("div");

        planeDiv.innerHTML =
            "<img src='" + plane.img + "' alt='Plane Image'>" +
            "<h3>" + plane.cname + "</h3>" +
            "<p>公司: " + plane.company + "</p>" +
            "<p>英文名称: " + plane.ename + "</p>" +
            "<p>首飞日期: " + plane.first + "</p>" +
            "<p>飞机牌照: " + plane.license + "</p>" +
            "<p>机翼类型: " + plane.wings + "</p>" +
            "<p>使用用途: " + plane.usage + "</p>" +
            "<p>座位数: " + plane.seats + "</p>" +
            "<p>飞行范围: " + plane.flight + "</p>" +
            "<p>价格: " + plane.price + "</p>" +
            "<p>动力系统: " + plane.power + "</p>";

        planeContainer.appendChild(planeDiv);
    }
</script>

</body>

</html>
