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
            <el-col :span="22" :offset="2">
                <el-button size="mini" @click="handleEdit()" round type="primary">添加</el-button>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="23" :offset="1">
                <el-table :data="systemDictionaries" size="mini" :fit="fit" >
                    <el-table-column type="index" label="序号" ></el-table-column>
                    <el-table-column prop="sn" label="字典目录编号" ></el-table-column>
                    <el-table-column prop="name" label="字典目录名称" ></el-table-column>
                    <el-table-column prop="intro" label="字典目录简介" ></el-table-column>
                    <el-table-column prop="state" label="状态">
                        <template slot-scope="scope">
                            <span v-if="scope.row.state == 1" style="color: green">可用</span>
                            <span v-else style="color: red">停用</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="name" label="操作" >
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
                    background
                    size="mini"
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
				  <span>
				  	<el-form ref="editSystemDictionary" :rules="rules" :model="systemDictionary" size="mini" :label-width="width">
			  		  <el-form-item label="id：" style="display: none;">
					    <el-input v-model="systemDictionary.id" style="display: none;"></el-input>
					  </el-form-item>
					  <el-form-item label="字典目录名称：" prop="name">
					    <el-input v-model="systemDictionary.name" :style="style"></el-input>
					  </el-form-item>
					  <el-form-item label="字典目录编号：">
					    <el-input v-model="systemDictionary.sn" :style="style"></el-input>
					  </el-form-item>
                      <el-form-item label="状态：">
                          <template>
                              <el-select v-model="systemDictionary.state" :style="style" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in options"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                              </el-select>
                            </template>
					  </el-form-item>
                        <el-form-item label="字典目录简介：">
					    <el-input v-model="systemDictionary.intro" :style="style"></el-input>
					  </el-form-item>
                        <el-form-item>
					    <el-button type="primary" size="mini" @click="save('editSystemDictionary')">保存</el-button>
					    <el-button type="primary" size="mini" @click="reset">重置</el-button>
					  </el-form-item>
					</el-form>
				  </span>
        </el-dialog>
    </template>

</div>

<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data: {
            systemDictionaries: [],
            dialogVisible: false,
            title: "添加",
            pageNum: 1,
            pageSize: 10,
            total: 0,
            fit:true,
            width:"0px",
            style:{
                width:"0px"
            },
            systemDictionary: {
                id: null,
                sn: null,
                name: null,
                intro: null,
                state: null
            },
            options:[
                {value: 1, label: "可用"},
                {value: 0, label: "停用"}
            ],
            rules: {
                name: [
                    {required: true, message: '请输入字典目录名称', trigger: 'blur'}
                ]
            }
        },
        methods: {
            handleEdit(index) {
                if (index >= 0 && index < this.systemDictionaries.length) {
                    this.title = "修改";
                    for (var key in this.systemDictionaries[index]) {
                        this.systemDictionary[key] = this.systemDictionaries[index][key];
                    }
                } else {
                    this.title = "添加";
                    this.systemDictionary = {
                        id: null,
                        sn: null,
                        name: null,
                        intro: null,
                        state: null
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
                    axios.get("/systemDictionary/delete?id=" + row.id).then((result) => {
                        if (result.data.success) {
                            that.$message({
                                type: 'success',
                                message: result.data.msg
                            });
                        } else {
                            that.$message({
                                type: 'error',
                                message: result.data.msg
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
                        axios.post('/systemDictionary/save', that.systemDictionary)
                            .then(function (response) {
                                if (response.data.success) {
                                    that.$message({
                                        type: 'success',
                                        message: response.data.msg
                                    });
                                } else {
                                    that.$message({
                                        type: 'error',
                                        message: response.data.msg
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
                if (this.systemDictionary.id) {
                    for (var i = 0; i < this.systemDictionaries.length; i++) {
                        if (this.systemDictionary.id == this.systemDictionaries[i].id) {
                            for (var key in this.systemDictionary) {
                                this.systemDictionary[key] = this.systemDictionaries[i][key];
                            }
                            break;
                        }
                    }
                } else {
                    this.systemDictionary = {
                        id: null,
                        sn: null,
                        name: null,
                        intro: null,
                        state: null
                    }
                }
            },
            loadData() {
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/systemDictionary/list", param).then((result) => {
                    console.debug(result)
                    this.total = result.data.result.total;
                    this.systemDictionaries = result.data.result.rows;
                })
            },
            pageSelect(pageNum) {
                this.pageNum = pageNum;
                this.loadData();
            }
        },
        mounted() {
            this.loadData();
            this.width = document.body.clientWidth * 0.10 + "px";
            this.style.width = document.body.clientWidth * 0.20 + "px";
        }
    })

</script>
</body>
</html>
