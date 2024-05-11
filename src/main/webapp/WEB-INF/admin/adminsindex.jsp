<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>管理员列表</title>
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
            background-color:rgba(255,255,255,0.5);

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
            function loadAdminsList() {
                $.ajax({
                    url: '/admin/getadminsList',
                    type: 'GET',
                    cache: false,
                    dataType: 'json',
                    success: function (admins) {
                        displayAdmins(admins);
                    },
                    error: function () {
                        alert('Error fetching admins list.');
                    }
                });
            }

            // 显示管理员列表
            function displayAdmins(admins) {
                var tableBody = $('#adminsTable tbody');
                tableBody.empty();

                $.each(admins, function (index, admin) {
                    var row = '<tr>';
                    row += '<td>' + admin.id + '</td>';
                    row += '<td>' + admin.username + '</td>';
                    row += '<td>' + admin.password + '</td>';
                    row += '<td>' + admin.permission + '</td>';

                    // 添加编辑和删除按钮，设置按钮之间的距离
                    row += '<td>';
                    row += '<button class="editButton" data-admin-id="' + admin.id + '">编辑</button>';
                    row += '<span class="button-spacing"></span>'; // 使用<span>元素设置按钮之间的距离
                    row += '<button class="deleteButton" data-admin-id="' + admin.id + '">删除</button>';
                    row += '</td>';

                    row += '</tr>';

                    tableBody.append(row);
                });


                // 为编辑按钮绑定点击事件
                $('.editButton').click(function () {
                    var adminId = $(this).data('admin-id');
                    fillEditForm(adminId);
                    $('#editModal').css('display', 'block');
                });
                $('.deleteButton').click(function () {
                    var adminId = $(this).data('admin-id');
                    deleteAdmin(adminId);
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

                var username = $('#insertUsername').val();
                var password = $('#insertPassword').val();
                var permission = $('#insertPermission').val();

                var formData = {
                    "username": username,
                    "password": password,
                    "permission": permission
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/insertAdmin',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Insert success:', response);
                        $('#insertModal').css('display', 'none');
                        loadAdminsList();
                    },
                    error: function (xhr) {
                        console.log('Insert error:', xhr.responseText);

                        if (xhr.status === 409) {
                            $('.error-message').text('用户名已存在，请重新输入。');
                        } else {
                            alert('Error inserting admin.');
                        }
                    },
                });
            });

            // 关闭模态框
            $('.close, #closeInsertModal, #closeEditModal').click(function () {
                $('.modal').css('display', 'none');
            });

            function fillEditForm(adminId) {
                // 调用getAdminInfo，并传递一个回调函数用于处理成功获取管理员信息后的逻辑
                getAdminInfo(adminId, function (admin) {
                    // 更新编辑模态框中的表单字段
                    $('#editUsername').val(admin.username);
                    $('#editPassword').val(admin.password);
                    $('#editPermission').val(admin.permission);
                    $('#editAdminId').val(admin.id);
                });
            }
            function deleteAdmin(adminId) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ id: adminId }),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Delete success:', response);
                        loadAdminsList();
                    },
                    error: function (xhr) {
                        console.log('Delete error:', xhr.responseText);
                        alert('Error deleting admin.');
                    },
                });
            }


            function getAdminInfo(adminId, callback) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/getAdminById?id=' + adminId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (admin) {
                        // 成功获取管理员信息后，调用回调函数处理逻辑
                        console.log('Admin info:', admin);
                        callback(admin);
                    },
                    error: function () {
                        // 获取管理员信息失败的处理逻辑
                        alert('Error fetching admin info.');
                    }
                });
            }


            // 编辑表单提交事件
            $('#editForm').submit(function (event) {
                event.preventDefault();
                $('.error-message').empty();

                var adminId = $('#editAdminId').val();
                var newUsername = $('#editUsername').val();
                var newPassword = $('#editPassword').val();
                var newPermission = $('#editPermission').val();

                var updatedAdmin = {
                    id: adminId,
                    username: newUsername,
                    password: newPassword,
                    permission: newPermission
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/update',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedAdmin),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Update success:', response);
                        $('#editModal').css('display', 'none');
                        loadAdminsList();
                    },
                    error: function (xhr) {
                        console.log('Update error:', xhr.responseText);

                        if (xhr.status === 400) {
                            alert('Update failed: ' + xhr.responseText);
                        } else {
                            alert('Error updating admin.');
                        }
                    },
                });
            });
            $('#insertModal, #editModal').on('show.bs.modal', function () {
                $(this).removeClass('fadeOut').addClass('fadeIn');
            });

            // 关闭模态框时添加动画效果
            $('#insertModal, #editModal').on('hide.bs.modal', function () {
                $(this).removeClass('fadeIn').addClass('fadeOut');
            });

            // 初始化加载管理员列表
            loadAdminsList();
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
<button id="insertButton">插入管理员</button>
<div class="center-container">
    <table id="adminsTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>名称</th>
            <th>密码</th>
            <th>级别</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 管理员列表将在这里显示 -->
        </tbody>
    </table>
</div>
<!-- 插入按钮 -->


<!-- 编辑模态框 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span id="closeEditModal" class="close">&times;</span>
        <h3>编辑管理员</h3>
        <form id="editForm">
            <div class="error-message"></div>
            <label for="editUsername">名称：</label>
            <input type="text" id="editUsername" name="username" required>
            <br>
            <label for="editPassword">密码：</label>
            <input type="password" id="editPassword" name="password" required>
            <br>
            <label for="editPermission">级别：</label>
            <input type="text" id="editPermission" name="permission" required>
            <br>
            <!-- 用于存储管理员ID -->
            <input type="hidden" id="editAdminId" name="adminId">
            <button type="submit">更新</button>
        </form>
    </div>
</div>

<!-- 插入模态框 -->
<div id="insertModal" class="modal">
    <div class="modal-content">
        <span id="closeInsertModal" class="close">&times;</span>
        <h3>插入管理员</h3>
        <form id="insertForm">
            <div class="error-message"></div>
            <label for="insertUsername">名称：</label>
            <input type="text" id="insertUsername" name="username" required>
            <br>
            <label for="insertPassword">密码：</label>
            <input type="password" id="insertPassword" name="password" required>
            <br>
            <label for="insertPermission">级别：</label>
            <input type="text" id="insertPermission" name="permission" required>
            <br>
            <button type="submit">插入</button>
        </form>
    </div>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span id="closeDeleteModal" class="close">&times;</span>
        <h3>确认删除管理员</h3>
        <button id="confirmDeleteButton">确认删除</button>
    </div>
</div>
</body>
</html>

