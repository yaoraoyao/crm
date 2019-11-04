<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>客户关系管理系统</title>
    <%@include file="common.jsp"%>
    <style>
        .el-header {
            background-color: #B3C0D1;
            color: #333;
            line-height: 60px;
        }

        .el-aside {
            color: #333;
        }

        .el-select .el-input {
            width: 130px;
        }

        .input-with-select .el-input-group__prepend {
            background-color: #fff;
        }
    </style>
</head>
<body>
<div id="app">
    <template>
        <el-row>
            <el-col :span="22" :offset="2">
                <el-button size="mini"  type="primary"  round @click="handleAdd">添加</el-button>
                用户名:<el-input v-model="username" style="width: 100px" placeholder="请输入用户名"></el-input>
                时间范围查找 <el-date-picker  v-model="beginTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                                        value-format="yyyy-MM-dd"></el-date-picker>
                -<el-date-picker  v-model="endTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd "
                                  value-format="yyyy-MM-dd"></el-date-picker>
                <el-button size="mini" @click="search" round type="primary">搜索</el-button>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="22" :offset="1">
                <el-table  id="table" :data="employees" :fit="fit">
                    <el-table-column type="index" label="序号" width="50px"></el-table-column>
                    <el-table-column prop="username" label="用户名" width="80px"></el-table-column>
                    <el-table-column prop="realname" label="昵称" width="80px"></el-table-column>
                    <el-table-column prop="password" label="密码" width="100px"></el-table-column>
                    <el-table-column prop="tel" label="电话" width="100px"></el-table-column>
                    <el-table-column prop="email" label="邮箱" width="100px"></el-table-column>
                    <el-table-column prop="department.name" label="部门" width="100px"></el-table-column>
                    <el-table-column prop="inputTime" label="录入时间" align="center">
                    </el-table-column>
                    <el-table-column prop="tenant.companyName" label="租户" width="130px">
                    </el-table-column>
                    <el-table-column prop="state" label="状态" color="red" width="50px">
                        <template slot-scope="scope">
                            <span v-if="scope.row.state==1" style="color: green">正常</span>
                            <span v-if="scope.row.state==0" style="color: red">离职</span>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作" >
                        <template slot-scope="scope">
                            <el-button size="mini" type="primary" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)"></el-button>
                            <el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.$index, scope.row)"></el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-row>
    </template >
    <div style="text-align: center;margin-top: 10px;">
        <div class="block">
            <span class="demonstration"></span>
            <el-pagination
                    layout="prev, pager, next"
                    :total="total">
            </el-pagination>
        </div>
    </div>
    <el-dialog title="添加" :visible.sync="addDialogVisible" width="40%">

        <el-form :model="addFormData" label-width="80px">
            <el-form-item label="用户名:"
                          :rules="[
                { required: true, message: '用户名不能为空',trigger: 'blur'},
                { min: 3, max: 10, message: '长度在 3 到 10 个字符' },
                { validator: checkData, trigger: 'blur'}
                ]" >
                <el-input v-model="addFormData.username"></el-input>
            </el-form-item>
            <el-form-item label="昵称:" >
                <el-input v-model="addFormData.realname"></el-input>
            </el-form-item>
            <el-form-item label="密码:">
                <el-input type="password" v-model="addFormData.password"></el-input>
            </el-form-item>
            <el-form-item label="电话:">
                <el-input  v-model="addFormData.tel"></el-input>
            </el-form-item>
            <el-form-item label="邮箱:">
            <el-input v-model="addFormData.email"></el-input>
        </el-form-item>
            <el-form-item label="部门:">

                <el-select v-model="addFormData.department" >
                    <el-option
                            v-for="item in department"
                            :key="item.id"
                            :label="item.name"
                            :value="item">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="录入时间:">
                <el-date-picker type="date"
                                placeholder="选择时间"
                                v-model="addFormData.inputTime"
                                value-format="yyyy-MM-dd"
                                style="width: 100%;">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="状态:">
                <el-select v-model="addFormData.state" >
                    <el-option
                            v-for="item in options"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="租户:">
                <el-select v-model="addFormData.tenant_id" >
                    <el-option
                        v-for="item in tenant"
                        :label="item.companyName"
                        :value="item.id">
                    </el-option>
                </el-select>
            </el-form-item>
        </el-form>
        <el-footer align="right">
            <el-button type="primary" @click="handleCancel">取消</el-button>
            <el-button type="primary" @click="handleSave">保存</el-button>
        </el-footer>
    </el-dialog>
</div>

