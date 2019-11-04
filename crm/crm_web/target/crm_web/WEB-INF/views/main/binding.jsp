<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BOSS客户关系管理系统</title>
        <%@include file="/WEB-INF/views/common.jsp" %>
    </head>
    <style type="text/css">

        /*.login-box {*/
            /*border: 1px solid #DCDFE6;*/
            /*width: 350px;*/
            /*margin: 180px auto;*/
            /*padding: 35px 35px 15px 35px;*/
            /*border-radius: 5px;*/
            /*-webkit-border-radius: 5px;*/
            /*-moz-border-radius: 5px;*/
            /*box-shadow: 0 0 25px palegreen;*/
        /*}*/
        /*.login-title {*/
            /*text-align: center;*/
            /*margin: 0 auto 40px auto;*/
            /*color: #66CD00;*/
            /*font-size: 30px;*/
            /*font-weight: bold;*/
        /*}*/
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
            margin-top: 30px;
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
            border-radius: 5px;
            text-align: left;
            padding: 5px 27px 10px;
            position: relative;
            box-sizing: border-box;
            box-shadow: 0 0 3px 0 #ddd;
            margin-bottom: -30px;
            min-height: 260px;
        }

    </style>
    <body>
    <%--<div id="app" class="login-box">--%>
        <%--<img class="bg-image" src="../../../exclusive/images/new-login-bg.jpg">--%>
        <%--<el-form :rules="rules":model="Form" label-position="right" label-width="auto" show-message class="login-container">--%>
            <%--<span class="login-title">绑定账号</span>--%>
            <%--<el-form-item label="用户名"  >--%>
                <%--<el-col :span="22">--%>
                    <%--<el-input type="text" v-model="Form.username"></el-input>--%>
                <%--</el-col>--%>
            <%--</el-form-item>--%>
            <%--<el-form-item label="密码" >--%>
                <%--<el-col :span="22">--%>
                    <%--<el-input type="password" v-model="Form.password"></el-input>--%>
                <%--</el-col>--%>
            <%--</el-form-item>--%>
            <%--<el-form-item>--%>
                <%--<el-button type="primary" @click="goLogin">绑定</el-button>--%>
            <%--</el-form-item>--%>
        <%--</el-form>--%>

    <%--</div>--%>
    <div id="app">

        <img class="bg-image" src="../../../exclusive/images/new-login-bg.jpg">
        <el-form :model="loginUser" :rules="loginFormRules" ref="loginForm" label-position="left" label-width="0px" class="demo-ruleForm login-container login-box">
            <h3 class="title">绑定账号</h3>

            <el-form-item >
                <el-input type="text" v-model="Form.username" auto-complete="off" placeholder="用户名"></el-input>
            </el-form-item>
            <el-form-item >
                <el-input type="password" v-model="Form.password" auto-complete="off" placeholder="密码"></el-input>
            </el-form-item>
            <el-form-item>
            <el-button type="primary" @click="goLogin">绑定</el-button>
            </el-form-item>
        </el-form>
    </div>
    <script type="text/javascript">
        var app = new Vue({
                el: "#app",
                data: {
                    Form: {
                        username: "",
                        password: ""
                    },
                    rules: {
                        username: [
                            {required: true, message: '请输入用户名', trigger: "blur"},
                            {min: 5, max: 16, message: '用户名由5-16位的英文字母数字下划线组成', trigger: "blur"}
                        ],
                        password: [
                            {required: true, message: '请输入密码', trigger: "blur"},
                            {min: 5, max: 16, message: '密码由5-16位的字母数字下划线组成', trigger: "blur"},
                        ]
                    },
                    isLogin: false,
                },
                methods: {
                    goLogin() {
                        // alert(0)
                        axios.post('/binding', this.Form).then((res) => {
                            if (res.data.success) {
                                //成功
                                location = '/main'
                            } else {
                                this.$message({
                                    message: res.data.msg,
                                    type: 'error',
                                });
                            }
                        })
                    },

                }
        })

                //      this.$refs[formName].validate(valid => {
                //         fetchPost("/login", this.Form).then(res => {
                //             if (res.code != 1) {
                //                 this.$message.error('登录失败')
                //             }
                //             this.loginSuccess(res.data)
                //             this.setToken(res.data.Token)
                //             else {
                //                 this.$message('错误')
                //             }
                //              return false;
                //     }
                // });
                // },
         </script>
<script>
    if(window.top != window){
        window.top.location = "/binding";
    }
</script>
    </body>
</html>
