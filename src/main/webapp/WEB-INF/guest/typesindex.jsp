<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>飞机类别列表</title>
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
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .table-introduction {
            max-width: 200px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .table-introduction:hover {
            white-space: normal;
            overflow: visible;
            text-overflow: inherit;
        }

        .type-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
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

        th:last-child, td:last-child {
            width: 100px;
        }

        .button-spacing {
            margin-right: 10px;
        }

        #insertButton {
            margin-bottom: 10px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

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
            // 获取飞机类型列表
            function loadTypesList() {
                $.ajax({
                    url: '/type/getALlTypes',
                    type: 'GET',
                    cache: false,
                    dataType: 'json',
                    success: function (types) {
                        displayTypes(types);
                    },
                    error: function () {
                        alert('Error fetching types list.');
                    }
                });
            }

            // 显示飞机类型列表
            function displayTypes(types) {
                var tableBody = $('#typesTable tbody');
                tableBody.empty();

                $.each(types, function (index, type) {
                    var row = '<tr>';
                    row += '<td>' + type.type_id + '</td>';
                    row += '<td><a href="${pageContext.request.contextPath}/type/totypePage?type_id=' + type.type_id + '">' + type.type_name + '</a></td>';
                    row += '<td><img src="' + type.type_img + '" alt="Type Image" class="type-image"></td>';
                    row += '<td class="table-introduction">' + type.introduction + '</td>';

                    row += '</tr>';

                    tableBody.append(row);
                });}



            // 初始化加载飞机类型列表
            loadTypesList();
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
<div class="center-container">
    <table id="typesTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>飞机类型</th>
            <th>图片</th>
            <th>介绍</th>
        </tr>
        </thead>
        <tbody>
        <!-- 管理员列表将在这里显示 -->
        </tbody>
    </table>
</div>


</body>
</html>
