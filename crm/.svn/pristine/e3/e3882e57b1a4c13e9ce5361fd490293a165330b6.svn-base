<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>保修单</title>
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
                        <el-button type="info" icon="el-icon-search" @click="repairSearcher">搜索</el-button>
                    </el-col>
                    <el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>
                    <el-button type="danger" icon="el-icon-delete" @click="deleteRepair">删除</el-button>
                    <el-button type="warning" icon="el-icon-edit" @click="editRepair">编辑</el-button>
                </el-row>

                <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                    <el-table-column property="id" label="编号" width="120" sortable>
                    </el-table-column>
                    <el-table-column property="sn" label="所属合同" width="220" sortable>
                    </el-table-column>
                    <el-table-column property="warrantysn" label="保修单号" width="220" sortable>
                    </el-table-column>
                    <el-table-column property="customer" label="保修客户" width="120">
                    </el-table-column>
                    <el-table-column property="startTime" label="保修开始时间" width="120">
                    </el-table-column>
                    <el-table-column property="endTime" label="保修到期时间" width="120">
                    </el-table-column>
                    <el-table-column property="status" label="保修状态" width="120">
                        <template slot-scope="scope">
                            <font color="red">{{scope.row.status == 0 ? "过期" : ""}}</font>
                            <font color="green">{{scope.row.status == 1 ? "有效" : ""}}</font>
                        </template>
                    </el-table-column>
                    <el-table-column property="tenant_id" label="所属租户" width="120">
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="120">
                        <template slot-scope="scope">

                            <el-link :underline="false" @click="handleDelete(scope.$index, scope.row)">售后记录<i class="el-icon-view el-icon--right"></i></el-link>
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
    <el-dialog title="编辑保修单" :visible.sync="dialogVisible" width="900px" :before-close="handleClose2">
        <span>
             <el-divider>保修单信息</el-divider>
    <el-form ref="Warrantyform" :model="Warrantyform" label-width="80px">
                <el-row>
                    <el-col :span="8">
                        <el-form-item label="合同单号">
                            <el-input v-model="Warrantyform.sn" :disabled="true" ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="保修单号">
                            <el-input v-model="Warrantyform.warrantysn" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="保修客户">
                            <el-input v-model="Warrantyform.customer" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="16">
                        <el-form-item label="保修日期">
                            <el-date-picker :disabled="true" v-model="Warrantyform.startTime" type="date" placeholder="选择日期"></el-date-picker>
                            <span>-</span>
                            <el-date-picker :disabled="true" v-model="Warrantyform.endTime" type="date" placeholder="选择日期"></el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="所属租户">
                            <el-input v-model="Warrantyform.tenant_id" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <el-divider>维修信息</el-divider>
            <%--维修信息详单的--%>
            <el-form :model="inServForm" ref="inServForm"  label-width="20px" size="small" height="90px">
                <el-form-item  prop="servin" >
                    <el-button type="primary" @click="addRow(infiledList)">新增维修信息</el-button>
                    <template>
                        <el-table border :data="infiledList" style="width: 100%" heigh="90px">
                            <el-table-column prop="fildna" label="所属保修单" style="width:6vw;" >
                                <template scope="scope" >
                                    <el-input size="mini" v-model="scope.row.warrantysn" placeholder="自动关联" :disabled="true" ></el-input>
                                </template>
                            </el-table-column>

                            <el-table-column  prop="fildtp" label="维修时间" width="230px">
                                <template scope="scope" width="30px">
                                    <el-date-picker type="date" clearable :editable="false" v-model="scope.row.repairTime" width="100px"></el-date-picker>
                                </template>
                            </el-table-column>
                            <el-table-column prop="remark" label="维修内容">
                                <template scope="scope">
                                    <el-input size="mini" v-model="scope.row.details" ></el-input>
                                </template>
                            </el-table-column>
                            <el-table-column prop="remark" label="是否解决">
                                <template scope="scope">
                                    <el-switch
                                            style="display: block"
                                            v-model="scope.row.solve"
                                            active-color="#13ce66"
                                            inactive-color="#ff4949"
                                            active-text="是"
                                            inactive-text="否"
                                            active-value="1"
                                            inactive-value="0">
                                    </el-switch>
                                </template>
                            </el-table-column>
                            <el-table-column fixed="right"  label="操作">
                                <template slot-scope="scope">
                                    <el-button @click.native.prevent="deleteRow(scope.$index, infiledList),handleChange()" size="small"> 移除 </el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </template>
                </el-form-item>
            </el-form>
        </span>
        <span slot="footer" class="dialog-footer">
            <el-button @click="handleClose2 = false">重置</el-button>
            <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
        </span>
    </el-dialog>

    <%--维修信息单的弹窗--%>
    <el-dialog title="维修信息" :visible.sync="dialogTableVisible">
        <el-table :data="gridData">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column width="20">
                <template slot-scope="scope">{{ scope.row.date }}</template>
            </el-table-column>
            <el-table-column prop="repairTime" label="服务时间" width="230"></el-table-column>
            <el-table-column prop="details" label="售后内容" width="160"></el-table-column>
            <el-table-column prop="solve" label="是否解决" width="180">
                <template slot-scope="scope">
                    <font color="red">{{scope.row.solve == 0 ? "未解决" : ""}}</font>
                    <font color="green">{{scope.row.solve == 1 ? "已解决" : ""}}</font>
                </template>
            </el-table-column>
        </el-table>
    </el-dialog>
