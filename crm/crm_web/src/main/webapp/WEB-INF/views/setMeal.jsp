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
        <el-container>
            <el-main>
                <el-row>
                    <el-col :span="3">
                        <el-input v-model="inputSearch" placeholder="请输入内容" clearable></el-input>
                    </el-col>
                    <el-col :span="2">
                        <el-button type="info" icon="el-icon-search" @click="setMealSearcher">搜索</el-button>
                    </el-col>
                    <el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>
                    <el-button type="danger" icon="el-icon-delete" @click="deleteSetMeal">删除</el-button>
                </el-row>
                <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                    <el-table-column property="id" label="编号" width="120" sortable>

                    </el-table-column>
                    <el-table-column property="mealName" label="套餐" width="200" sortable>

                    </el-table-column>
                    <el-table-column property="mealPrice" label="价格" width="200">

                    </el-table-column>
                    <el-table-column property="expireDate" label="有效期" width="200">

                    </el-table-column>
                    <el-table-column property="status" label="状态" width="150">

                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="200">
                        <template slot-scope="scope">
                            <el-button type="warning" icon="el-icon-edit" size="small" @click="editSetMeal" round>编辑</el-button>
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
    <el-dialog title="添加/编辑客户" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
        <%--表单开始--%>
        <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="60px" class="demo-ruleForm" label-position="left">
            <el-form-item label="套餐" prop="mealName">
                <el-input type="text" v-model="ruleForm.mealName"></el-input>
            </el-form-item>

            <el-form-item label="价格" prop="mealPrice">
                <%--<el-input type="text"v-model.number="ruleForm.mealPrice"></el-input>--%>
                <el-input
                        type="text"
                        placeholder="请输入1/10"
                        v-model="text"
                        v-model.number="ruleForm.mealPrice"
                        maxlength="10"
                        show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="有效期" prop="expireDate">
                <el-select  v-model.number="ruleForm.expireDate" placeholder="请选择">
                    <el-option
                            v-for="item in youxiaoqi"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-select  v-model.number="ruleForm.status" placeholder="请选择">
                    <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>

            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
        <%--表单结束--%>
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
        myDate: new Date(),
        data: {
            options: [
                {
                    value: -1,
                    label: '--请选择--'
                },{
                    value: 1,
                    label: '正常'
                }, {
                    value: 0,
                    label: '停用'
                }],
            youxiaoqi: [
                {
                    value: new Date().setDate(30),
                    label: '30天'
                },{
                    value: new Date().setDate(365),
                    label: '一年'
                }, {
                    value: new Date().setDate(1825),
                    label: '五年'
                },{
                    value: new Date().setDate(3650),
                    label: '十年'
                },{
                    value: new Date().setDate(7300),
                    label: '二十年'
                }
            ],
            text: '',
            textarea: '',
            totalNum:0,
            currentPage: 1,
            pageNum:1,
            pageSize:10,
            ruleForm: {
                SetMealName: ''
            },
            rules: {
                SetMealName: [
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
            editSetMeal(){
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
            deleteSetMeal(){
                if(this.currentRow){
                    this.$confirm('此操作将永久删除'+this.currentRow.SetMealName+'吗?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        var self = this;
                        axios.get("/setMeal/delete",{params: {id: this.currentRow.id}}).then(function(res){
                            if(res.data.success){
                                self.$message({
                                    type: 'success',
                                    message: '删除成功!'
                                });
                                self.loadSetMealData();
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
                this.setMealSearcher();
            },
            handleCurrentChange(val) {
                this.pageNum = val;
                this.setMealSearcher();
            },
            setMealSearcher(){
                var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/setMeal/findByPage",params).then(function(res){
                    self.tableData =  res.data.rows;
                    self.totalNum=res.data.total;
                    for(var i =0; i <res.data.rows.length; i++){
                        if(res.data.rows[i].status==1){
                            self.tableData[i].status= '正常'
                        }else {
                            self.tableData[i].status= '停用'
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
                this.dialogVisible = true;
            },
            submitForm(formName) {
                var self = this;
                var params = this.ruleForm;
                axios.post("/setMeal/save",params).then(function(res){
                    console.debug(res);
                    if(res.data.success){
                        self.dialogVisible = false;
                        self.loadSetMealData();
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
            loadSetMealData() {
                var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
                var self = this;
                axios.post("/setMeal/findByPage",pageParam).then(function (res) {
                    self.tableData=res.data.rows;
                    self.totalNum=res.data.total;
                    console.debug(res.data.rows);
                    for(var i =0; i <res.data.rows.length; i++){
                        if(res.data.rows[i].status==1){
                            self.tableData[i].status= '正常'
                        }else {
                            self.tableData[i].status= '停用'
                        }
                    }
                }).catch(function () {
                })
            }
        },
        mounted(){
            this.loadSetMealData();
        }
    });
</script>

</body>

</html>