<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data: {
            department:[
            //     {
            //     id:null,
            //     name:null
            // }
            ],
            employees: [],
            tenant:[],
            addDialogVisible: false,
            title: "添加",
            pageNum: 1,
            pageSize: 10,
            total:0,
            fit:true,
            options:[{
                value: 1,
                label: '正常'
            },{
                value: 0,
                label: '离职'
            }],
            // options1:[{
            //     id:null,
            //     name:null
            // }],
            value: '',
            /*查询数据*/
            username:null,
            beginTime:null,
            endTime:null,
            addFormData: {
                id:null,
                username: null,
                realname:null,
                password: null,
                tel: null,
                email:null,
                inputTime:null,
                state:null,
                tenant_id:null,
                department:{
                    // id:null,
                    // name:null
                }

            },
            rules: {
                // username:[{ required: true, message: '请输入用户名', trigger: 'blur' },
                //     { min: 2, max: 5, message: '长度在 2 到 5 个字符' },
                //     { pattern: /^[\u4E00-\u9FA5]+$/, message: '用户名只能为中文' }], //{ pattern:/^[a-zA-Z]w{1,4}$/, message: '以字母开头，长度在2-5之间， 只能包含字符、数字和下划线'} ]
                inputTime: [
                    { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
                ]
            }
        },
        methods:{
            checkData (rule, value, callback) {
                if (value) {
                    if (/[\u4E00-\u9FA5]/g.test(value)) {
                        callback(new Error('用户名不能输入汉字!'));
                    } else {
                        callback();
                    }
                }
                callback();
            },
            /**
             *格式化时间的方法
             * */
            handleAdd(){
                //清空表单
                this.addFormData={
                    id:null,
                    username: null,
                    realname:null,
                    password: null,
                    tel: null,
                    email:null,
                    department:null,
                    inputTime:null,
                    state:null,
                    tenant_id:null
                }
                this.addDialogVisible = true
            },
            //保存
            handleSave(){
                axios.post("/employee/save",this.addFormData).then((res)=>{
                    if(res.data.success){
                        //成功
                        this.$message({
                            message: res.data.message,
                            type: 'success'
                        });
                        //关闭dialog
                        this.addDialogVisible = false;
                        //重新加载当前页的员工数据
                        this.loadEmployees();
                    }else{
                        this.$message.error(res.data.message);
                    }
                })
            },
            handleCancel(){
                this.addDialogVisible = false;
            },
            //修改
            handleEdit(index,row){
                this.addDialogVisible = true;
                this.addFormData={
                    id:row.id,
                    username: row.username,
                    realname:row.realname,
                    password: row.password,
                    tel: row.tel,
                    email:row.email,
                    inputTime:row.inputTime,
                    state:row.state,
                    tenant_id:row.tenant_id,
                    department:row.department
                }
            },
            //删除
            handleDelete(index,row){
                //提示是否删除
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    //执行删除操作
                    //axios.get("/delete?id="+row.id).then((res)=>{})
                    axios.get("/employee/delete",{
                        params:{
                            id:row.id
                        }
                    }).then((res)=>{
                        //处理响应 res.data==AjaxResult(success message)
                        if(res.data.success){
                            //成功
                            this.$message({
                                message: '删除成功!',
                                type: 'success'
                            });
                            //重新加载当前页的员工数据
                            this.loadEmployees();
                        }else{
                            this.$message.error(res.data.message);
                        }
                    })
                })
            },
            //加载员工信息
            loadEmployees(){
                //创建一个参数对象
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                param.username=this.username;
                param.beginTime=this.beginTime
                param.endTime=this.endTime
                axios.post("/employee/findByPage",{
                    params:param
                }).then((res)=>{
                    //PageList(total rows)就是res.data
                    console.debug(res)
                    this.total = res.data.total
                    this.employees = res.data.rows
                })
            },
            loadTenant(){
                //创建一个参数对象
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/tenant/findByPage",{
                    params:param
                }).then((res)=>{
                    //PageList(total rows)就是res.data
                    this.total = res.data.total
                    this.tenant = res.data.rows
                })
            },
            loaddepartment(){
                //创建一个参数对象
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/department/findByPage",{
                    params:param
                }).then((res)=>{
                    //PageList(total rows)就是res.data
                    this.total = res.data.total
                    this.department = res.data.rows
                })
            },

            /*搜索方法*/
            search(){
                this.loadEmployees();
            }
        },
        //$(function(){})
        mounted(){
            this.loadEmployees();
            this.loadTenant();
            this.loaddepartment();
        }
    })
</script>
</body>

</html>