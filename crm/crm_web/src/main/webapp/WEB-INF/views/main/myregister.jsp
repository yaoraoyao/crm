<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>租户注册/登录</title>
    <meta charset="UTF-8">
    <%@include file="../common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=nbOoF1wAGtwE1z9jm5fkqwLUf7ECyZeI"></script>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <link href="/static/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/register.js"></script>
    <style>
        .el-select .el-input {
            width: 130px;
        }

        .input-with-select .el-input-group__prepend {
            background-color: #fff;
        }

        .avatar-uploader .el-upload {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .avatar-uploader .el-upload:hover {
            border-color: #409EFF;
        }

        .avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 80px;
            height: 80px;
            line-height: 80px;
            text-align: center;
        }

        .avatar {
            width: 80px;
            height: 80px;
            display: block;
        }
    </style>
</head>
<body>
<div class="aui-register-popup">
    <div id="app" class="aui-register-box" >
        <div class="aui-register-link">
            <a href="javascript:;" class="fl">返回首页</a>
            <a href="/login" class="fr">已有账号？去登录</a>
        </div>
        <div class="aui-register-logo">
            <h2>登录/注册</h2>
        </div>
        <div style="text-align: center">
            <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="80px"
                     class="demo-ruleForm" >

                <el-form-item>
                    <el-col :span="10">
                        <el-form-item label="公司账户" prop="sysName">
                            <el-input placeholder="此账户将作为你的登录账户"
                                      type="text" v-model="ruleForm.sysName">
                            </el-input>
                        </el-form-item>

                    </el-col>

                    <el-col :span="10">
                        <el-form-item label="密码" prop="password">
                            <el-input placeholder="此密码将作为你的登录密码"  type="password"
                                      v-model="ruleForm.password">
                            </el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item>

                    <el-col :span="10">
                        <el-form-item label="手机电话" prop="companyTel">
                            <el-input
                                    type="text"
                                    placeholder="请输入"
                                    v-model="text"
                                    v-model.number="ruleForm.companyTel"
                                    maxlength="20"
                                    show-word-limit></el-input>
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item label="座机电话" prop="companyNum">
                            <el-input
                                    type="text"
                                    placeholder="请输入"
                                    v-model="text"
                                    v-model.number="ruleForm.companyNum"
                                    maxlength="20"
                                    show-word-limit>
                            </el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item>
                    <el-col :span="10">
                        <el-form-item label="邮件" prop="email">
                            <el-input type="text" v-model="ruleForm.email"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="公司名称" prop="companyName">
                            <el-input type="text" v-model="ruleForm.companyName"></el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>

                <el-form-item>
                    <el-col :span="20">
                        <el-form-item label="公司地址">
                            <el-input
                                    type="text"
                                    v-model="ruleForm.address"
                                    placeholder="地址" @focus="openMap">
                            </el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>

                <el-form-item>
                    <el-col :span="10">
                        <el-form-item label="租户状态" prop="state">
                            <%--状态-0 注册 ，1付费，2欠费--%>
                            <el-select v-model.number="ruleForm.state" placeholder="请选择">
                                <el-option
                                        v-for="item in payValue"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item label="套餐" prop="setMealId">
                            <el-select v-model.number="ruleForm.setMealId" placeholder="请选择">
                                <el-option
                                        v-for="item in setMeal"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>

                </el-form-item>


                <el-form-item>
                    <el-col :span="10">
                        <el-form-item label="公司logo" prop="logoUrl" label-with="50">
                            <el-upload
                                    class="avatar-uploader"
                                    name="picture"
                                    action="http://localhost/tenant/upload"
                                    :show-file-list="false"
                                    :on-success="handleAvatarSuccess"
                                    :before-upload="beforeAvatarUpload">
                                <img v-if="imageUrl" :src="logoUrl" class="avatar">
                                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                            </el-upload>

                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="是否支付" prop="pay">
                            <el-select v-model.number="ruleForm.pay" placeholder="请选择">
                                <el-option
                                        v-for="item in options"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>

            </el-form>
        </div>
        <%--百度地图--%>
        <el-dialog
                :visible.sync="dialogVisible_contract"
                width="80%" >
            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:500px;height:auto; display:none;"></div>
            <div id="r-result">请输入:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /><el-button size="mini" round @click="mapYes">确定</el-button></div>

            <div id="container" style="height: 300px"> </div>

        </el-dialog>
    </div>
