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
    <el-container style="height: 848px; border: 1px solid #eee">
        <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
            <el-menu :default-openeds="['1', '2','1-1']">
                <el-submenu index="1">
                    <template slot="title"><i class="el-icon-menu"></i>客户管理</template>
                    <el-submenu index="1-1">
                        <template slot="title">客户列表</template>
                        <el-menu-item index="1-1-1" @click="addTab(editableTabsValue)">待跟进客户</el-menu-item>
                        <el-menu-item index="1-1-2">已跟进客户</el-menu-item>
                        <el-menu-item index="1-1-3">放弃客户</el-menu-item>
                    </el-submenu>
                </el-submenu>
                <el-submenu index="2">
                    <template slot="title"><i class="el-icon-setting"></i>账号管理</template>
                    <el-menu-item index="2-1">修改密码</el-menu-item>
                </el-submenu>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align:left">
                <span style="font-size:36px">客户关系管理系统</span>
            </el-header>
            <el-header style="text-align: right; font-size: 16px">
                <el-dropdown>
                    <i class="el-icon-setting" style="margin-right: 26px">操作</i>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item>注销</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <span>阴俊池</span>
            </el-header>

            <el-main>
                <el-tabs v-model="editableTabsValue" closable @tab-remove="removeTab">
                    <el-tab-pane label="客户管理" name="1">
                        <el-row>
                            <el-col :span="3">
                                <el-input v-model="inputSearch" placeholder="请输入内容" clearable></el-input>
                            </el-col>
                            <el-col :span="2">
                                <el-button type="info" icon="el-icon-search" @click="productSearcher">搜索</el-button>
                            </el-col>
                            <el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>
                            <el-button type="danger" icon="el-icon-delete" @click="deleteProduct">删除</el-button>
                        </el-row>

                        <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                            <el-table-column property="id" label="编号" width="120" sortable>
                            </el-table-column>
                            <el-table-column property="productName" label="商品名称" width="200" sortable>
                            </el-table-column>
                            <el-table-column property="brand" label="品牌" width="150">
                            </el-table-column>
                            <el-table-column property="supplier" label="供应商" width="150">
                            </el-table-column>
                            <el-table-column property="salePrice" label="零售价" width="150">
                            </el-table-column>
                            <el-table-column property="costPrice" label="进价" width="160">
                            </el-table-column>
                            <el-table-column property="cutoff" label="折扣" width="150">
                            </el-table-column>
                            <el-table-column fixed="right" label="操作" width="120">
                                <template slot-scope="scope">
                                    <el-button type="warning" icon="el-icon-edit" size="small" @click="editProduct" round>编辑</el-button>
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
                    </el-tab-pane>

                    <el-tab-pane v-for="(item, index) in editableTabs" :key="item.name" :label="item.title" :name="item.name">
                        {{item.content}}
                    </el-tab-pane>
                </el-tabs>
            </el-main>
        </el-container>
    </el-container>
    <el-dialog title="添加客户" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
        <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="60px" class="demo-ruleForm" label-position="left">
            <el-form-item label="名称" prop="productName">
                <el-input type="text" v-model="ruleForm.productName"></el-input>
            </el-form-item>
            <el-form-item label="品牌" prop="brand">
                <el-input type="text" v-model="ruleForm.brand"></el-input>
            </el-form-item>
            <el-form-item label="供应商" prop="supplier">
                <el-input v-model.number="ruleForm.supplier"></el-input>
            </el-form-item>
            <el-form-item label="零售价" prop="salePrice">
                <el-input v-model.number="ruleForm.salePrice"></el-input>
            </el-form-item>
            <el-form-item label="进价" prop="costPrice">
                <el-input v-model.number="ruleForm.costPrice"></el-input>
            </el-form-item>
            <el-form-item label="折扣" prop="cutoff">
                <el-input v-model.number="ruleForm.cutoff"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>
</div>


<script>
    var checkName = (rule, value, callback) => {
        if(!value) {
            return callback(new Error('商品名称不能为空'));
        }
    };

    var app = new Vue({
        el: '#app',
        data: {
            totalNum:0,
            currentPage: 1,
            pageNum:1,
            pageSize:10,
            ruleForm: {
                productName: ''
            },
            rules: {
                productName: [
                    { validator: checkName, trigger: 'blur' }
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
            editProduct(){
                if(this.currentRow){
                    this.dialogVisible = true;
                    this.ruleForm = this.currentRow;
                }else{
                    this.$message({
                        message: '请选中需要编辑的数据!!!',
                        type: 'warning'
                    });
                }
            },
            deleteProduct(){
                if(this.currentRow){
                    this.$confirm('此操作将永久删除'+this.currentRow.productName+'吗?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        var self = this;
                        axios.get("/product/delete",{params: {id: this.currentRow.id}}).then(function(res){
                            if(res.data.success){
                                self.$message({
                                    type: 'success',
                                    message: '删除成功!'
                                });
                                self.loadProductData();
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
                this.productSearcher();
            },
            handleCurrentChange(val) {
                this.pageNum = val;
                this.productSearcher();
            },
            productSearcher(){
                var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/product/findByPage",params).then(function(res){
                    self.tableData =  res.data.rows;
                    self.totalNum=res.data.total;
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
                this.dialogVisible = true;
            },
            submitForm(formName) {
                // this.$refs[formName].validate((valid) => {
                //     console.debug(valid);
                //     if(valid) {
                //         alert('submit!');
                //
                //     } else {
                //         console.log('error submit!!');
                //         return false;
                //     }
                // });
                var self = this;
                var params = this.ruleForm;
                axios.post("/product/save",params).then(function(res){
                    console.debug(res);
                    if(res.data.success){
                        self.dialogVisible = false;
                        self.loadProductData();
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
            loadProductData() {
                var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/product/findByPage",pageParam).then(function (res) {
                    self.tableData=res.data.rows;
                    self.totalNum=res.data.total;
                }).catch(function () {
                })
            }
        },
        mounted(){
            this.loadProductData();
        }
    });
</script>

</body>

</html>