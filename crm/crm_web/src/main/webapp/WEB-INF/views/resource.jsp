<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>资源管理</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
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
                            :data="resources"
                            style="width: 100%;text-align:center">
                        <el-table-column prop="name" label="资源"></el-table-column>
                        <el-table-column prop="url" label="资源路径"></el-table-column>
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

            <el-dialog
                    title="提示"
                    :visible.sync="addDialogVisible"
                    width="30%">
                <el-form ref="addform" :model="addResource" label-width="80px">

                    <el-form-item label="资源">
                        <el-input v-model="addResource.name"></el-input>
                    </el-form-item>

                    <el-form-item label="资源地址">
                        <el-input v-model="addResource.url"></el-input>
                    </el-form-item>
                </el-form>
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
            resources: [],
            total: 100,
            pageSize: 10,
            pageNum: 1,
            addDialogVisible: false,
            keyword: '',
            addResource: {
                id: null,
                name: null,
                url: null
            }
        },
        methods: {
            openlogVisible() {
                this.addResource = {
                    id: null,
                    name: null,
                    url: null
                }
                this.addDialogVisible = true;
            },
            serchByKeyword(keyword) {
                var param = {}
                param.pageNum = this.pageNum;
                param.pagesize = this.pagesize;
                param.keyword = this.keyword;
                axios.get("/resource/page", {params: param}).then((res) => {
                    this.total = res.data.total;
                    this.resources = res.data.rows;
                })
            },

            handleDelete(index, row) {
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/resource/delete", {
                        params: {
                            id: row.id
                        }
                    }).then((res) => {
                        if (res.data.success) {
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.loadResources();
                        } else {
                            this.$message.error(res.data.message);
                        }
                    })
                });
            },

            handleSave() {

                axios.post("/resource/save", this.addResource).then((res) => {
                    if (res.data.success) {
                        this.$message({
                            type: 'success',
                            message: '保存成功!'
                        });
                        this.addDialogVisible = false;
                        this.loadResources();
                    } else {
                        this.$message.error(res.data.message);
                    }
                })
            },
            handleEdit(index, row) {

                this.addDialogVisible = true;
                this.addResource = row;
                this.addResource.id = row.id;
            },
            pageSelect(currentPage) {
                this.pageNum = currentPage;
                this.loadResources();
            },
            loadResources() {
                var param = {}
                param.pageNum = this.pageNum;
                param.pagesize = this.pagesize;
                axios.get("/resource/page", {params: param}).then((res) => {
                    this.total = res.data.total;
                    this.resources = res.data.rows;
                })

            }

        },
        mounted() {
            this.loadResources();

        }
    })

</script>
</body>
</html>
