<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>飞机列表</title>
    <style>
        body{
            background:url("${pageContext.request.contextPath}/img/bg.jpg") no-repeat center center fixed;
            background-size:cover;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .error-message {
            color: red;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            border-radius: 10px; /* 添加边框半径 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }
        .deleteButton {
            background-color: #ff6666;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .center-container {
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-color:rgba(255,255,255,0.8);
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* 调整操作列宽度为固定值 */
        th:last-child, td:last-child {
            width: 100px; /* 设置您需要的宽度 */
        }
        .button-spacing {
            margin-right: 10px; /* 设置按钮之间的右侧间距 */
        }


        #insertButton {
            margin-bottom: 10px; /* 调整底部外边距 */
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* 添加动画效果 */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        /* 定义模态框显示动画 */
        .fadeIn {
            animation: fadeIn 0.3s;
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
            margin-top: 120px;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            // 获取管理员列表
            function loadPlanesList() {
                $.ajax({
                    url: '/plane/getplanesList',
                    type: 'GET',
                    cache: false,
                    dataType: 'json',
                    success: function (planes) {
                        displayPlanes(planes);
                    },
                    error: function () {
                        alert('Error fetching planes list.');
                    }
                });
            }

            // 显示管理员列表
            function displayPlanes(planes) {
                var tableBody = $('#planesTable tbody');
                tableBody.empty();

                $.each(planes, function (index, plane) {
                    var row = '<tr>';
                    // 遍历所有属性并添加到表格行中
                    row += '<td>' + plane.plane_id + '</td>';
                    // row += '<td>' + plane.cname + '</td>';
                    row += '<td><a href="${pageContext.request.contextPath}/plane/toplanePage?plane_id=' + plane.plane_id + '">' + plane.cname + '</a></td>';
                    row += '<td>' + plane.company + '</td>';
                    row += '<td>' + plane.ename + '</td>';
                    // row += '<td>' + plane.ptype + '</td>';
                    getActualContent(plane.ptype, function (actualContent) {
                        row += '<td>' + actualContent + '</td>';
                        row += '<td><img src="' + plane.img + '" alt="飞机图片" width="100" height="100"></td>';
                        row += '<td>' + plane.first + '</td>';
                        row += '<td>' + plane.license + '</td>';
                        row += '<td>' + plane.wings + '</td>';
                        row += '<td>' + plane.usage + '</td>';
                        row += '<td>' + plane.seats + '</td>';
                        row += '<td>' + plane.flight + '</td>';
                        row += '<td>' + plane.price + '</td>';
                        row += '<td>' + plane.power + '</td>';

                        // 添加编辑和删除按钮，设置按钮之间的距离
                        row += '</tr>';

                        tableBody.append(row);
                    });
                });
            }

            function getActualContent(ptype, callback) {
                // 根据传入的 ptype 返回对应的飞机类型名称
                var typeMap = {
                    '1': '多用途飞机',
                    '2': '公务机',
                    '3': '农林飞机',
                    '4': '特种飞机',
                    '5': '小型飞机',
                    '6': '旋翼机'
                };

                // 使用回调函数传递实际内容
                callback(typeMap[ptype] || '未知类型');
            }
            function getPlaneInfo(planeId, callback) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/plane/getPlaneById?id=' + planeId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (plane) {
                        // 成功获取管理员信息后，调用回调函数处理逻辑
                        console.log('Plane info:', plane);
                        callback(plane);
                    },
                    error: function () {
                        // 获取管理员信息失败的处理逻辑
                        alert('Error fetching plane info.');
                    }
                });
            }
            loadPlanesList();
        });

    </script>
</head>
<body>
<header>
    <div id="menu-bar" class="fa-solid fa-ellipsis-vertical"></div>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/index">首页</a>
        <a href="${pageContext.request.contextPath}/type/toTypeIndex">飞机类型</a>
        <a href="${pageContext.request.contextPath}/plane/toPlaneIndex">飞机</a>
    </nav>
</header>
<div class="demo">
    <div style="text-align: center; padding: 0px;">
    </div>
<%--<button id="insertButton">插入飞机</button>--%>
<div class="center-container">
    <table id="planesTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>中文名称</th>
            <th>制造公司</th>
            <th>英文名称</th>
            <th>飞机类型</th>
            <th>图片</th>
            <th>首飞时间</th>
            <th>驾驶执照</th>
            <th>飞行翼</th>
            <th>水陆</th>
            <th>座位数</th>
            <th>航程</th>
            <th>生产</th>
            <th>使用能源</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>




</body>
</html>

