<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <title>客户关系管理系统</title>
    <meta charset="UTF-8">
    <%@include file="common.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=nbOoF1wAGtwE1z9jm5fkqwLUf7ECyZeI"></script>
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

        .el-header {
            background-color: #B3C0D1;
            color: #333;
            line-height: 60px;
        }

        .el-aside {
            color: #333;
        }
        .avatar {
            width: 80px;
            height: 80px;
            display: block;
        }
        /*#tangram-suggestion--TANGRAM__4k-main{
            position: absolute;

            left: 189px;

            top: 151px;

            width: 155px;

            z-index: 20000;

        }*/
        #tangram-suggestion--TANGRAM__1c-main{
            position: absolute;

            left: 189px;

            top: 151px;

            width: 155px;

            z-index: 20000;

        }
    </style>
</head>

<body>
<div id="app">
    <el-container style="height: 80%; border: 1px solid #eee">
        <el-container>
            <el-main>
                <el-row>
                    <el-col :span="3">
                        <el-input v-model="inputSearch" placeholder="请输入内容" clearable></el-input>
                    </el-col>
                    <el-col :span="2">
                        <el-button type="info" icon="el-icon-search" @click="TenantSearcher">搜索</el-button>
                    </el-col>
                    <el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>
                    <el-button type="danger" icon="el-icon-delete" @click="deleteTenant">删除</el-button>
                </el-row>
                <el-table size="mini" :fit="fit" ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%" >

                    <el-table-column property="id"  label="编号" width="50" sortable>
                    </el-table-column>

                    <el-table-column property="companyName" label="公司注册名称" width="200">
                        <template slot-scope="scope">
                            <el-popover trigger="hover" placement="top">
                                <p>公司注册名称: {{ scope.row.companyName }}</p>
                                <p>密码: {{ scope.row.password }}</p>
                                <p>手机号码: {{ scope.row.companyTel }}</p>
                                <p>座机号码: {{ scope.row.companyNum }}</p>
                                <p>邮箱: {{ scope.row.email }}</p>
                                <p>公司账户: {{ scope.row.sysName }}</p>
                                <p>注册时间: {{ scope.row.registerTime }}</p>
                                <p>公司坐标: {{ scope.row.coordinate }}</p>
                                <div slot="reference" class="name-wrapper">
                                    <el-tag size="medium">{{ scope.row.companyName }}</el-tag>
                                </div>
                            </el-popover>
                        </template>
                    </el-table-column>
                    <el-table-column property="state" label="租户状态" width="150">
                    </el-table-column>

                    <el-table-column property="address" label="公司地址" width="200">
                    </el-table-column>

                    <%--<el-table-column property="coordinate" label="公司坐标" width="50">--%>
                    <%--</el-table-column>--%>
                    <el-table-column  label="公司图片" width="150">
                        <!-- 图片的显示 -->
                        <template   slot-scope="scope">
                            <img :src="scope.row.logoUrl"  min-width="80" height="120" />
                        </template>
                    </el-table-column>

                    <el-table-column property="mealName" label="套餐" width="110">
                    </el-table-column>

                    <el-table-column property="pay" label="套餐付费" width="110">
                    </el-table-column>
                    <%-- /exclusive/images--%>

                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button type="warning" icon="el-icon-edit" size="mini" @click="editTenant" round>编辑</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <div class="block">
                    <el-pagination
                            @size-change="handleSizeChange"
                            @current-change="handleCurrentChange"
                            :current-page="currentPage"
                            :page-sizes="[5, 10, 20, 40]"
                            :page-size="10"
                            layout="total, sizes, prev, pager, next, jumper"
                            :total="totalNum">

                    </el-pagination>
                </div>
            </el-main>
        </el-container>
    </el-container>
        <el-dialog title="添加/编辑租户" :visible.sync="dialogVisible" width="60%" :before-close="handleClose">
            <%--表单开始--%>
            <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="120px" class="demo-ruleForm" label-position="right"  >

                <el-form-item >
                    <el-col :span="12">
                        <el-form-item label="公司注册名称" prop="companyName">
                            <el-input type="text" v-model="ruleForm.companyName"></el-input>
                        </el-form-item>
                    </el-col>

                    <el-col :span="12">
                        <el-form-item label="密码" prop="password" >
                            <el-input type="text" v-model="ruleForm.password"></el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item >

                    <el-col :span="12">
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

                    <el-col :span="12">
                        <el-form-item label="座机电话" prop="companyNum">
                            <el-input
                                    type="text"
                                    placeholder="请输入"
                                    v-model="text"
                                    v-model.number="ruleForm.companyNum"
                                    maxlength="20"
                                    show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item >

                    <el-col :span="12">

                        <el-form-item label="邮件" prop="email">
                            <el-input type="text" v-model="ruleForm.email"></el-input>
                        </el-form-item>
                    </el-col>

                    <el-col :span="12">
                        <el-form-item label="公司账户" prop="sysName">
                            <el-input type="text" v-model="ruleForm.sysName"></el-input>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item >
                    <el-form-item>
                        <el-col :span="22">
                            <el-form-item label="公司地址">
                                <el-input
                                        type="text"
                                        v-model="ruleForm.address"
                                        placeholder="地址" @focus="openMap">
                                </el-input>
                            </el-form-item>
                        </el-col>
                    </el-form-item>
                </el-form-item>


                <el-form-item >
                    <el-col :span="12">
                        <el-form-item label="租户状态" prop="state">
                            <%--状态-0 注册 ，1付费，2欠费--%>
                            <el-select  v-model.number="ruleForm.state" placeholder="请选择">
                                <el-option
                                        v-for="item in payValue"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="套餐" prop="setMealId">
                            <el-select  v-model.number="ruleForm.setMealId" placeholder="请选择">
                                <el-option
                                        v-for="item in setMeal"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-form-item>


                <el-form-item >

                    <el-col :span="12">
                        <el-form-item label="公司logo" prop="logoUrl" label-with="50" >
                            <el-upload
                                    ref="upload"
                                    action="/tenant/upload"
                                    name="picture"
                                    list-type="picture-card"
                                    :limit="1"
                                    :on-exceed="onExceed"
                                    :before-upload="beforeAvatarUpload"
                                    :on-preview="handlePreview"
                                    :on-success="handleAvatarSuccess"
                                    :on-remove="handleRemove">
                                <img v-if="imageUrl" :src="imageUrl"  class="avatar"/>
                                <img v-else-if="ruleForm.logoUrl" :src="ruleForm.logoUrl" class="avatar"/>
                                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                            </el-upload>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="套餐支付" prop="pay">
                            <el-select  v-model.number="ruleForm.pay" placeholder="请选择">
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
            <%--表单结束--%>
             <%--百度地图--%>
                <el-dialog
                        :visible.sync="dialogVisible_contract"
                        width="80%" >
                    <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:500px;height:auto; display:none;"></div>
                    <div id="r-result">请输入:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /><el-button size="mini" round @click="mapYes">确定</el-button></div>

                    <div id="containers" style="height: 300px"> </div>

                </el-dialog>
        </el-dialog>
