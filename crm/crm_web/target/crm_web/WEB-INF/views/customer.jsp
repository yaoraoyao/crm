<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>客户管理</title>
    <%@include file="common.jsp"%>
    <style>
        .el-select .el-input {
            width: 130px;
        }

        .input-with-select .el-input-group__prepend {
            background-color: #fff;
        }
    </style>
</head>

<body>
<div id="t1">
    <el-row style="margin-top:10px">
        <el-col :span="21" :offset="2">
            <template>
                <el-select v-model="value" :filterable="true" clearable style="width: 150px" placeholder="请选择" size="small">
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
            <el-button icon="el-icon-search" size="small" @click="selectCustomer">搜索</el-button>
            <el-button @click="openAdd" type="primary" size="small" icon="el-icon-plus">添加</el-button>
            <el-button @click="openSeller" type="primary" size="small" icon="el-icon-plus">指派营销人员</el-button>
            <el-button @click="saveSeller(-1)" type="danger" size="small" icon="el-icon-position">放入资源池</el-button>
            <el-button type="warning" size="small" @click="customerExport" icon="el-icon-upload2">导出客户信息</el-button>
            <el-upload style="display: inline;margin-left: 10px;"
                       class="upload-demo"
                       action="/customer/customerImport"
                       :file-list="fileList"
                       :on-success="uploadSuccess"
            >
                <el-button size="small" type="warning" icon="el-icon-download">导入客户信息</el-button>
            </el-upload>
            <%--添加跟进表单--%>
            <el-dialog title="添加跟进" :visible.sync="dialogVisibleTrace" width="50%">
                <el-form :model="customerTraceHistory" label-width="120px">
                    <el-form-item label="客户:">
                        <el-select v-model="customerTraceHistory.customer" :disabled="true" value-key="id" :filterable="true" clearable placeholder="请选择">
                            <el-option
                                    v-if="customerTraceHistory.customer"
                                    :key="customerTraceHistory.customer.id"
                                    :label="customerTraceHistory.customer.name"
                                    :value="customerTraceHistory.customer">
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
						    <el-button @click="dialogVisibleTrace = false">取 消</el-button>
						    <el-button type="primary" @click="saveCustomerTraceHistory">确 定</el-button>
						</span>
            </el-dialog>
            <%--营销人员移交表单--%>
            <el-dialog title="移交" :visible.sync="dialogVisibleTransfer" width="50%">
                <el-form :model="customerTransfer" label-width="120px">
                    <el-form-item label="客户:">
                        <el-select v-model="customerTransfer.customer" :disabled="true" value-key="id" clearable placeholder="请选择">
                            <el-option
                                    v-if="customerTransfer.customer"
                                    :key="customerTransfer.customer.id"
                                    :label="customerTransfer.customer.name"
                                    :value="customerTransfer.customer">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="老市场专员:">
                        <el-select v-model="customerTransfer.oldSeller" :disabled="true" value-key="id" clearable placeholder="请选择">
                            <el-option
                                    v-if="customerTransfer.oldSeller"
                                    :key="customerTransfer.oldSeller.id"
                                    :label="customerTransfer.oldSeller.realname"
                                    :value="customerTransfer.oldSeller">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="新市场专员:">
                        <el-select v-model="customerTransfer.newSeller" value-key="id" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in sellers"
                                    :key="item.value"
                                    :label="item.realname"
                                    :value="item">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="移交原因:">
                        <el-input type="textarea" v-model="customerTransfer.transReason"></el-input>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisibleTransfer = false">取 消</el-button>
                    <el-button type="primary" @click="saveCustomerTransfer">确 定</el-button>
                </span>
            </el-dialog>
            <%--指派营销人员表单--%>
            <el-dialog title="指派营销人员" :visible.sync="dialogVisibleSeller" width="50%">
                <el-form label-width="120px">
                    <el-form-item label="指派营销人员:">
                        <el-select v-model="sellerValue" :filterable="true" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in sellers"
                                    :key="item.value"
                                    :label="item.realname"
                                    :value="item.id">
                            </el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisibleSeller = false">取 消</el-button>
                    <el-button type="primary" @click="saveSeller(1)">确 定</el-button>
                </span>
            </el-dialog>
            <%--添加客户信息表单--%>
            <el-dialog :title="formtitle" :visible.sync="dialogVisible" width="36%">
                <el-form :model="customer" ref="formName" :rules="rules" label-width="120px" label-position="left">
                    <div v-if="openfrom">
                        <el-form-item label="用户名:" prop="name">
                            <el-input v-model="customer.name"></el-input>
                        </el-form-item>
                        <el-form-item label="年龄:" prop="age">
                            <el-input v-model="customer.age"></el-input>
                        </el-form-item>
                        <el-form-item label="性别:">
                            <el-radio v-model="customer.gender" :label="1">男</el-radio>
                            <el-radio v-model="customer.gender" :label="0">女</el-radio>
                        </el-form-item>
                        <el-form-item label="电话:" prop="tel">
                            <el-input v-model="customer.tel"></el-input>
                        </el-form-item>
                        <el-form-item label="成功率:" prop="successRate">
                            <el-input v-model="customer.successRate"></el-input>
                        </el-form-item>
                    </div>
                    <div align="right"><el-button type="primary" size="mini" icon="el-icon-d-caret" @click="openFrom">收起当前,展开更多信息</el-button></div>
                    <div v-if ="!openfrom">
                        <el-form-item label="邮箱:">
                            <el-input v-model="customer.email"></el-input>
                        </el-form-item>
                        <el-form-item label="QQ:">
                            <el-input v-model="customer.qq"></el-input>
                        </el-form-item>
                        <el-form-item label="微信:">
                            <el-input v-model="customer.wechat"></el-input>
                        </el-form-item>
                        <el-form-item label="营销人员:">
                            <el-select v-model="customer.seller" :filterable="true" :disabled="disabledSeller" value-key="id" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in sellers"
                                        :key="item.id"
                                        :label="item.realname"
                                        :value="item">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="客户职业:">
                            <el-select v-model="customer.job" :filterable="true" value-key="id" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in jobs"
                                        :key="item.value"
                                        :label="item.name"

                                        :value="item">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="客户来源:">
                            <el-select v-model="customer.customerSource" :filterable="true" value-key="id" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in customerSources"
                                        :key="item.value"
                                        :label="item.name"
                                        :value="item">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="客户收入阶梯:">
                            <el-select v-model="customer.salaryLevel" :filterable="true" value-key="id" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in salaryLevels"
                                        :key="item.value"
                                        :label="item.name"
                                        :value="item">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="客户状态:">
                            <el-select v-model="customer.state" :filterable="true" clearable placeholder="请选择">
                                <el-option
                                        v-for="item in states"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </div>
                </el-form>
                <span slot="footer" class="dialog-footer">
						    <el-button @click="dialogVisible = false">取 消</el-button>
						    <el-button type="primary" @click="saveCustomer">确 定</el-button>
						</span>
            </el-dialog>
        </el-col>
    </el-row>
    <el-row style="margin-top:10px">
        <el-col :span="22" :offset="1">
            <%--展示客户信息--%>
            <el-table :data="customers" ref="multipleTable"
                      @selection-change="handleSelectionChange"
                      stripe style="width: 100%">
                <el-table-column type="selection"></el-table-column>
                <el-table-column prop="name" label="客户名称">
                    <template slot-scope="scope">
                        <el-popover trigger="hover" placement="top">
                            <p>姓名: {{ scope.row.name }}</p>
                            <p>年龄: {{ scope.row.age }}</p>
                            <p v-if="scope.row.job != null">职业: {{ scope.row.job.name }}</p>
                            <p v-if="scope.row.salaryLevel != null">收入水平: {{ scope.row.salaryLevel.name }}</p>
                            <p>邮箱: {{ scope.row.email }}</p>
                            <p>QQ: {{ scope.row.qq }}</p>
                            <p>微信: {{ scope.row.wechat }}</p>
                            <p>成功率: {{ scope.row.successRate }}</p>
                            <p v-if="scope.row.inputUser != null">创建人: {{ scope.row.inputUser.realname }}</p>
                            <p>创建时间: {{ scope.row.inputTime }}</p>
                            <div slot="reference" class="name-wrapper">
                                <el-tag size="medium">{{ scope.row.name }}</el-tag>
                            </div>
                        </el-popover>
                    </template>
                </el-table-column>
                <el-table-column prop="gender" label="性别">
                    <template slot-scope="scope">
                        <span v-if="scope.row.gender==1">男</span>
                        <span v-else>女</span>
                    </template>
                </el-table-column>
                <el-table-column prop="tel" label="电话" width="150"></el-table-column>
                <el-table-column prop="customerSource" label="客户来源" width="100">
                    <template slot-scope="scope">
                        <span v-if="scope.row.customerSource == null"></span>
                        <span v-else>{{scope.row.customerSource.name}}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="seller" label="营销人员" width="100">
                    <template slot-scope="scope">
                        <span v-if="scope.row.seller == null"></span>
                        <span v-else>{{scope.row.seller.realname}}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="state" label="客户状态" width="100">
                    <%--客户状态：0-潜在客户，1-正式客户，-1-资源池--%>
                    <template slot-scope="scope">
                        <span v-if="scope.row.state==0">潜在客户</span>
                        <span v-else-if="scope.row.state==1" style="color:lime">正式客户</span>
                        <span v-else style="color: red">资源池</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="350px">
                    <template slot-scope="scope">
                        <el-button size="mini" class="el-icon-edit" @click="editCustomer(scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger" class="el-icon-delete" @click="deleteCustomer(scope.row)">删除</el-button>
                        <el-button size="mini" type="info" @click="openTransfer(scope.row)" class="el-icon-sort">移交</el-button>
                        <el-button v-if="scope.row.state == 1" size="mini" type="success" class="el-icon-star-off" @click="openTrace(scope.row)">跟进</el-button>
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
            /*文件上传列表*/
            fileList:[],
            /*展开form表单部分输入框*/
            openfrom:true,
            formtitle: "新增",
            customers: [],
            total:null,
            pageNum:1,
            pageSize:10,
            disabledSeller:false, //控制营销人员更改
            dialogVisibleTrace:false,
            dialogVisibleTransfer:false,
            dialogVisibleSeller:false,
            dialogVisible: false,
            sellerValue:'',     //选中的营销人员
            sellers:[],     //所有营销人员
            jobs:[],     //所有职业
            traceTypes:[], //所有跟进方式
            customerSources:[],     //所有客户来源
            salaryLevels:[],     //所有收入水平
            /*关联的移交form表单*/
            customerTransfer:{
                customer:null,
                oldSeller:null,
                newSeller:null,
                transReason:null
            },
            /*关联的客户信息form表单*/
            customer: {
                id:null,
                name: null,
                age: null,
                gender: 1,
                tel:null,
                successRate:null,
                email:null,
                qq:null,
                seller:null,
                job:null,
                customerSource:null,
                salaryLevel:null,
                state:0
            },
            /*关联跟进的form表单*/
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
                value: 'name',
                label: '客户名称'
            }, {
                value: 'seller',
                label: '营销人员'
            }, {
                value: 'state',
                label: '客户状态'
            }],
            states:[{
                value: 0,
                label: '潜在客户'
            }, {
                value: 1,
                label: '正式客户'
            }, {
                value: -1,
                label: '资源池'
            }],
            value: '',
            input: '',
            multipleSelection: [],
            /*验证规则*/
            rules: {
                name:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                age:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                gender:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                tel:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                successRate:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ]
            }
        },
        methods: {
            /*导出客户信息*/
            customerExport(){
                location.href="/customer/export";
            },
            /*上传成功*/
            uploadSuccess(response){
                this.fileList = [];
                this.loadCustomers();
                this.$message({
                    type: 'success',
                    message: "上传成功！"
                })
            },
            /*打开移交表单*/
            openTransfer(row){
                if(!row.seller){
                    this.$message({
                        type: 'error',
                        message: "该用户未指派营销人员"
                    })
                    return
                }
                this.customer = this.copyObj(row);
                this.customerTransfer={
                    customer:null,
                    oldSeller:null,
                    newSeller:null,
                    transReason:null
                }
                this.dialogVisibleTransfer = true
                this.customerTransfer.customer = row
                this.customerTransfer.oldSeller = row.seller
            },
            /*保存移交*/
            saveCustomerTransfer(){
                this.customer.seller = this.customerTransfer.newSeller;
                axios.post("/customer/save",this.customer)
                    .then((resp)=>{
                        if(resp.data.success){
                            axios.post("/customerTransfer/save",this.customerTransfer)
                                .then((resp)=>{
                                    if(resp.data.success){
                                        this.dialogVisibleTransfer = false
                                    }
                                })
                            this.dialogVisible = false
                            this.loadCustomers();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
            },
            /*打开添加跟进表单*/
            openTrace(row){
                /*加载所有客户跟进方式数据*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:19
                }).then((resp)=>{
                    this.traceTypes = resp.data.result
                })
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
                this.customerTraceHistory.customer = row
                this.customerTraceHistory.traceUser = row.seller
                this.dialogVisibleTrace = true
            },
            saveCustomerTraceHistory(){
                axios.post("/customerTraceHistory/save",this.customerTraceHistory)
                    .then((resp)=>{
                        if(resp.data.success){
                            this.dialogVisibleTrace = false
                            this.loadCustomers();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
            },
            /*监听选中的数据*/
            handleSelectionChange(val){
                this.multipleSelection = val;
            },
            /*打开指派营销人员表单*/
            openSeller(){
                this.sellerValue = null
                if(this.multipleSelection.length){
                    for(var i = 0;i<this.multipleSelection.length;i++){
                        if(this.multipleSelection[i].seller){
                            this.$message({
                                type: 'error',
                                message: "至少有一条数据已指派营销人员"
                            })
                            return
                        }
                    }
                    this.dialogVisibleSeller=true
                }else{
                    this.$message({
                        type: 'error',
                        message: "请选择至少一条数据"
                    })
                }
            },
            /*保存指派和放入资源池*/
            saveSeller(value){
                console.debug(value)
                var ids = ''
                for(var i= 0;i<this.multipleSelection.length-1;i++ ){
                    ids += this.multipleSelection[i].id + ','
                }
                ids += this.multipleSelection[this.multipleSelection.length-1].id
                axios.post("/customer/updateSeller",{ids:ids,sellerId:this.sellerValue,states:value}
                ).then((resp)=>{
                    this.dialogVisibleSeller=false
                    if(resp.data.success){
                        this.loadCustomers();
                    }
                    this.$message({
                        type: 'success',
                        message: resp.data.msg
                    });
                })
            },
            /*展开form表单部分输入框*/
            openFrom(){
                this.openfrom = !this.openfrom
            },
            selectCustomer(){
                this.pageNum = 1;
                this.loadCustomers();
            },
            page(currentPage){
                this.pageNum = currentPage;
                this.loadCustomers();
            },
            /*加载所有下拉框数据*/
            loadSelection(){
                /*加载所有客户职业数据*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:9
                }).then((resp)=>{
                    this.jobs = resp.data.result
                })
                /*加载所有客户来源数据*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:1
                }).then((resp)=>{
                    this.customerSources = resp.data.result
                })
                /*加载所有收入水平数据*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:16
                }).then((resp)=>{
                    this.salaryLevels = resp.data.result
                })
            },
            /*加载数据*/
            loadCustomers(){
                axios.post("/employee/findAll").then((resp)=>{
                    this.sellers = resp.data
                })
                var param = {}
                if(this.input){
                    param[this.value] = this.input
                }else{
                    param[this.value] = ''
                }
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                axios.post("/customer/findByPage",param).then((resp)=>{
                    console.debug(resp)
                    this.total = resp.data.rows.total
                    this.customers = resp.data.rows
                })
            },
            /*删除客户信息*/
            deleteCustomer(row) {
                this.$confirm('此操作将永久删信息, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/customer/delete",{
                        params:{id:row.id}
                    }).then((resp)=>{
                        if(resp.data.success){
                            this.loadCustomers();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
                })
            },
            /*打开添加客户信息框*/
            openAdd() {
                this.loadSelection()
                this.disabledSeller = false
                this.formtitle = "新增"
                this.customer = {
                    id:null,
                    name: null,
                    age: null,
                    gender: 1,
                    tel:null,
                    successRate:null,
                    email:null,
                    qq:null,
                    seller:null,
                    job:null,
                    customerSource:null,
                    salaryLevel:null,
                    state:0
                }
                this.openfrom = true
                this.dialogVisible = true
            },
            editCustomer(row){
                this.loadSelection()
                this.disabledSeller = true
                this.formtitle = "修改"
                this.customer = this.copyObj(row)
                console.debug(this.customer)
                // this.sellers.realname = this.customer.seller.realname
                // this.customerSources.name = this.customer.customerSource.name


                this.openfrom = true
                this.dialogVisible = true
            },
            /*增加和修改方法*/
            saveCustomer(){
                this.$refs['formName'].validate((valid) => {
                    if(valid) {
                        axios.post("/customer/save",this.customer)
                            .then((resp)=>{
                                if(resp.data.success){
                                    this.dialogVisible = false
                                    this.loadCustomers();
                                }
                                this.$message({
                                    type: 'success',
                                    message: resp.data.msg
                                });
                            })
                    }
                });
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
            this.loadCustomers();
        }
    })
</script>
</body>

</html>