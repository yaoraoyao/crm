<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>合同付款明细</title>
    <%@include file="common.jsp"%>
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
                        <el-button type="info" icon="el-icon-search" @click="contractItemSearcher">搜索</el-button>
                    </el-col>
                    <%--<el-button type="primary" icon="el-icon-circle-plus" @click="openDialog" >添加</el-button>--%>

                </el-row>

                <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                    <el-table-column property="id" label="编号" width="100" sortable>
                    </el-table-column>
                    <el-table-column property="itemsn" label="所属合同" width="220" sortable>
                    </el-table-column>
                    <el-table-column property="payTime" label="付款时间" width="120">
                    </el-table-column>
                    <el-table-column property="money" label="付款金额" width="120">
                        <template slot-scope="scope">
                            <font color="red">￥:{{scope.row.money}}</font>
                        </template>
                    </el-table-column>
                    <el-table-column property="scale" label="所占比例" width="120">
                        <template slot-scope="scope">
                            <font color="orange">{{scope.row.scale}}%</font>
                        </template>
                    </el-table-column>
                    <el-table-column property="isPayment" label="是否付款" width="120">
                        <template slot-scope="scope">
                            <font color="green">{{scope.row.isPayment == 1 ? "已付款" : ""}}</font>
                            <font color="#808080">{{scope.row.isPayment == 0 ? "未付款" : ""}}</font>
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="120">
                        <template slot-scope="scope">
                            <%--<el-button type="warning" icon="el-icon-edit" size="small" @click="editContractItem" round>编辑</el-button>--%>
                            <el-button type="danger" icon="el-icon-delete" @click="deleteContractItem">删除</el-button>
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
    <el-dialog title="新增/编辑订单" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
        <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="70px" class="demo-ruleForm" label-position="left">
            <el-form-item label="所属合同" prop="itemsn">
                <el-input type="text" v-model="ruleForm.itemsn"></el-input>
            </el-form-item>
            <el-form-item label="付款时间" prop="payTime">
                <el-date-picker v-model.number="ruleForm.payTime" type="date" placeholder="选择日期">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="付款金额" prop="money">
                <el-input v-model.number="ruleForm.money"></el-input>
            </el-form-item>
            <el-form-item label="所占比例" prop="scale">
                <el-input v-model.number="ruleForm.scale"></el-input>
            </el-form-item>
            <el-form-item label="是否付款" prop="isPayment">
                <el-input v-model.number="ruleForm.isPayment"></el-input>
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
        return callback(new Error('付款时间不能为空'));
    }
};
var app = new Vue({
    el: '#app',
    data: {
        totalNum: 0,
        currentPage: 1,
        pageNum: 1,
        pageSize: 10,
        ruleForm: {
            sn: ''
        },
        rules: {
            payTime: [
                {validator: checkName, trigger: 'blur'}
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
        // editContractItem() {
        //     if (this.currentRow) {
        //         this.dialogVisible = true;
        //         this.ruleForm = this.currentRow;
        //     } else {
        //         this.$message({
        //             message: '请选中需要编辑的数据!!!',
        //             type: 'warning'
        //         });
        //     }
        // },
        deleteContractItem(){
            if(this.currentRow){
                this.$confirm('此操作将永久删除'+this.currentRow.itemsn+'吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    var self = this;
                    axios.get("/contractItem/delete",{params: {id: this.currentRow.id}}).then(function(res){
                        if(res.data.success){
                            self.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            self.loadContractItemData();
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
            this.contractItemSearcher();
        },
        handleCurrentChange(val) {
            this.pageNum = val;
            this.contractItemSearcher();
        },
        contractItemSearcher(){
            var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/contractItem/findByPage",params).then(function(res){
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
        // openDialog(){
        //     this.ruleForm={};
        //     this.dialogVisible = true;
        // },
        submitForm(formName) {
            var self = this;
            var params = this.ruleForm;
            axios.post("/contractItem/save",params).then(function(res){
                if(res.data.success){
                    self.dialogVisible = false;
                    self.loadContractItemData();
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
        loadContractItemData() {
            var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/contractItem/findByPage",pageParam).then(function (res) {
                console.debug(22222222222);
                console.debug(res);
                self.tableData=res.data.rows;
                self.totalNum=res.data.total;
            }).catch(function () {
            })
        }
    },
    mounted(){
        this.loadContractItemData();
    }
});


</script>
</body>
</html>
