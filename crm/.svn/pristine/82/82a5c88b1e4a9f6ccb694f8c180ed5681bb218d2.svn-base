<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
</head>
<body>
<div id="app">
    <template>
        <el-row>
            <el-col :span="21" :offset="2">
                <el-button size="mini" @click="handleEdit()" round type="primary">添加</el-button>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="22" :offset="1">
                <el-table :span="20" :data="systemDictionaryItems" size="mini" :fit="fit">
                    <el-table-column type="index" label="序号"></el-table-column>
                    <el-table-column prop="sn" label="字典明细编号"></el-table-column>
                    <el-table-column prop="name" label="字典明细名称"></el-table-column>
                    <el-table-column prop="intro" label="字典明细简介"></el-table-column>
                    <el-table-column prop="parent.name" label="字典目录名称">
                    </el-table-column>
                    <el-table-column prop="name" label="操作">
                        <template slot-scope="scope">
                            <el-button size="mini" type="primary" icon="el-icon-edit" @click="handleEdit(scope.$index)"
                                       circle></el-button>
                            <el-button size="mini" type="danger" icon="el-icon-delete" circle
                                       @click="handleDelete(scope.row)"></el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-row>
    </template>
    <template>
        <el-col :span="6" :offset="18">
            <el-pagination
                    size="mini"
                    background
                    layout="prev, pager, next"
                    :total="total"
                    :page-size="pageSize"
                    :current-page="pageNum"
                    @current-change="pageSelect">
            </el-pagination>
        </el-col>
    </template>
    <template>
        <el-dialog
                :title="title"
                :visible.sync="dialogVisible"
                width="35%">
            <el-form size="mini" ref="editSystemDictionaryItem" :rules="rules" :model="systemDictionaryItem" :label-width="width">
                <el-row>
                    <el-form-item label="id：" style="display: none;">
                        <el-input v-model="systemDictionaryItem.id" style="display: none;"></el-input>
                    </el-form-item>
                    <el-form-item label="字典明细名称：" prop="name">
                        <el-input v-model="systemDictionaryItem.name" :style="style"></el-input>
                    </el-form-item>
                    <el-form-item label="字典明细编号：">
                        <el-input v-model="systemDictionaryItem.sn" :style="style"></el-input>
                    </el-form-item>
                    <el-form-item label="字典目录名称：">
                        <template>
                            <el-select v-model="systemDictionaryItem.parent.id" :style="style" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in options"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </template>
                    </el-form-item>
                    <el-form-item label="字典明细简介：" >
                        <el-input v-model="systemDictionaryItem.intro" :style="style"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" size="mini" @click="save('editSystemDictionaryItem')">保存</el-button>
                        <el-button type="primary" size="mini" @click="reset">重置</el-button>
                    </el-form-item>
                </el-row>
            </el-form>
        </el-dialog>
    </template>

</div>

<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data: {
            systemDictionaryItems: [],
            dialogVisible: false,
            title: "添加",
            pageNum: 1,
            pageSize: 10,
            total: 0,
            fit: true,
            width:"0px",
            style:{
                width:"0px"
            },
            systemDictionaryItem: {
                id: null,
                sn: null,
                name: null,
                intro: null,
                parent: {
                    id: null,
                    name: null
                }
            },
            options: [{
                id: null,
                name: null
            }
            ],
            rules: {
                name: [
                    {required: true, message: '请输入字典明细名称', trigger: 'blur'}
                ]
            }
        },
        methods: {
            handleEdit(index) {
                if (index >= 0 && index < this.systemDictionaryItems.length) {
                    this.title = "修改";
                    for (var key in this.systemDictionaryItems[index]) {
                        this.systemDictionaryItem[key] = this.systemDictionaryItems[index][key];
                    }
                } else {
                    this.title = "添加";
                    this.systemDictionaryItem = {
                        id: null,
                        sn: null,
                        name: null,
                        intro: null,
                        parent: {
                            id: null,
                            name: null
                        }
                    }
                }
                this.dialogVisible = true;
            },
            handleDelete(row) {
                var that = this;
                that.$confirm('此操作将永久删除套餐, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/systemDictionaryItem/delete?id=" + row.id).then((result) => {
                        if (result.data.success) {
                            that.$message({
                                type: 'success',
                                message: result.data.message
                            });
                        } else {
                            that.$message({
                                type: 'error',
                                message: result.data.message
                            });
                        }
                        that.loadData();
                    })

                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            save(formName) {
                var that = this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        axios.post('/systemDictionaryItem/save', that.systemDictionaryItem)
                            .then(function (response) {
                                if (response.data.success) {
                                    that.$message({
                                        type: 'success',
                                        message: response.data.message
                                    });
                                } else {
                                    that.$message({
                                        type: 'error',
                                        message: response.data.message
                                    });
                                }
                                that.loadData();
                            })
                        this.dialogVisible = false;
                    } else {
                        return false;
                    }
                });
            },
            copyObj(obj) {
                var newObj = {};
                for (var key in obj) {
                    newObj[key] = obj[key];
                }

                return newObj;
            },
            reset() {
                if (this.systemDictionaryItem.id) {
                    for (var i = 0; i < this.systemDictionaryItems.length; i++) {
                        if (this.systemDictionaryItem.id == this.systemDictionaryItems[i].id) {
                            for (var key in this.systemDictionaryItem) {
                                this.systemDictionaryItem[key] = this.systemDictionaryItems[i][key];
                            }
                            break;
                        }
                    }
                } else {
                    this.systemDictionaryItem = {
                        id: null,
                        sn: null,
                        name: null,
                        intro: null,
                        parent: {
                            id: null,
                            name: null
                        }
                    }
                }
            },
            loadData() {
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/systemDictionaryItem/list", param).then((result) => {
                    this.total = result.data.result.total;
                    this.systemDictionaryItems = result.data.result.rows;
                })
            },
            pageSelect(pageNum) {
                this.pageNum = pageNum;
                this.loadData();
            },
            loadSystemDictionary() {
                axios.post("/systemDictionary/findAll").then((result) => {
                    this.options = result.data.result;
                })
            }
        },
        mounted() {
            this.loadData();
            this.loadSystemDictionary();
            this.width = document.body.clientWidth * 0.10 + "px";
            this.style.width = document.body.clientWidth * 0.20 + "px";
        }
    })

</script>
</body>
</html>
