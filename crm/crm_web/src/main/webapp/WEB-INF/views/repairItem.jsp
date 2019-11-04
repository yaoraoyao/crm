<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
                        <el-button type="info" icon="el-icon-search" @click="repairItemSearcher">搜索</el-button>
                    </el-col>
                    <%--<el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>--%>
                </el-row>
                <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                    <el-table-column property="id" label="编号" width="100" sortable>
                    </el-table-column>
                    <el-table-column prop="warrantysn" label="归属保修单" width="230"></el-table-column>
                    <el-table-column prop="repairTime" label="保修时间" width="230"></el-table-column>
                    <el-table-column prop="details" label="保修内容" width="160"></el-table-column>
                    <el-table-column prop="solve" label="是否解决" width="180">
                        <template slot-scope="scope">
                            <font color="red">{{scope.row.solve == 0 ? "未解决" : ""}}</font>
                            <font color="green">{{scope.row.solve == 1 ? "已解决" : ""}}</font>
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="120">
                        <template slot-scope="scope">
                            <%--<el-button type="warning" icon="el-icon-edit" size="small" @click="editRepairItem" round>编辑</el-button>--%>
                            <el-button type="danger" icon="el-icon-delete" @click="deleteRepairItem">删除</el-button>
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
            <el-form-item label="订单客户" prop="customer">
                <el-input type="text" v-model="ruleForm.customer"></el-input>
            </el-form-item>
            <el-form-item label="签订时间" prop="repairTime">
                <el-date-picker v-model.number="ruleForm.repairTime" type="date" placeholder="选择日期">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="保修内容" prop="details">
                <el-input type="text" v-model="ruleForm.details"></el-input>
            </el-form-item>
            <el-form-item label="是否解决" prop="solve">
                <el-input v-model.number="ruleForm.solve"></el-input>
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
        return callback(new Error('时间不能为空'));
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
            repairTime: [
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
        // editRepairItem() {
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
        deleteRepairItem(){
            if(this.currentRow){
                this.$confirm('此操作将永久删除'+this.currentRow.warrantysn+'吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    var self = this;
                    axios.get("/repairItem/delete",{params: {id: this.currentRow.id}}).then(function(res){
                        if(res.data.success){
                            self.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            self.loadRepairItemData();
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
            this.repairItemSearcher();
        },
        handleCurrentChange(val) {
            this.pageNum = val;
            this.repairItemSearcher();
        },
        repairItemSearcher(){
            var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/repairItem/findByPage",params).then(function(res){
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
            axios.post("/repairItem/save",params).then(function(res){
                console.debug(res);
                if(res.data.success){
                    self.dialogVisible = false;
                    self.loadRepairItemData();
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
        loadRepairItemData() {
            var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/repairItem/findByPage",pageParam).then(function (res) {
                self.tableData=res.data.rows;
                self.totalNum=res.data.total;
            }).catch(function () {
            })
        }
    },
    mounted(){
        this.loadRepairItemData();
    }
});


</script>
</body>
</html>