</div>
<script>
    var checkName = (rule, value, callback) => {
        if(!value) {
            return callback(new Error('此处不能为空'));
        }
    };

    var app = new Vue({
        el: '#app',
        data: {
            fit:true,
            value1:"true",
            mealName:[],
            setMeal:[{
                value:'',
                label:''
            }],
            imageUrl: '',
            options: [
                {
                    value: false,
                    label: '支付'
                }, {
                    value: true,
                    label: '已付'
                }],
            //状态-0 注册 ，1付费，2欠费
            payValue: [
                {
                    value: 0,
                    label: '注册'
                },{
                    value: 1,
                    label: '付费'
                }, {
                    value: 2,
                    label: '欠费'
                }],
            text: '',
            textarea: '',
            totalNum:0,
            currentPage: 1,
            pageNum:1,
            pageSize:10,
            ruleForm: {
                TenantName: '',
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
                TenantName: [
                    { validator: checkName, trigger: 'blur' }
                ]
            },
            dialogVisible_contract:false,
            dialogVisible: false,
            inputSearch: '',
            editableTabsValue: '1',
            editableTabs: [],
            tabIndex: 1,
            tableData: [],
            currentRow: null
        },
        methods: {
            changeStatus: function(callback){
                /* console.log(callback);*/
            },
            uploadImage(){
                var params= "";
                axios.post("/tenant/upload",params).then(function(res){
                    //console.debug(res);
                    if(res.data.success){
                        self.dialogVisible = false;
                        self.loadTenantData();
                    }else{
                        self.$message({
                            type: 'error',
                            message: res.data.msg
                        });
                    }
                }).catch(function(){
                })
            },
            //文件上传成功的钩子函数
            handleAvatarSuccess(res, file) {
                this.ruleForm.logoUrl=res;
                this.imageUrl = URL.createObjectURL(file.raw);
                /*console.debug(res)*/
                this.$message({
                    type: 'info',
                    message: '图片上传成功',
                    duration: 6000
                });
                if (file.response.success) {
                    this.editor.picture = file.response.message; //将返回的文件储存路径赋值picture字段
                }
            },
            //点击列表中已上传的文件事的钩子函数
            handlePreview(file) {
            },
            //上传的文件个数超出设定时触发的函数
            onExceed(files, fileList) {
                this.$message({
                    type: 'info',
                    message: '最多只能上传一个图片',
                    duration: 6000
                });
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isGIF = file.type === 'image/gif';
                const isPNG = file.type === 'image/png';
                const isBMP = file.type === 'image/bmp';
                const isLt2M = file.size / 1024 / 1024 < 2;

                //创建临时的路径来展示图片
                var windowURL = window.URL || window.webkitURL;

                if (!isJPG && !isGIF && !isPNG && !isBMP) {
                    this.$message.error('上传图片必须是JPG/GIF/PNG/BMP 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传图片大小不能超过 2MB!');
                }
                return (isJPG || isBMP || isGIF || isPNG) && isLt2M;
            },    //删除文件之前的钩子函数
            handleRemove(file, fileList) {
                this.$message({
                    type: 'info',
                    message: '已删除原有图片',
                    duration: 6000
                });
            },
            editTenant(){
                // console.debug("前台付费值："+this.payValue);
                if(this.currentRow){
                    this.dialogVisible = true;
                    this.ruleForm = this.currentRow;
                    /*this.ruleForm.payValue=this.payValue;*/
                    console.debug(this.ruleForm);
                }else{
                    this.$message({
                        message: '请选中需要编辑的数据!!!',
                        type: 'warning'
                    });
                }
            },
            deleteTenant(){
                if(this.currentRow){
                    this.$confirm('此操作将永久删除'+this.currentRow.TenantName+'吗?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        var self = this;
                        axios.get("/tenant/delete",{params: {id: this.currentRow.id}}).then(function(res){
                            if(res.data.success){
                                self.$message({
                                    type: 'success',
                                    message: '删除成功!'
                                });
                                self.loadTenantData();
                            }else{
                                self.$message({
                                    type: 'error',
                                    message: res.data.msg
                                });
                            }
                        }).catch(function(){
                        })

                    });
                }else{
                    //提示框：
                    this.$message({
                        message: '请选中需要删除的数据!!!',
                        type: 'warning'
                    });
                }
            },
            clickRow(row, column, event){
                //赋值当前选中行
                this.currentRow = row;
            },
            handleSizeChange(val) {
                this.pageSize = val;
                this.TenantSearcher();
            },
            handleCurrentChange(val) {
                this.pageNum = val;
                this.TenantSearcher();
            },
            TenantSearcher(){
                var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/tenant/findByPage",params).then(function(res){
                    self.tableData =  res.data.rows;
                    self.totalNum=res.data.total;
                    for(var i =0; i <res.data.rows.length; i++){
                        console.debug("shujuku"+res.data.rows[i].pay);
                        if(res.data.rows[i].pay){
                            self.tableData[i].pay= '已付'
                        }else{
                            self.tableData[i].pay= '支付'
                        }

                        if(res.data.rows[i].state==0){
                            self.tableData[i].state= '注册'
                        }else if(res.data.rows[i].state==1){
                            self.tableData[i].state= '付费'
                        }else if(res.data.rows[i].state==2) {
                            self.tableData[i].state= '欠费'
                        }else {
                            self.tableData[i].state= '该租户不存在'
                        }
                    }
                }).catch(function(){
                })
            },
            handleClose(done) {
                this.$confirm('确认关闭？')
                    .then(_ => {
                        done();
                    })
                    .catch(_ => {});
            },
            setCurrent(row) {
                this.$refs.singleTable.setCurrentRow(row);
            },
            addTab(targetName) {

                let newTabName = ++this.tabIndex + '';
                this.editableTabs.push({
                    title: '待跟进的客户',
                    name: newTabName,
                    content: '待跟进的客户'
                });
                this.editableTabsValue = newTabName;
            },
            removeTab(targetName) {
                let tabs = this.editableTabs;
                let activeName = this.editableTabsValue;
                if(activeName === targetName) {
                    tabs.forEach((tab, index) => {
                        if(tab.name === targetName) {
                            let nextTab = tabs[index + 1] || tabs[index - 1];
                            if(nextTab) {
                                activeName = nextTab.name;
                            }
                        }
                    });
                }
                this.editableTabsValue = activeName;
                this.editableTabs = tabs.filter(tab => tab.name !== targetName);
            },
            openDialog(){
                this.ruleForm={};
                this.mealFindStatus();
                this.dialogVisible = true;
                console.debug(this.mealFindStatus())
            },
            submitForm(formName) {
                var self = this;
                var params = this.ruleForm;
                axios.post("/tenant/save",params).then(function(res){
                    //console.debug(res);
                    if(res.data.success){
                        self.dialogVisible = false;
                        self.loadTenantData();
                    }else{
                        self.$message({
                            type: 'error',
                            message: res.data.msg
                        });
                    }
                }).catch(function(){
                })
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            loadTenantData() {
                var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/tenant/findByPage",pageParam).then(function (res) {
                    self.tableData=res.data.rows;
                    self.totalNum=res.data.total;
                    for(var i =0; i <res.data.rows.length; i++){
                        /*self.payValue = res.data.rows[i].pay;*/
                        /* console.debug("数据库bb付费值："+res.data.rows[i].pay);*/
                        if(res.data.rows[i].pay){
                            self.tableData[i].pay= '已付'
                        }else{
                            self.tableData[i].pay= '未付'
                        }

                        if(res.data.rows[i].state==0){
                            self.tableData[i].state= '注册'
                        }else if(res.data.rows[i].state==1){
                            self.tableData[i].state= '付费'
                        }else if(res.data.rows[i].state==2) {
                            self.tableData[i].state= '欠费'
                        }else {
                            self.tableData[i].state= '该用户不存在'
                        }
                    }
                }).catch(function () {
                })
            },
            mealFindStatus(){
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
                    var map = new BMap.Map("containers");
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
        mounted(){
            this. mealFindStatus();
            this.loadTenantData();
        }
    });
</script>

</body>

</html>