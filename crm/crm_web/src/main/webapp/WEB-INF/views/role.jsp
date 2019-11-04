<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
    <style>
        .el-aside {
            background-color: #D3DCE6;
            color: #333;
            text-align: center;
            line-height: 400px;
            font-size: 10px;
        }

        .el-main {
            background-color: #E9EEF3;
            color: #333;
            text-align: center;
            line-height: 400px;
            padding: 0px;
            font-size: 10px;
        }
        .dialog-footer{
            margin-top: 10px;
        }

    </style>
</head>
<body>
<div id="app">
    <el-row style="margin-top:10px">
        <el-col :span="21" :offset="2">
                <el-button @click="openlogVisible" type="success" size="mini">添加</el-button>
                <el-input v-model="keyword" placeholder="请输入内容" style="width: 120px;height: 20px;margin-left: 20px"
                          size="mini"></el-input>
                <el-button @click="serchByKeyword(keyword)" type="primary" icon="el-icon-search" size="mini">搜索
                </el-button>
        </el-col>
    </el-row>
            <el-row style="margin-top:10px">
                <el-col :span="22" :offset="1">
                    <el-table
                            :data="roles"
                            style="width: 100%;text-align:center">
                        <el-table-column prop="sn" label="角色编号"></el-table-column>
                        <el-table-column prop="name" label="角色名称"></el-table-column>
                        <el-table-column prop="rpermissions" label="相关权限" width="550" >
                            <template slot-scope="scope">
                        <span v-for="item in scope.row.rpermissions">
                            {{item.name}}
                        </span>
                            </template>
                        </el-table-column>
                        <el-table-column label="操作">
                            <template slot-scope="scope">
                                <el-button
                                        size="mini"
                                        @click="handleEdit(scope.$index, scope.row)" type="primary" icon="el-icon-edit"
                                        circle></el-button>
                                <el-button
                                        size="mini"

                                        @click="handleDelete(scope.$index, scope.row)" type="danger"
                                        icon="el-icon-delete"
                                        circle></el-button>
                            </template>
                        </el-table-column>
                    </el-table>

            <div style="text-align: right;margin-top: 10px;">
                <el-pagination
                        background
                        layout="prev, pager, next"
                        :total="total"
                        :page-size="pageSize"
                        :current-page="pageNum"
                        @current-change="pageSelect">
                </el-pagination>
            </div>

            <!-- 模态框 -->
            <el-dialog :title="title" :visible.sync="addDialogVisible" width="50%">

                <el-form :inline="true" :model="addRole" size="medium">
                    <el-form-item label="角色编号：">
                        <el-input v-model="addRole.sn"></el-input>
                    </el-form-item>
                    <el-form-item label="角色名称：">
                        <el-input v-model="addRole.name"></el-input>
                    </el-form-item>
                </el-form>

                <el-container>

                    <el-aside width="300px" title="已选权限">
                        <el-table :data="selectedPermissions" height="260" border style="width: 100%"
                                  @row-dblclick="removePermission">
                           <%-- <el-table-column type="index" width="50"></el-table-column>--%>
                            <el-table-column prop="id" label="ID" type="selection" width="35"></el-table-column>
                            <el-table-column prop="name" label="权限名称"></el-table-column>
                        </el-table>
                    </el-aside>

                    <el-main width="300px" title="所有权限">
                        <el-table :data="permissions" height="260px" border style="width: 100%"
                                  @row-dblclick="addPermission">
                            <el-table-column prop="id" label="ID" width="35" type="selection"></el-table-column>
                            <el-table-column prop="name" label="权限名称"></el-table-column>
                        </el-table>
                    </el-main>

                </el-container>

                <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleSave">确 定</el-button>
        </span>
            </el-dialog>
        </el-col>
    </el-row>

</div>
<script type="text/javascript">

    var app = new Vue({
        el: "#app",
        data: {
            roles: [],
            total: 100,
            pageSize: 10,
            pageNum: 1,
            addDialogVisible: false,
            keyword: '',
            title: "",
            permissions: [],
            selectedPermissions: [],
            addRole: {
                id: null,
                sn: null,
                name: null,
                rpermissions:{
                    id:'',
                    name:'',
                    url:''
                }
            },
        },
        methods: {

            //双击添加权限
            addPermission(row) {
                this.selectedPermissions.push(row);
                this.permissions.splice(row.index, 1);
            },
            //双击移除权限
            removePermission(row) {
                this.permissions.push(row);
                this.selectedPermissions.splice(row.index, 1);
            },
            //加载权限列表
            loadPermissions() {

                axios.get("/permission/list").then((res) => {
                    this.permissions = res.data;
                });
            },
            openlogVisible() {
                this.title = "新增角色";
                this.addDialogVisible = true;
                //清空表单
                this.addRole = {
                    id: null,
                    sn: null,
                    name: null,
                    rpermissions:null
                }

            },

            handleDelete(index, row) {
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/role/delete", {
                        params: {
                            id: row.id
                        }
                    }).then((res) => {
                        if (res.data.success) {
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.loadRoles();
                        } else {
                            this.$message.error(res.data.message);
                        }
                    })
                });
            },
            serchByKeyword(keyword) {
                var param = {}
                param.pageNum = this.pageNum;
                param.pagesize = this.pagesize;
                param.keyword = this.keyword;
                axios.get("/role/page", {params: param}).then((res) => {
                    this.total = res.data.total;
                    this.roles = res.data.rows;
                })
            },
            handleEdit(index, row) {
                this.title = "编辑角色"
                this.addDialogVisible = true;
                this.addRole.sn = row.sn;
                this.addRole.name = row.name;
                this.addRole.id = row.id;
                this.selectedPermissions = row.rpermissions;
            },

            handleSave() {
                this.addRole.rpermissions = this.selectedPermissions;
                axios.post("/role/save", this.addRole).then((res) => {
                    if (res.data.success) {
                        this.$message({
                            type: 'success',
                            message: '保存成功!'
                        });
                        this.addDialogVisible = false;
                        this.loadRoles();
                    } else {
                        this.$message.error(res.data.message);
                    }
                })
            },

            pageSelect(currentPage) {
                this.pageNum = currentPage;
                this.loadRoles();
            },
            loadRoles() {
                var param = {}
                param.pageNum = this.pageNum;
                param.pagesize = this.pagesize;
                axios.get("/role/page", {params: param}).then((res) => {
                    this.total = res.data.total;
                    this.roles = res.data.rows;
                })

            },
        },
        mounted() {
            this.loadRoles();
            this.loadPermissions();
        }
    })

</script>
</body>
</html>
