<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>类型信息</title>
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
            border-bottom: 1px solid #fdfdfd;
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
<div id="typesContainer"></div>
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
                    var typesData = JSON.parse(xhr.responseText);
                    displayTypes(typesData);
                } catch (error) {
                    console.error("解析JSON时发生错误:", error);
                }
            } else {
                console.error("获取数据时出错。状态码：" + xhr.status);
            }
        }
    };

    <% String type_id = request.getParameter("type_id"); %>
    xhr.open("GET", `${pageContext.request.contextPath}/admin/type/getTypeById2?ptype=<%= Integer.parseInt(type_id) %>`, true);

    xhr.send();

    function displayTypes(typesData) {
        var typesContainer = document.getElementById("typesContainer");

        if (!Array.isArray(typesData)) {
            typesData = [typesData];
        }

        var queryParams = getQueryParams();
        var selectedTypeId = queryParams.type_id;

        typesData.forEach(function (type) {
            var typeDiv = document.createElement("div");

            if (type.type_id == selectedTypeId) {
                typeDiv.innerHTML = "<h3>" + type.type_name + "</h3>" +
                    "<img src='" + type.type_img + "' alt='Type Image'>" +
                    "<p>" + type.introduction + "</p>";

                var planesList = document.createElement("ul");

                if (Array.isArray(type.planeList)) {
                    type.planeList.forEach(function (plane) {
                        var planeItem = document.createElement("li");
                        planeItem.innerHTML = "<b>飞机ID：</b> " + plane.plane_id + "<br>" +
                            '<b>名称：</b> <a href="${pageContext.request.contextPath}/admin/plane/toplanePage?plane_id=' + plane.plane_id + '">' + plane.cname + '</a><br>' +
                            "<b>公司：</b> " + plane.company + "<br>" +
                            "<b>英文名称：</b> " + plane.ename;
                        planesList.appendChild(planeItem);
                    });
                }

                var heading = document.createElement("h4");
                heading.appendChild(document.createTextNode("飞机"));
                typeDiv.appendChild(heading);
                typeDiv.appendChild(planesList);
                typesContainer.appendChild(typeDiv);
            }
        });
    }
</script>

</body>

</html>

