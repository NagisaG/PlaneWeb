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
                    url: '/admin/plane/getplanesList',
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
                    row += '<td><a href="${pageContext.request.contextPath}/admin/plane/toplanePage?plane_id=' + plane.plane_id + '">' + plane.cname + '</a></td>';
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
                        row += '<td>';
                        row += '<button class="editButton" data-plane-id="' + plane.plane_id + '">编辑</button>';
                        row += '<span class="button-spacing"></span>'; // 使用<span>元素设置按钮之间的距离
                        row += '<button class="deleteButton" data-plane-id="' + plane.plane_id + '">删除</button>';
                        row += '</td>';

                        row += '</tr>';

                        tableBody.append(row);
                    });
                });


                // 为编辑按钮绑定点击事件
                $('.editButton').click(function () {
                    var planeId = $(this).data('plane-id');
                    fillEditForm(planeId);
                    $('#editModal').css('display', 'block');
                });
                $('.deleteButton').click(function () {
                    var planeId = $(this).data('plane-id');
                    deletePlane(planeId);
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

                var cname = $('#insertCname').val();
                var company = $('#insertCompany').val();
                var ename = $('#insertEname').val();
                var ptype = $('#insertPtype').val();
                var img = $('#insertImg').val();
                var first = $('#insertFirst').val();
                var license = $('#insertLicense').val();
                var wings = $('#insertWings').val();
                var usage = $('#insertUsage').val();
                var seats = $('#insertSeats').val();
                var flight = $('#insertFlight').val();
                var price = $('#insertPrice').val();
                var power = $('#insertPower').val();

                var formData = {
                    "cname": cname,
                    "company": company,
                    "ename": ename,
                    "ptype": ptype,
                    "img": img,
                    "first": first,
                    "license": license,
                    "wings": wings,
                    "usage": usage,
                    "seats": seats,
                    "flight": flight,
                    "price": price,
                    "power": power
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/plane/insertPlane',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Insert success:', response);
                        $('#insertModal').css('display', 'none');
                       loadPlanesList();
                    },
                    error: function (xhr) {
                        console.log('Insert error:', xhr.responseText);

                        if (xhr.status === 409) {
                            $('.error-message').text('用户名已存在，请重新输入。');
                        } else {
                            alert('Error inserting plane.');
                        }
                    },
                });
            });

            // 关闭模态框
            $('.close, #closeInsertModal, #closeEditModal').click(function () {
                $('.modal').css('display', 'none');
            });
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

            function fillEditForm(planeId) {
                // 调用getAdminInfo，并传递一个回调函数用于处理成功获取管理员信息后的逻辑
                getPlaneInfo(planeId, function (plane) {
                    // 更新编辑模态框中的表单字段
                    $('#editCname').val(plane.cname);
                    $('#editCompany').val(plane.company);
                    $('#editEname').val(plane.ename);
                    $('#editPtype').val(plane.ptype);
                    $('#editImg').val(plane.img);
                    $('#editFirst').val(plane.first);
                    $('#editLicense').val(plane.license);
                    $('#editWings').val(plane.wings);
                    $('#editUsage').val(plane.usage);
                    $('#editSeats').val(plane.seats);
                    $('#editFlight').val(plane.flight);
                    $('#editPrice').val(plane.price);
                    $('#editPower').val(plane.power);
                    $('#editPlaneId').val(plane.plane_id);
                });

            }
            function deletePlane(planeId) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/plane/deletePlane',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ plane_id: planeId }),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Delete success:', response);
                        loadPlanesList();
                    },
                    error: function (xhr) {
                        console.log('Delete error:', xhr.responseText);
                        alert('Error deleting plane.');
                    },
                });
            }


            function getPlaneInfo(planeId, callback) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/plane/getPlaneById?id=' + planeId,
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


            // 编辑表单提交事件
            $('#editForm').submit(function (event) {
                event.preventDefault();
                $('.error-message').empty();

                var planeId = $('#editPlaneId').val();
                var newCname = $('#editCname').val();
                var newCompany = $('#editCompany').val();
                var newEname = $('#editEname').val();
                var newPtype = $('#editPtype').val();
                var newImg = $('#editImg').val();
                var newFirst = $('#editFirst').val();
                var newLicense = $('#editLicense').val();
                var newWings = $('#editWings').val();
                var newUsage = $('#editUsage').val();
                var newSeats = $('#editSeats').val();
                var newFlight = $('#editFlight').val();
                var newPrice = $('#editPrice').val();
                var newPower = $('#editPower').val();

                var updatedPlane = {
                    plane_id: planeId,
                    cname: newCname,
                    company: newCompany,
                    ename: newEname,
                    ptype: newPtype,
                    img: newImg,
                    first: newFirst,
                    license: newLicense,
                    wings: newWings,
                    usage: newUsage,
                    seats: newSeats,
                    flight: newFlight,
                    price: newPrice,
                    power: newPower
                };


                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/plane/update',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedPlane),
                    dataType: 'json',
                    success: function (response) {
                        console.log('Update success:', response);
                        $('#editModal').css('display', 'none');
                        loadPlanesList();
                    },
                    error: function (xhr) {
                        console.log('Update error:', xhr.responseText);

                        if (xhr.status === 400) {
                            alert('Update failed: ' + xhr.responseText);
                        } else {
                            alert('Error updating plane.');
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
            loadPlanesList();
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
<button id="insertButton">插入飞机</button>
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
        <h3>编辑飞机</h3>
        <form id="editForm">
<%--            <div class="error-message"></div>--%>
<%--            <label for="editUsername">名称：</label>--%>
<%--            <input type="text" id="editUsername" name="username" required>--%>
<%--            <br>--%>
<%--            <label for="editPassword">密码：</label>--%>
<%--            <input type="password" id="editPassword" name="password" required>--%>
<%--            <br>--%>
<%--            <label for="editPermission">级别：</label>--%>
<%--            <input type="text" id="editPermission" name="permission" required>--%>
<%--            <br>--%>
    <label for="editCname">中文名称：</label>
    <input type="text" id="editCname" name="cname" required>
    <br>
    <label for="editCompany">公司：</label>
    <input type="text" id="editCompany" name="company" required>
    <br>
    <label for="editEname">英文名称：</label>
    <input type="text" id="editEname" name="ename" required>
    <br>
<%--    <label for="editPtype">飞机类型：</label>--%>
<%--    <input type="text" id="editPtype" name="ptype" required>--%>
    <label for="editPtype">飞机类型：</label>
    <select id="editPtype" name="ptype" required>
        <option value="1">多用途飞机</option>
        <option value="2">公务机</option>
        <option value="3">农林飞机</option>
        <option value="4">特种飞机</option>
        <option value="5">小型飞机</option>
        <option value="6">旋翼机</option>
    </select>
    <br>
    <label for="editImg">图片：</label>
    <input type="text" id="editImg" name="img" required>
    <br>
    <label for="editFirst">首飞时间：</label>
    <input type="text" id="editFirst" name="first" required>
    <br>
    <label for="editLicense">许可证：</label>
    <input type="text" id="editLicense" name="license" required>
    <br>
    <label for="editWings">飞行翼：</label>
    <input type="text" id="editWings" name="wings" required>
    <br>
    <label for="editUsage">水陆：</label>
    <input type="text" id="editUsage" name="usage" required>
    <br>
    <label for="editSeats">座位数：</label>
    <input type="text" id="editSeats" name="seats" required>
    <br>
    <label for="editFlight">航程：</label>
    <input type="text" id="editFlight" name="flight" required>
    <br>
    <label for="editPrice">价格：</label>
    <input type="text" id="editPrice" name="price" required>
    <br>
    <label for="editPower">使用能源：</label>
    <input type="text" id="editPower" name="power" required>
    <br>
<%--    <label for="editPlaneId">飞机ID：</label>--%>
<%--    <input type="text" id="editPlaneId" name="planeId" required>--%>
            <!-- 用于存储管理员ID -->
            <input type="hidden" id="editPlaneId" name="planeId">
            <button type="submit">更新</button>
        </form>
    </div>
</div>

<!-- 插入模态框 -->
<div id="insertModal" class="modal">
    <div class="modal-content">
        <span id="closeInsertModal" class="close">&times;</span>
        <h3>插入飞机</h3>
        <form id="insertForm">
            <div class="error-message"></div>
            <label for="insertCname">中文名称：</label>
            <input type="text" id="insertCname" name="cname" required>
            <br>

            <label for="insertCompany">生产公司：</label>
            <input type="text" id="insertCompany" name="company" required>
            <br>

            <label for="insertEname">英文名称：</label>
            <input type="text" id="insertEname" name="ename" required>
            <br>

            <label for="insertPtype">飞机类型：</label>
            <select id="insertPtype" name="ptype" required>
                <option value="1">多用途飞机</option>
                <option value="2">公务机</option>
                <option value="3">农林飞机</option>
                <option value="4">特种飞机</option>
                <option value="5">小型飞机</option>
                <option value="6">旋翼机</option>
                <option value="10">其他</option>
            </select>
            <br>

            <label for="insertImg">图片：</label>
            <input type="text" id="insertImg" name="img" required>
            <br>

            <label for="insertFirst">首飞时间：</label>
            <input type="text" id="insertFirst" name="first" required>
            <br>

            <label for="insertLicense">飞行执照：</label>
            <input type="text" id="insertLicense" name="license" required>
            <br>

            <label for="insertWings">飞行翼：</label>
            <input type="text" id="insertWings" name="wings" required>
            <br>

            <label for="insertUsage">水陆：</label>
            <input type="text" id="insertUsage" name="usage" required>
            <br>

            <label for="insertSeats">座位数：</label>
            <input type="text" id="insertSeats" name="seats" required>
            <br>

            <label for="insertFlight">航程：</label>
            <input type="text" id="insertFlight" name="flight" required>
            <br>

            <label for="insertPrice">生产价格：</label>
            <input type="text" id="insertPrice" name="price" required>
            <br>

            <label for="insertPower">使用能源：</label>
            <input type="text" id="insertPower" name="power" required>
            <br>
            <button type="submit">插入</button>
        </form>
    </div>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span id="closeDeleteModal" class="close">&times;</span>
        <h3>确认删除飞机</h3>
        <button id="confirmDeleteButton">确认删除</button>
    </div>
</div>
</body>
</html>

