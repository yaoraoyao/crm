<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>客户跟进历史</title>
    <%@include file="common.jsp"%>
</head>
<body>
<div id="t1">
    <el-row style="margin-top:10px">
        <el-col :span="21" :offset="2">
            <el-date-picker
                    v-model="beginDate"
                    type="date"
                    placeholder="开始日期"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 150px">
            </el-date-picker>
            <el-date-picker
                    v-model="endDate"
                    type="date"
                    placeholder="截止日期"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 150px">
            </el-date-picker>
            筛选条件:
            <template>
                <el-select v-model="value" clearable style="width: 150px" placeholder="请选择" :filterable="true" size="small">
                    <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </template>
            <el-input
                    placeholder="请输入内容"
                    v-model="input"
                    clearable size="small" style="width: 150px">
            </el-input>
            <el-button type="primary" icon="el-icon-search" size="small" @click="selectCustomerTraceHistory">搜索</el-button>
            <el-button @click="openAdd" type="primary" size="small" icon="el-icon-plus">添加</el-button>
            <el-dialog :title="formtitle" :visible.sync="dialogVisible" width="50%">
                <%--添加和修改窗口--%>
                <el-form :model="customerTraceHistory" label-width="auto" label-position="top">
                    <el-form-item label="客户:">
                        <el-select v-model="customerTraceHistory.customer" @change="customerChange" value-key="id" :filterable="true" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in customers"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="跟进人:">
                        <el-select v-model="customerTraceHistory.traceUser" :disabled="true" value-key="id" clearable placeholder="请选择">
                            <el-option
                                    v-if="customerTraceHistory.traceUser"
                                    :key="customerTraceHistory.traceUser.id"
                                    :label="customerTraceHistory.traceUser.realname"
                                    :value="customerTraceHistory.traceUser">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="时间:">
                        <el-date-picker style="width: 100%"
                                        v-model="customerTraceHistory.traceTime"
                                        type="date"
                                        placeholder="选择日期"
                                        value-format="yyyy-MM-dd HH:mm:ss"
                        >
                        </el-date-picker>
                    </el-form-item>
                    <el-form-item label="主题:">
                        <el-input v-model="customerTraceHistory.title"></el-input>
                    </el-form-item>
                    <el-form-item label="备注:">
                        <el-input type="textarea" v-model="customerTraceHistory.remark"></el-input>
                    </el-form-item>
                    <el-form-item label="跟进方式:">
                        <el-select v-model="customerTraceHistory.traceType" value-key="id" :filterable="true" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in traceTypes"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="跟进效果:">
                        <el-radio v-model="customerTraceHistory.traceResult" :label="1">好</el-radio>
                        <el-radio v-model="customerTraceHistory.traceResult" :label="0">中</el-radio>
                        <el-radio v-model="customerTraceHistory.traceResult" :label="-1">差</el-radio>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
						    <el-button @click="dialogVisible = false">取 消</el-button>
						    <el-button type="primary" @click="saveCustomerTraceHistory">确 定</el-button>
						</span>
            </el-dialog>
        </el-col>
    </el-row>
    <el-row style="margin-top:10px">
        <el-col>
            <%--数据展示--%>
            <el-table :data="customerTraceHistorys" ref="multipleTable"  stripe style="width: 100%">
                <el-table-column prop="customer.name" label="跟进客户" ></el-table-column>
                <el-table-column prop="traceUser.realname" label="跟进人"></el-table-column>
                <el-table-column prop="title" label="主题" width="200px">
                    <template slot-scope="scope">
                        <el-popover trigger="hover" placement="top">
                            <p>备注: {{ scope.row.remark }}</p>
                            <p>时间: {{ scope.row.traceTime }}</p>
                            <div slot="reference" class="name-wrapper">
                                <el-tag size="medium">{{ scope.row.title }}</el-tag>
                            </div>
                        </el-popover>
                    </template>
                </el-table-column>
                <%--<el-table-column prop="traceTime" label="时间" ></el-table-column>--%>
                <el-table-column prop="traceType.name" label="跟进方式" ></el-table-column>
                <el-table-column prop="traceResult" label="跟进效果" >
                    <template slot-scope="scope">
                        <span v-if="scope.row.traceResult == 0" style="color: #1c2699">中</span>
                        <span v-else-if="scope.row.traceResult == 1" style="color: lime">好</span>
                        <span v-else style="color: red">差</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="400px">
                    <template slot-scope="scope">
                        <el-button size="mini" class="el-icon-edit" @click="editCustomerTraceHistory(scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger" class="el-icon-delete" @click="deleteCustomerTraceHistory(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <%--分页--%>
            <div style="text-align: right"><el-pagination
                    background
                    layout="prev, pager, next"
                    :total="total"
                    :page-size="pageSize"
                    :current-page="pageNum"
                    @current-change="page"
                    @prev-click="page"
                    @next-click="page">
            </el-pagination></div>
        </el-col>
    </el-row>
