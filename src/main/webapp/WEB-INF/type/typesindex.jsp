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
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            // 获取飞机类型列表
            function loadTypesList() {
                $.ajax({
                    url: '/admin/type/getALlTypes',
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
                    row += '<td><a href="${pageContext.request.contextPath}/admin/type/totypePage?type_id=' + type.type_id + '">' + type.type_name + '</a></td>';
                    row += '<td><img src="' + type.type_img + '" alt="Type Image" class="type-image"></td>';
                    row += '<td class="table-introduction">' + type.introduction + '</td>';

                    row += '<td>';
                    row += '<button class="editButton" data-type-id="' + type.type_id + '">编辑</button>';
                    row += '<span class="button-spacing"></span>';
                    row += '<button class="deleteButton" data-type-id="' + type.type_id + '">删除</button>';
                    row += '</td>';

                    row += '</tr>';

                    tableBody.append(row);
                });

                // 为编辑按钮绑定点击事件
                $('.editButton').click(function () {
                    var typeId = $(this).data('type-id');
                    fillEditForm(typeId);
                    $('#editModal').css('display', 'block');
                });

                // 为删除按钮绑定点击事件
                $('.deleteButton').click(function () {
                    var typeId = $(this).data('type-id');
                    deleteType(typeId);
                });
            }

            // 插入按钮点击事件
            $('#insertButton').click(function () {
                $('#insertModal').css('display', 'block');
            });

            // 插入表单提交事件
            $('#insertForm').submit(function (event) {
                event.preventDefault();
                $('.error-message').empty();

                var type_id = $('#insertTypeId').val();
                var type_name = $('#insertTypeName').val();
                var type_img = $('#insertTypeImg').val();
                var introduction = $('#insertIntroduction').val();

                var formData = {
                    "type_id": type_id,
                    "type_name": type_name,
                    "type_img": type_img,
                    "introduction": introduction
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/type/insertType',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Insert success:', response);
                        $('#insertModal').css('display', 'none');
                        loadTypesList();
                    },
                    error: function (xhr) {
                        console.log('Insert error:', xhr.responseText);

                        if (xhr.status === 409) {
                            $('.error-message').text('类型ID已存在，请重新输入。');
                        } else {
                            alert('Error inserting type.');
                        }
                    },
                });
            });

            // 关闭模态框
            $('.close, #closeInsertModal, #closeEditModal').click(function () {
                $('.modal').css('display', 'none');
            });
            function fillEditForm(typeId) {
                getTypeInfo(typeId, function (type) {
                    // 更新编辑模态框中的表单字段
                    $('#editTypeId').val(type.type_id);
                    $('#editTypeName').val(type.type_name);
                    $('#editTypeImg').val(type.type_img);
                    $('#editIntroduction').val(type.introduction);
                });
            }

            function deleteType(typeId) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/type/deleteType',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ type_id: typeId }),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Delete success:', response);
                        loadTypesList();
                    },
                    error: function (xhr) {
                        console.log('Delete error:', xhr.responseText);
                        alert('Error deleting type.');
                    },
                });
            }


            function getTypeInfo(typeId, callback) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/type/getTypeById2?ptype=' + typeId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (type) {
                        // 成功获取管理员信息后，调用回调函数处理逻辑
                        console.log('type info:', type);
                        callback(type);
                    },
                    error: function () {
                        // 获取管理员信息失败的处理逻辑
                        alert('Error fetching type info.');
                    }
                });
            }


            // 编辑表单提交事件
            $('#editForm').submit(function (event) {
                event.preventDefault();
                $('.error-message').empty();

                var typeId = $('#editTypeId').val();
                var newTypeName = $('#editTypeName').val();
                var newTypeImg = $('#editTypeImg').val();
                var newIntroduction = $('#editIntroduction').val();

                var updatedType = {
                    type_id: typeId,
                    type_name: newTypeName,
                    type_img: newTypeImg,
                    introduction: newIntroduction
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/type/update',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedType),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Update success:', response);
                        $('#editModal').css('display', 'none');
                        loadTypesList();
                    },
                    error: function (xhr) {
                        console.log('Update error:', xhr.responseText);

                        if (xhr.status === 400) {
                            alert('Update failed: ' + xhr.responseText);
                        } else {
                            alert('Error updating type.');
                        }
                    },
                });
            });

            // 初始化加载飞机类型列表
            loadTypesList();
        });
    </script>
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
<div style="text-align: center; padding: 0px;">
</div>
<button id="insertButton">插入飞机类型</button>
<div class="center-container">
    <table id="typesTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>飞机类型</th>
            <th>图片</th>
            <th>介绍</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 管理员列表将在这里显示 -->
        </tbody>
    </table>
</div>
</div>
<div id="editModal" class="modal">
    <div class="modal-content">
        <span id="closeEditModal" class="close">&times;</span>
        <h3>编辑飞机类型</h3>
        <form id="editForm">
            <div class="error-message"></div>
            <label for="editTypeName">飞机类型：</label>
            <input type="text" id="editTypeName" name="typeName" required>
            <br>
            <label for="editTypeImg">图片：</label>
            <input type="text" id="editTypeImg" name="typeImg" required>
            <br>
            <label for="editIntroduction">介绍：</label>
            <input type="text" id="editIntroduction" name="introduction" required>
            <br>
            <input type="hidden" id="editTypeId" name="typeId">
            <button type="submit">更新</button>
        </form>
    </div>
</div>

<div id="insertModal" class="modal">
    <div class="modal-content">
        <span id="closeInsertModal" class="close">&times;</span>
        <h3>插入飞机类型</h3>
        <form id="insertForm">
            <div class="error-message"></div>
            <label for="insertTypeName">飞机类型：</label>
            <input type="text" id="insertTypeName" name="typeName" required>
            <br>
            <label for="insertTypeImg">图片：</label>
            <input type="text" id="insertTypeImg" name="typeImg" required>
            <br>
            <label for="insertIntroduction">介绍：</label>
            <input type="text" id="insertIntroduction" name="introduction" required>
            <br>
            <button type="submit">插入</button>
        </form>
    </div>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span id="closeDeleteModal" class="close">&times;</span>
        <h3>确认删除飞机类型</h3>
        <button id="confirmDeleteButton">确认删除</button>
    </div>
</div>
</body>
</html>
