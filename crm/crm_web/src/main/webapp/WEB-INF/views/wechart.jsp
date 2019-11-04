<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>微信登录界面</title>
    <link href="/static/css/style.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        #login_container {
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-border-radius: 5px;
            background-clip: padding-box;
            margin: 100px auto;
            width: 350px;
            padding: 35px 35px 15px 35px;
            background: #fff;
            border: 1px solid #eaeaea;
            box-shadow: 0 0 25px #cac6c6;
        }
        * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            margin-left: -10px;
        }
    </style>
</head>

<body>
<span>
    <div id="login_container" >
    </div>
</span>
<%--<span id="login_container"></span>--%>

<script type="text/javascript" src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
<script type="text/javascript">
    var obj = new WxLogin({
        self_redirect:true,
        id:"login_container",
        appid: "wxd853562a0548a7d0",
        scope: "snsapi_login",
        redirect_uri: "http://bugtracker.itsource.cn/wechart2/callback",
        state: "xxx",
        style: "black",
        href: ""
    });
</script>

</body>
</html>
