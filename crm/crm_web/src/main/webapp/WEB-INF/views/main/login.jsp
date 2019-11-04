<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>欢迎登录</title>
    <base href="<%=basePath%>"/>
    <%@ include file="/WEB-INF/views/common.jsp" %>
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <link href="/static/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/register.js"></script>
    <style type="text/css">
        .login-container {
            /*box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);*/
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-border-radius: 5px;
            background-clip: padding-box;
            margin: 180px auto;
            width: 350px;
            padding: 35px 35px 15px 35px;
            background: #fff;
            border: 1px solid #eaeaea;
            box-shadow: 0 0 25px #cac6c6;
        }
        .title {
            margin: 0px auto 40px auto;
            text-align: center;
            color: #505458;
            margin-top: 20px;
        }
        .remember {
            margin: 0px 0px 35px 0px;
        }
        .oauthLogin a{
            display: block;
            float: right;
            width: 42px;
            height: 42px;
            background-image: url("/exclusive/images/oauth.png");
            margin-right:10px;
            background-repeat: no-repeat;
        }

        .oauthLogin .qq:hover{
            background-position: 0px -50px;
        }

        .oauthLogin .wx{
            background-position: -50px 0px;
        }
        .oauthLogin .wx:hover{
            background-position: -50px -50px;
        }
        .oauthLogin .wb{
            background-position: -100px 0px;
        }

        .oauthLogin .wb:hover{
            background-position: -100px -50px;
        }
        .bg-image {
            width: 1920px;
            height: 1080px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
        }
        .login-box {
            background: #fff;
            min-height: 400px;
            border-radius: 5px;
            text-align: left;
            padding: 5px 27px 10px;
            position: relative;
            box-sizing: border-box;
            box-shadow: 0 0 3px 0 #ddd;
            margin-bottom: -30px;
        }

        a {
            color: #a48a96;
        }

    </style>
</head>
<body>
<div id="app">

    <img class="bg-image" src="../../../exclusive/images/new-login-bg.jpg">
    <el-form :model="loginUser" :rules="loginFormRules" ref="loginForm" label-position="left" label-width="0px" class="demo-ruleForm login-container login-box">
        <h3 class="title">欢迎登录</h3>
        <el-form-item prop="account">
            <el-input type="text" v-model="loginUser.account" auto-complete="off" placeholder="账号"></el-input>
        </el-form-item>
        <el-form-item prop="checkPass">
            <el-input type="password" v-model="loginUser.checkPass" auto-complete="off" placeholder="密码" @keyup.native.enter="handleLogin"></el-input>
        </el-form-item>
        <el-checkbox v-model="checked" class="remember">记住密码</el-checkbox>
        <el-form-item style="width:100%;">
            <el-button type="primary" style="width:100%;" @click.native.prevent="handleLogin" :loading="logining">登录</el-button>
        </el-form-item>

        <el-form-item style="width:100%;">
                <el-col :span="24" class="oauthLogin">
                    <a class="qq" href="#"></a>
                    <a class="wx" href="/wechart"></a>
                    <a class="wb" href="#"></a>
                </el-col>
        </el-form-item>
        <div>
            <a href="/register" class="txt2">没有账号？立即注册！</a>
        </div>
    </el-form>
</div>
<script>
    new Vue({
        el:"#app",
        data:{
            logining: false,
            loginUser: {
                account: '',
                checkPass: ''
            },
            loginFormRules: {
                account: [
                    { required: true, message: '请输入账号', trigger: 'blur' },
                ],
                checkPass: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                ]
            },
            checked: false
        },
        methods: {
            handleLogin(ev) {
                var _this = this;
                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        this.logining = true;
                        var loginParams = { username: this.loginUser.account, password: this.loginUser.checkPass };
                        //发送登录请求
                        axios.post("/login",loginParams)
                            .then((res)=>{
                                let data = res.data;
                                if(data.success){
                                    //登录成功
                                    this.logining = false;
                                    //跳转到首页
                                    location.href="main";
                                }else{
                                    this.logining = false;
                                    this.$message.error(data.msg)
                                }
                            })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            }
        }
    })
</script>
</body>
</html>