</div>
<script>
var checkName = (rule, value, callback) => {
    if(!value) {
        return callback(new Error('客户不能为空'));
    }
};
var app = new Vue({
    el: '#app',
    data: {
        gridData:[],
        inServForm:{},
        dialogTableVisible:false,
        //详单数据
        infiledList:[],
        //详单数据结束
        dialogVisible : false,
        /*保修单的表单*/
        Warrantyform:{
            sn:'',
        },
        tenants:[],
        totalNum: 0,
        currentPage: 1,
        pageNum: 1,
        pageSize: 10,
        ruleForm: {
            sn: ''
        },
        rules: {
            customer: [
                {validator: checkName, trigger: 'blur'}
            ]
        },
        inputSearch: '',
        editableTabsValue: '1',
        editableTabs: [],
        tabIndex: 1,
        tableData: [],
        currentRow: null
    },
    methods: {
        //客户点击文字链接查看维修历史详细数据
        handleDelete(index, row){
            console.debug(row);
            // this.gridData = [];
            var params ={"warrantysn":row.warrantysn};
            var currentVue = this;
            //查询维修记录
            axios.post('/repairItem/findByPage',params).then(function (response) {
                currentVue.gridData = response.data.rows;
                console.debug(currentVue.gridData );
            }) .catch(function () {
            });
            this.dialogTableVisible = true;
        },
        editRepair() {
            if (this.currentRow) {
                this.dialogVisible = true;
                this.Warrantyform = this.currentRow;
               /* console.debug(this.tbIndex[0])
                this.Warrantyform = this.tbIndex[0];*/
                /*var params ={"warrantysn":this.tbIndex[0].sn};*/
            } else {
                this.$message({
                    message: '请选中需要编辑的数据!!!',
                    type: 'warning'
                });
            }
        },
        deleteRepair(){
            if(this.currentRow){
                this.$confirm('此操作将永久删除'+this.currentRow.customer+'吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    var self = this;
                    axios.get("/repair/delete",{params: {id: this.currentRow.id}}).then(function(res){
                        if(res.data.success){
                            self.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            self.loadRepairData();
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
            this.repairSearcher();
        },
        handleCurrentChange(val) {
            this.pageNum = val;
            this.repairSearcher();
        },
        repairSearcher(){
            var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/repair/findByPage",params).then(function(res){
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
        openDialog(){
            this.ruleForm={};
            this.dialogVisible = true;
        },
        submitForm(formName) {
            for (var i = 0; i < this.infiledList.length; i++) {
                this.infiledList[i].warrantysn = this.Warrantyform.warrantysn;
            };
            var su = this;
            var params = this.Warrantyform;
            axios.post('/repair/save', params).then(function (result) {
                console.debug(result)
                if (result.data.success) {
                    su.dialogVisible = false;
                    su.loadRepairData();
                    su.infiledList=[];
                    this.$message({
                        type: 'success',
                        message: '操作成功！'
                    });
                } else {
                    this.$message({
                        type: 'error',
                        message: result.data.msg
                    });
                }
            }).catch(function (error) {
            })
            //维修详单的表格数据
            var params2 = this.infiledList;
            //维修详单信息保存
            axios.post('/repairItem/saves', params2).then(function (result) {
                if (result.data.success) {
                    su.dialogVisible = false;
                    su.loadRepairData();
                    this.$message({
                        type: 'success',
                        message: '操作成功！'
                    });
                } else {
                    this.$message({
                        type: 'error',
                        message: result.data.msg
                    });
                }
            }).catch(function (error) {
            })
        },
        //保修信息单的增加和减少方法
        deleteRow(index, rows) {//删除改行
            rows.splice(index, 1);
        },
        addRow(tableData,event){
            tableData.push({ fildna: '',fildtp:'',remark:''
            })
        },

        //关闭模态窗
        handleClose2(done) {
            this.$confirm('确认关闭？')
                .then(_ => {
                    done();
                })
                .catch(_ => {});
        },
        loadRepairData() {
            var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/repair/findByPage",pageParam).then(function (res) {
                self.tableData=res.data.rows;
                self.totalNum=res.data.total;
            }).catch(function () {
            })
        }
    },
    mounted(){
        this.loadRepairData();
       /* this.tenantsCombobox();*/
    }
});


</script>
</body>
</html>