</div>
<script type="text/javascript">
    var v1 = new Vue({
        el: "#t1",
        data: {
            /*展开form表单部分输入框*/
            formtitle: "新增",
            customerTraceHistorys: [],
            total: null,
            pageNum: 1,
            pageSize: 10,
            dialogVisible: false,
            traceTypes:[],  //跟进方式
            customers: [], //所有客户
            traceUsers: [], //所有跟进人员
            customerTraceHistory: {
                id: null,
                customer: null,
                traceUser: null,
                traceTime: null,
                title: null,
                traceType: null,
                remark: null,
                traceResult: 1
            },
            options: [{
                value: 'customerName',
                label: '跟进客户'
            }, {
                value: 'traceUserName',
                label: '跟进人'
            }],
            beginDate: null,
            endDate: null,
            value: '',
            input: ''
        },
        methods: {
            /*监听选中的客户，填写营销人员*/
            customerChange(){
                this.customerTraceHistory.traceUser = this.customerTraceHistory.customer.seller
            },
            /*高级查询*/
            selectCustomerTraceHistory(){
                this.pageNum = 1;
                this.loadCustomerTraceHistory();
            },
            page(currentPage){
                this.pageNum = currentPage;
                this.loadCustomerTraceHistory();
            },
            /*加载所有下拉框需要的数据*/
            loadSelection(){
                /*加载所有正式客户数据*/
                axios.post("/customer/list",{
                    params:{state:1}
                }).then((resp)=>{
                    this.customers = resp.data
                })
                /*加载所有跟进方式数据*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:19
                }).then((resp)=>{
                    this.traceTypes = resp.data.result
                })
            },
            /*加载所有跟进数据*/
            loadCustomerTraceHistory(){
                var param = {}
                if(this.input){
                    param[this.value] = this.input
                }else{
                    param[this.value] = ''
                }
                param.beginDate = this.beginDate
                param.endDate = this.endDate
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/customerTraceHistory/findByPage",param).then((resp)=>{
                    this.total = resp.data.total
                    this.customerTraceHistorys = resp.data.rows
                })
            },
            deleteCustomerTraceHistory(row) {
                this.$confirm('此操作将永久删信息, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/customerTraceHistory/delete",{
                        params:{id:row.id}
                    }).then((resp)=>{
                        if(resp.data.success){
                            this.loadCustomerTraceHistory();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
                })
            },
            openAdd() {
                this.loadSelection()
                this.formtitle = "新增"
                this.customerTraceHistory = {
                    id:null,
                    customer: null,
                    traceUser: null,
                    traceTime: null,
                    title:null,
                    traceType:null,
                    remark:null,
                    traceResult:1
                }
                this.dialogVisible = true
            },
            editCustomerTraceHistory(row){
                this.loadSelection()
                this.formtitle = "修改"
                this.customerTraceHistory = this.copyObj(row)
                this.dialogVisible = true
            },
            saveCustomerTraceHistory(){
                axios.post("/customerTraceHistory/save",this.customerTraceHistory)
                    .then((resp)=>{
                        if(resp.data.success){
                            this.dialogVisible = false
                            this.loadCustomerTraceHistory();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
            },
            copyObj(obj) {
                var newObj = {}
                for(var e in obj) {
                    newObj[e] = obj[e]
                }
                return newObj;
            }
        },
        mounted(){
            this.loadCustomerTraceHistory();
        }
    })
</script>
</body>
</html>
