<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<head>
    <title>Index Page</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            padding: 0;
            margin: 0;
            text-decoration: none;
        }

        body {
            background-color: rgb(209, 213, 219);
            display: flex;
            /*justify-content: space-evenly;*/
            height: 100vh;
            align-items: center;
            margin: 0;
        }

        .shell {
            width: 100px;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: rgb(17, 24, 39);
            border-radius: 10px;
            transition: .3s;
            overflow: hidden;
        }

        .box {
            display: block;
            height: 15%;
            width: 85%;
            margin: 9px;
            border-radius: 5px;
            position: relative;
            transition: .3s;
            color: rgb(160, 160, 175);
        }
        .box i {
            font-size: 60px;
            position: absolute;
            margin: 7px 0 0 13px;
        }

        .box:nth-child(1)::before,
        .box:nth-child(5)::before{
            content: '';
            display: block;
            width: 100%;
            height: 2px;
            background-color: rgb(55, 65, 81);
            position: absolute;
            bottom: -10px;
        }

        .box span{
            position: relative;
            top: 22px;
            left: 80px;
            font: 500 20px '';
            opacity: 0;
            transition: .1s;
        }
        .shell:hover{
            width: 270px;
        }
        .box:hover{
            background-color: rgb(55, 65, 81);
        }
        .shell:hover span{
            opacity: 1;
        }
        .box:hover{
            color: #fff;
        }

        .shell:nth-child(2) {
            background-color: rgb(243, 244, 246);
        }
        .shell:nth-child(2) .box:hover{
            background-color: rgb(209, 213, 219);
            color: rgb(241, 159, 159);
        }
        .shell:nth-child(2) .box{
            color: #000;
        }

        .shell:nth-child(3) {
            background-color: rgb(49,46,129);
        }
        .shell:nth-child(3) .box:hover{
            background-color: rgb(67, 56, 202);
        }
        .shell:nth-child(3) .box{
            color: rgb(140, 120, 240);
        }
        /*html, body {*/
        /*    height: 100%;*/
        /*    margin: 0;*/
        /*    display: flex;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*}*/

        .container {
            text-align: center;height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 50%;
            margin: 0 auto;
        }
    </style>
</head>

<body>
<!-- 侧边栏 -->
<div class="shell">
    <a href="${pageContext.request.contextPath}/plane/toPlaneIndex" class="box"><i class="iconfont icon-liebiao"></i><span>飞机首页</span></a>
    <a href="${pageContext.request.contextPath}/type/toTypeIndex" class="box"><i class="iconfont icon-cangku"></i><span> 类型首页</span></a>
    <a href="${pageContext.request.contextPath}/admin/index" class="box"><i class="iconfont icon-zhuti_tiaosepan"></i><span>登录</span></a>
</div>
<div class="container">
    <h1>欢迎来到飞机科普网</h1>
</div>
</body>

</html>