</div>
<script>
    var checkName = (rule, value, callback) => {
        if (!value) {
            return callback(new Error('商品名称不能为空'));
        }
    };

    var app = new Vue({
        el: '#app',
        data: {
            dialogVisible_contract:false,
            value1: "true",
            mealName: [],
            setMeal: [{
                value: '',
                label: ''
            }],
            imageUrl: '',
            options: [
                {
                    value: false,
                    label: '未付'
                }, {
                    value: true,
                    label: '支付'
                }],
            //状态-0 注册 ，1付费，2欠费
            payValue: [
                 {
                    value: 0,
                    label: '注册'
                }, {
                    value: 1,
                    label: '付费'
                }, {
                    value: 2,
                    label: '欠费'
                }],
            text: '',
            textarea: '',
            totalNum: 0,
            currentPage: 1,
            pageNum: 1,
            pageSize: 10,
            ruleForm: {
                companyName:'',
                password:'',
                companyTel:'',
                companyNum:'',
                email:'',
                sysName:'',
                address:'',
                coordinate:''
            },
            rules: {
                companyName: [
                    {
                        required: true,
                        max: 14,
                        min: 7,
                        message: '用户名是必须的，长度为7-14位',
                        trigger: 'blur'
                    }
                ],
                password: [
                    {
                        required: true,
                        message: '密码是必须的！',
                        trigger: 'blur'
                    }
                ],
                companyTel: [
                    {
                        required: true,
                        validator:  (rule, value, callback)=> {
                            if (value === '') {
                                return callback(new Error('电话号码是必须的'))
                            } else if (!Number.isInteger(value)) {
                                return callback(new Error('电话号码必须是数字'))
                            } else if (value.toString().length !== 11) {
                                return callback(new Error('电话号码必须是11位数字'))
                            } else {
                                callback()
                            }
                        },
                        trigger: 'blur'
                    }
                ],
                companyNum:[
                    {
                        required: true,
                        validator:  (rule, value, callback)=> {
                            if (value === '') {
                                return callback(new Error('座机号码号码是必须的'))
                            } else if (!Number.isInteger(value)) {
                                return callback(new Error('电话号码必须是数字'))
                            } else if (value.toString().length !== 8) {
                                return callback(new Error('电话号码必须是8位数字'))
                            } else {
                                callback()
                            }
                        },
                        trigger: 'blur'
                    }
                ],
                email: [
                    {
                        required: true,
                        type: 'email',
                        message: '请输入正确的电子邮件格式(xxx@xxx.com)',
                        trigger: 'blur'
                    }
                ],/*公司账号*/
                sysName:[
                    {
                        required: true,
                        validator: (rule, value, callback)=> {
                            axios.get('/userSole', {params: {
                                    username: value
                                }
                            }).then((resp)=>{
                                if(resp.data.success){
                                    callback()
                                }else {
                                    return callback(new Error('该用户存在'))
                                }
                            })
                        },
                        trigger: 'blur'
                    }
                ],
                name: [
                    {
                        required: true,
                        max: 12,
                        min: 2,
                        message: '昵称是必须的，最好是汉字',
                        trigger: 'blur'
                    }
                ]
            },
            dialogVisible: false,
            inputSearch: '',
            editableTabsValue: '1',
            editableTabs: [],
            tabIndex: 1,
            tableData: [],
            currentRow: null
        },
        methods: {
            changeStatus: function (callback) {
                /* console.log(callback);*/
            },
            uploadImage() {
                var params = "";
                axios.post("/tenant/upload", params).then(function (res) {
                    //console.debug(res);
                    if (res.data.success) {
                        self.dialogVisible = false;
                        self.loadTenantData();
                    } else {
                        self.$message({
                            type: 'error',
                            message: res.data.msg
                        });
                    }
                }).catch(function () {
                })
            },
            handleAvatarSuccess(res, file) {
                this.tableData.logoUrl = URL.createObjectURL(file.raw);
                /* this.uploadImage();*/
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 2;

                //创建临时的路径来展示图片
                var windowURL = window.URL || window.webkitURL;

                if (!isJPG) {
                    this.$message.error('上传头像图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            },
            editTenant() {
                // console.debug("前台付费值："+this.payValue);
                if (this.currentRow) {
                    this.dialogVisible = true;
                    this.ruleForm = this.currentRow;
                    /*this.ruleForm.payValue=this.payValue;*/
                } else {
                    this.$message({
                        message: '请选中需要编辑的数据!!!',
                        type: 'warning'
                    });
                }
            },
            submitForm(formName) {
                var self = this;
                var params = this.ruleForm;
                axios.post("/register", params).then(function (res) {
                    //console.debug(res);
                    if (res.data.success) {
                        location='/login'
                    } else {
                        self.$message({
                            type: 'error',
                            message: res.data.msg
                        });
                    }
                }).catch(function () {
                })
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            loadTenantData() {
                var pageParam = {"keyword": this.keyword, "pageNum": this.pageNum, "pageSize": this.pageSize};
                var self = this;
                axios.post("/tenant/findByPage", pageParam).then(function (res) {
                    self.tableData = res.data.rows;
                    self.totalNum = res.data.total;
                    for (var i = 0; i < res.data.rows.length; i++) {
                        /*self.payValue = res.data.rows[i].pay;*/
                        /* console.debug("数据库bb付费值："+res.data.rows[i].pay);*/
                        if (res.data.rows[i].pay) {
                            self.tableData[i].pay = '已付'
                        } else {
                            self.tableData[i].pay = '未付'
                        }

                        if (res.data.rows[i].state == 0) {
                            self.tableData[i].state = '注册'
                        } else if (res.data.rows[i].state == 1) {
                            self.tableData[i].state = '付费'
                        } else if (res.data.rows[i].state == 2) {
                            self.tableData[i].state = '欠费'
                        } else {
                            self.tableData[i].state = '该用户不存在'
                        }
                    }
                }).catch(function () {
                })
            },
            mealFindAll(){
                var self = this;
                var para = {id:1}
                axios.get("/setMeal/findStatus",{params:para}).then(function(res){
                    console.debug(res.data)
                    for(var i =0; i <res.data.length; i++){
                        self.setMeal.push({
                            value:'',
                            label:''
                        })
                        self.setMeal[i].value=res.data[i].id
                        self.setMeal[i].label=res.data[i].mealName
                        // console.debug(self.setMeal);
                    }
                }).catch(function(){

                })
            },
            openMap(){
                app.ruleForm.coordinate=''
                this.dialogVisible_contract=true
                this.$nextTick( () =>{
                    var map = new BMap.Map("container");
                    map.centerAndZoom("北京",12);
                    // 初始化地图,设置城市和地图级别。
                    function G(id) {
                        return document.getElementById(id);
                    }
                    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
                        {"input" : "suggestId"
                            ,"location" : map
                        });
                    ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
                        var str = "";
                        var _value = e.fromitem.value;
                        var value = "";
                        if (e.fromitem.index > -1) {
                            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
                        }
                        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

                        value = "";
                        if (e.toitem.index > -1) {
                            _value = e.toitem.value;

                            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;

                        }
                        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
                        G("searchResultPanel").innerHTML = str;
                    });
                    var myValue;
                    ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
                        var _value = e.item.value;
                        myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
                        app.ruleForm.address=myValue;/*给地址赋值*/
                        G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
                        var myGeo = new BMap.Geocoder();
                        myGeo.getPoint(app.ruleForm.address, function(point){
                            console.debug(point)
                            app.ruleForm.coordinate=point.lat+","+point.lng;
                            console.debug(app.ruleForm.coordinate)
                            if (point) {
                                map.centerAndZoom(point, 16);
                                map.addOverlay(new BMap.Marker(point));
                            }else{
                                alert("您选择地址没有解析到结果!");
                            }
                        }, "北京市");
                        setPlace();
                    });/*将地址解析为坐标*/

                    function setPlace(){
                        map.clearOverlays();    //清除地图上所有覆盖物
                        function myFun(){
                            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                            map.centerAndZoom(pp, 18);
                            map.addOverlay(new BMap.Marker(pp));    //添加标注
                        }
                        var local = new BMap.LocalSearch(map, { //智能搜索
                            onSearchComplete: myFun
                        });
                        local.search(myValue);
                    }
                })
            },
            mapYes(){
                this.dialogVisible_contract=false
            }
        },

        mounted() {
            this.mealFindAll();
            this.loadTenantData();
        }
    });
</script>
</body>
</html>
