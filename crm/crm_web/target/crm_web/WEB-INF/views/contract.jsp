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
                        <el-button type="info" icon="el-icon-search" @click="contractSearcher">搜索</el-button>
                    </el-col>
                    <el-button type="primary" icon="el-icon-circle-plus" @click="openDialog">添加</el-button>
                    <el-button type="danger" icon="el-icon-delete" @click="deleteContract">删除</el-button>
                    <el-button type="warning" icon="el-icon-edit" @click="editContract">编辑</el-button>
                </el-row>
                <el-table ref="singleTable" :data="tableData" highlight-current-row @current-change="clickRow" :default-sort="{prop: 'id', order: 'descending'}" style="width: 100%">
                    <el-table-column property="id" label="编号" width="100" sortable>
                    </el-table-column>
                    <el-table-column property="sn" label="合同单号" width="220" sortable>
                    </el-table-column>
                    <el-table-column property="customer" label="合同客户" width="120">
                    </el-table-column>
                    <el-table-column property="signTime" label="签订时间" width="120">
                    </el-table-column>
                    <el-table-column property="seller" label="营销人员" width="120">
                    </el-table-column>
                    <el-table-column property="earnestsum" label="合同金额" width="120">
                        <template slot-scope="scope">
                            <font color="red">￥:{{scope.row.earnestsum}}</font>
                        </template>
                    </el-table-column>
                    <el-table-column property="intro" label="合同摘要" width="120">
                    </el-table-column>
                    <el-table-column property="details" label="付款详情" width="120">
                    </el-table-column>
                    <el-table-column property="tenant_id" label="所属租户" width="120">
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="120">
                        <template slot-scope="scope">
                            <el-link :underline="false" @click="handleDelete(scope.$index, scope.row)">付款信息<i class="el-icon-view el-icon--right"></i></el-link>
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
    <el-dialog title="新增/编辑合同" :visible.sync="dialogVisible" width="900px" :before-close="handleClose">
        <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="70px" class="demo-ruleForm" label-position="left">
            <el-divider>合同信息</el-divider>
            <el-row>
                <el-col :span="7">
                    <el-form-item  prop="sn">
                        <el-input v-model="ruleForm.sn" placeholder="合同" type="hidden"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12">
                    <el-form-item label="合同客户" prop="customer" style="width: 250px;">
                        <el-input type="text"  @blur="customerChang()" v-model="ruleForm.customer"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="2">
                    <el-form-item label="签订时间" prop="signTime">
                        <el-date-picker :editable="false" v-model.number="ruleForm.signTime" @change="signTimechange()" type="date" placeholder="选择日期">
                        </el-date-picker>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="营销人员" prop="seller" style="width: 250px;">
                        <el-input v-model.number="ruleForm.seller"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="2">
                    <el-form-item label="合同金额" prop="earnestsum" style="width: 290px;">
                        <el-input v-model.number="ruleForm.earnestsum"></el-input>
                    </el-form-item>
                </el-col>
                <el-col>
                    <el-form-item label="合同摘要" prop="intro" style="width: 620px;">
                        <el-input
                                type="textarea"
                                :rows="2"
                                placeholder="请输入内容"
                                v-model="ruleForm.intro"
                                maxlength="20" show-word-limit>
                        </el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="付款详情" prop="details" style="width: 250px;">
                        <el-input v-model.number="ruleForm.details"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="2">
                    <el-form-item label="所属租户" prop="tenant_id" style="width: 250px;">
                        <el-input @blur="tenantChang()" v-model="ruleForm.tenant_id" ></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <%-- 合同付款明细--%>
            <el-divider>付款详情</el-divider>
            <%--详单的--%>
            <el-form :model="inServForm" ref="inServForm"  label-width="20px" size="small">
                <el-form-item  prop="servin" >
                    <el-button type="primary" @click="addRow(infiledList)">新增付款明细</el-button>
                    <template>
                        <el-table border :data="infiledList" style="width: 100%" >
                            <el-table-column prop="fildna" label="所属合同" style="width:150px;" >
                                <template scope="scope" >
                                    <el-input size="mini" v-model="scope.row.itemsn" placeholder="自动关联,不可更改" :disabled="true"></el-input>
                                </template>
                            </el-table-column>
                            <el-table-column  prop="fildtp" label="合同金额" width="0px">
                                <template scope="scope">
                                    <el-input size="mini" placeholder="0" v-model="scope.row.earnestsum" type="hidden" ></el-input>
                                    {{ruleForm.earnestsum}}
                                </template>
                            </el-table-column>
                            <el-table-column  prop="fildtp" label="付款时间" width="150px">
                                <template scope="scope" width="30px">
                                    <el-date-picker type="date" placeholder="请选择" clearable :editable="false" v-model="scope.row.payTime" style="width: 140px;"></el-date-picker>
                                </template>
                            </el-table-column>
                            <el-table-column prop="remark" label="付款金额">
                                <template scope="scope">
                                    <el-input size="mini" v-model="scope.row.money" ></el-input>
                                </template>
                            </el-table-column>
                            <el-table-column prop="remark" label="所占比例">
                                <template scope="scope">
                                    {{scope.row.money/ruleForm.earnestsum | number}}
                                </template>
                            </el-table-column>
                            <el-table-column prop="remark" label="是否付款" width="120px">
                                <template scope="scope">
                                    <el-switch
                                            style="display: block"
                                            v-model="scope.row.isPayment"
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
                                    <el-button @click.native.prevent="deleteRow(scope.$index, infiledList)" size="small"> 移除 </el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </template>
                </el-form-item>
            </el-form>

            <el-divider>保修信息</el-divider>
            <%--保修单的表单--%>
            <el-form ref="Warrantyform" :model="Warrantyform" label-width="80px">
                <el-row>
                    <el-col :span="8">
                        <el-form-item label="合同单号:">
                            <el-input v-model="Warrantyform.sn" :disabled="true" ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="保修单号:">
                            <el-input v-model="Warrantyform.warrantysn" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="保修客户:">
                            <el-input v-model="Warrantyform.customer" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="16">
                        <el-form-item label="保修日期:">
                            <el-date-picker :disabled="true" v-model="Warrantyform.startTime" type="date" placeholder="开始日期"></el-date-picker>
                            <span>-</span>
                            <el-date-picker :disabled="true" v-model="Warrantyform.endTime" type="date" placeholder="结束日期"></el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="所属租户:">
                            <el-input v-model="Warrantyform.tenant_id" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>

            </el-form>

            <el-form-item style="text-align: right;">
                <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>

    <%--付款明细单的弹窗--%>
    <el-dialog title="付款详情" :visible.sync="dialogTableVisible">
        <el-table :data="gridData">
            <el-table-column prop="payTime" label="付款时间" width="190"></el-table-column>
            <el-table-column prop="money" label="付款金额" width="160">
                <template slot-scope="scope">
                    <font color="red">￥:{{scope.row.money}}</font>
                </template>
            </el-table-column>
            <el-table-column prop="scale" label="所占比例" width="160">
                <template slot-scope="scope">
                    <font color="orange">{{scope.row.scale}}%</font>
                </template>
            </el-table-column>
            <el-table-column prop="isPayment" label="是否付款" width="160">
                <template slot-scope="scope">
                    <font color="green">{{scope.row.isPayment == 1 ? "已付款" : ""}}</font>
                    <font color="#808080">{{scope.row.isPayment == 0 ? "未付款" : ""}}</font>
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
    /*保留两位小数的过滤器*/
    filters:{
        number:function(data){
            return data.toFixed(2)
        }
    },
    data: {
        dialogTableVisible:false,
        gridData:[],
        startTime:'',
        endTime:'',
        /*保修单的表单*/
        Warrantyform:{
            sn:'',
            warrantysn:'',
            startTime:'',
            endTime:''
        },
        /*详单的*/
        money:0,
        scale:'',
        value2: false,
        value1: '',
        inServForm:{
            moeny:0,
            itemsn:'',
            payTime:'',
            tenant_id:'',

        },
        infiledList:[],
        totalmoney2:0,
        tenants:[],
        totalNum: 0,
        currentPage: 1,
        pageNum: 1,
        pageSize: 10,
        ruleForm: {
            sn: '',
            customer:'',
            seller:'',
            earnestsum:'',
            signTime:'',
            intro:'',
            tenant_id:'',
        },
        rules: {
            customer: [
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
        //客户点击文字链接查看付款详细数据
        handleDelete(index, row){
            console.debug(row);
            var params ={"itemsn":row.sn};
            var currentVue = this;
            //查询付款详细
            axios.post('/contractItem/findByPage',params).then(function (response) {
                currentVue.gridData = response.data.rows;
            }) .catch(function () {
            });
            this.dialogTableVisible = true;
        },
        editContract() {
            if (this.currentRow) {
                this.dialogVisible = true;
                var currentVue = this;
                this.ruleForm = this.currentRow;
                var params ={"itemsn":this.currentRow.sn};
                //查询付款详细
                axios.post('/contractItem/findByPage',params).then(function (response) {
                    console.debug(response.data);
                    currentVue.infiledList = response.data.rows();
                }) .catch(function () {
                });
                //查询保修单信息
                var params2 ={"sn":this.currentRow.sn};
                axios.post('/repair/findByPage',params2).then(function (response1) {
                    console.debug(1111122);
                    console.debug(response1.data);
                    currentVue.Warrantyform = response1.data.rows();
                }) .catch(function () {
                });
            } else {
                this.$message({
                    message: '请选中需要编辑的数据!!!',
                    type: 'warning'
                });
            }
        },
        deleteContract(){
            if(this.currentRow){
                this.$confirm('此操作将永久删除'+this.currentRow.customer+'吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    var self = this;
                    axios.get("/contract/delete",{params: {id: this.currentRow.id}}).then(function(res){
                        if(res.data.success){
                            self.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            self.loadContractData();
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
            this.loadContractData();
        },
        handleCurrentChange(val) {
            this.pageNum = val;
            this.loadContractData();
        },
        contractSearcher(){
            var params = {"keyword":this.inputSearch,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/contract/findByPage",params).then(function(res){
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
            this.randomWord();

            //清空表单完毕
            this.Warrantyform.sn = this.ruleForm.sn;
            this.dialogVisible = true;
        },
        submitForm(formName) {
            for (var i = 0; i < this.infiledList.length; i++) {
                this.infiledList[i].itemsn = this.ruleForm.sn;
                this.infiledList[i].earnestsum = this.ruleForm.earnestsum;
            };
            var su = this;
            var params = this.ruleForm;
            //详单的表格数据
            var params2 = this.infiledList
            //添加合同数据
            axios.post('/contract/save', params).then(function (result) {
                if (result.data.success) {
                    su.dialogFormVisible = false;
                    su.loadContractData();
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
            });
            //保存详单数据
            if (params2.length > 0){
                axios.post('/contractItem/saves', params2).then(function (result) {
                    if (result.data.success) {
                        su.dialogFormVisible = false;
                        su.loadContractData();
                        /*this.$message({
                            type: 'success',
                            message: '操作成功！'
                        });*/
                    } else {
                        this.$message({
                            type: 'error',
                            message: result.data.msg
                        });
                    }
                }).catch(function (error) {
                });
            };
            //保修单的保存数据
            var Warrantyparams = this.Warrantyform;
            axios.post('/repair/save', Warrantyparams).then(function (result) {
                if (result.data.success) {
                    su.dialogVisible = false;
                    su.loadContractData();
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
        resetForm(formName) {
            this.$refs[formName].resetFields();
        },
        loadContractData() {
            var pageParam = {"keyword":this.keyword,"pageNum":this.pageNum,"pageSize":this.pageSize};
            var self = this;
            axios.post("/contract/findByPage",pageParam).then(function (res) {
                self.tableData=res.data.rows;
                self.totalNum=res.data.total;
            }).catch(function () {
            })
        },
        deleteRow(index, rows) {//删除改行
            rows.splice(index, 1);
        },
        addRow(tableData,event){
            tableData.push({ fildna: '',fildtp:'',remark:''
            })
        },
        tenantChang(){
            //当tenant租户input框失去焦点的时候，触发方法，并赋值给维修单里面的tenant客户
            this.Warrantyform.tenant_id = this.ruleForm.tenant_;
        },
        customerChang(){
            //当customer合同客户input框失去焦点的时候，触发方法，并赋值给维修单里面的维修客户
            this.Warrantyform.customer = this.ruleForm.customer;
        },
        /*当合同详单里面的日期变化的时候，执行这个方法*/
        signTimechange(){
            //时间确定以后，更改维修单里面的开始时间和到期时间
            //获取合同单里面的签订时间,并更改保修单里面开始时间和到期时间
            var formtie =  this.ruleForm.signTime;
            console.debug(formtie);
            this.Warrantyform.startTime = formtie;
            this.Warrantyform.endTime = formtie.getTime() + 3600 * 1000 * 24 * 366;
        },
        //生成随机合同单号
        randomWord(){
            var str = "",
                arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
            for(var i=0; i<4; i++){
                pos = Math.round(Math.random() * (arr.length-1));
                str += arr[pos];
            }
            var d = new Date();
            var year = d.getFullYear();
            var mouth = (d.getMonth() + 1) < 10 ? ('0' + (d.getMonth() + 1)) : (d.getMonth() + 1);
            var day = d.getDate() < 10 ? ('0' + d.getDate()) : d.getDate();
            var hour = d.getHours() < 10 ? '0' + d.getHours() : d.getHours();
            var minutes = d.getMinutes() < 10 ? '0' + d.getMinutes() : d.getMinutes();
            var second = d.getSeconds() < 10 ? '0' + d.getSeconds() : d.getSeconds();
            var curTime = year + mouth + day + hour +minutes;
            var curTime2 = year + mouth + day + hour;
            //随机生成合同单号
            this.ruleForm.sn = "YJCM-"+curTime+"-"+str;
            //随机生成保修单号
            this.Warrantyform.warrantysn = "YCKZ-"+curTime2+"-"+str;
        }
    },
    mounted(){
        this.loadContractData();

    }
});


</script>
</body>
</html>
