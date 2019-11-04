<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>部门管理</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
    <style type="text/css">
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
                <el-button size="mini"  type="primary"   round @click="handleAdd">添加</el-button>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="22" :offset="1">
                <el-table  id="table" :data="departments" :fit="fit">
                    <el-table-column type="index" label=""></el-table-column>
                    <el-table-column prop="sn" label="部门编号"></el-table-column>
                    <el-table-column prop="name" label="部门名称"></el-table-column>
                    <el-table-column prop="employee.realname" label="部门经理"></el-table-column>
                    <el-table-column prop="parent.name" label="上级部门"></el-table-column>
                    <el-table-column prop="state" label="部门状态" align="center">
                        <template slot-scope="scope">
                            <span v-if="scope.row.state==1" style="color: green">正常</span>
                            <span v-if="scope.row.state==0" style="color: red">停用</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="tenant.companyName" label="租户">
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button  size="mini" type="primary" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)"></el-button>
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
            <el-form-item label="部门编号:">
                <el-input v-model="addFormData.sn"></el-input>
            </el-form-item>
            <el-form-item label="部门名称:">
                <el-input v-model="addFormData.name"></el-input>
            </el-form-item>
            <el-form-item label="部门经理:">
                <el-select v-model="addFormData.manager_id" >
                    <el-option
                            v-for="item in employees"
                            :label="item.realname"
                            :value="item.id">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="上级部门:">
                <el-select v-model="addFormData.parent_id" >
                    <el-option
                            v-for="item in parents"
                            :label="item.name"
                            :value="item.id">
                    </el-option>
                </el-select>
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
                            v-for="item in tenants"
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
            fit:true,
            departments: [],
            tenants:[],
            employees:[],
            parents:[],
            addDialogVisible: false,
            title: "添加",
            pageNum: 1,
            pageSize: 10,
            total:0,
            options:[{
                value: 1,
                label: '正常'
            },{
                value: 0,
                label: '停用'
            }],
            value: '',
            addFormData: {
                id:null,
                sn: null,
                name:null,
                manager_id: null,
                parent_id:null,
                state:null,
                tenant_id:null

            },
            rules: {
                username: [
                    {required: true, message: '请输入姓名', trigger: 'blur'}
                ],
                date1: [
                    { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
                ]
            }
        },
        methods:{
            /**
             *格式化时间的方法
             * */
            // dateFormat(row, column){
            //     var t = new Date(row.inputTime)
            //         return t.getFullYear()+"-"+(t.getMonth()+1)+"-"+t.getDate();
            //     },
            //点击添加
            handleAdd(){
                //清空表单
                this.addFormData={
                    id:null,
                    sn: null,
                    name:null,
                    manager_id: null,
                    parent_id: null,
                    state:null,
                    tenant_id:null
                }
                this.addDialogVisible = true
            },
            //保存
            handleSave(){
                axios.post("/department/save",this.addFormData).then((res)=>{
                    if(res.data.success){
                        //成功
                        this.$message({
                            message: res.data.message,
                            type: 'success'
                        });
                        //关闭dialog
                        this.addDialogVisible = false;
                        //重新加载当前页的员工数据
                        this.loaddepartments();
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
                    sn: row.sn,
                    name:row.name,
                    manager_id: row.manager_id,
                    parent_id: row.parent_id,
                    state:row.state,
                    tenant_id:row.tenant_id
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
                    axios.get("/department/delete",{
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
                            this.loaddepartments();
                        }else{
                            this.$message.error(res.data.message);
                        }
                    })
                })
            },
            pageSelect(currentPage){
                this.pageNum = currentPage;
                //分页查询员工信息
                this.loaddepartments();
            },
            //加载员工信息
            loaddepartments(){
                //创建一个参数对象
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.get("/department/findByPage",{
                    params:param
                }).then((res)=>{
                    //PageList(total rows)就是res.data
                    this.total = res.data.total
                    this.departments = res.data.rows
                    this.parents = res.data.rows
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
                    this.tenants = res.data.rows
                })
            },
            loadEmployees(){
                var param={}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/employee/findByPage",{
                    params:param
                }).then((res)=>{
                    this.tptal = res.data.total
                    this.employees = res.data.rows
                })

            }
        },

        mounted(){
            //发送请求查询所有的员工信息,回调选择使用箭头函数，箭头函数中没有this
            // axios.get("/employee/list").then((res)=>{
            //     //响应的数据在res的data属性中
            //     this.employees = res.data;
            // })
            this.loaddepartments();
            this.loadTenant();
            this.loadEmployees();
        }
    })
</script>
</body>
</html>