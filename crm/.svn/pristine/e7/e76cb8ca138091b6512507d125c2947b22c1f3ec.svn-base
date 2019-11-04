<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>潜在客户开发计划</title>
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
            <el-button type="primary" icon="el-icon-search" size="small" @click="selectCustomerDevPlan">搜索</el-button>
            <el-button @click="openAdd" type="primary" size="small" icon="el-icon-plus">添加计划</el-button>
            <el-dialog :title="formtitle" :visible.sync="dialogVisible" width="36%">
                <%--添加和修改窗口--%>
                <el-form :model="customerDevPlan" ref="formName" :rules="rules" label-width="120px" label-position="left">
                    <el-form-item label="计划时间:">
                        <el-date-picker style="width: 100%"
                                        v-model="customerDevPlan.planTime"
                                        type="date"
                                        placeholder="选择日期"
                                        value-format="yyyy-MM-dd HH:mm:ss"
                                        :disabled="disabled">
                        </el-date-picker>
                    </el-form-item>
                    <el-form-item label="计划主题:" prop="planSubject">
                        <el-input v-model="customerDevPlan.planSubject" :disabled="disabled"></el-input>
                    </el-form-item>
                    <el-form-item label="计划内容:" prop="planDetails">
                        <el-input type="textarea" v-model="customerDevPlan.planDetails" :disabled="disabled"></el-input>
                    </el-form-item>
                    <el-form-item label="实施方式:" prop="planType">
                        <el-select v-model="customerDevPlan.planType" :filterable="true" value-key="id" :disabled="disabled" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in planTypes"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="潜在客户:" prop="customer">
                        <el-select v-model="customerDevPlan.customer" :filterable="true" :disabled="disabled" value-key="id" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in customers"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item">
                            </el-option>
                            <el-option v-if="customer"
                                       :label="customer.name"
                                       :value="customer">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="实施结果:">
                        <el-select v-model="customerDevPlan.state" :filterable="true" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in states"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                                    :disabled="item.disabled">
                            </el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
						    <el-button @click="dialogVisible = false">取 消</el-button>
						    <el-button type="primary" @click="saveCustomerDevPlan">确 定</el-button>
						</span>
            </el-dialog>
        </el-col>
    </el-row>
    <el-row style="margin-top:10px">
        <el-col :span="22" :offset="1">
            <%--数据展示--%>
            <el-table :data="customerDevPlans" ref="multipleTable" stripe style="width: 100%">
                <el-table-column prop="planTime" label="计划时间" width="200px"></el-table-column>
                <el-table-column prop="planSubject" label="计划主题">
                    <template slot-scope="scope">
                        <el-popover trigger="hover" placement="top">
                            <p>计划内容: {{ scope.row.planDetails }}</p>
                            <p>创建人: {{ scope.row.inputUser.realname }}</p>
                            <p>创建时间: {{ scope.row.inputTime }}</p>
                            <div slot="reference" class="name-wrapper">
                                <el-tag size="medium">{{ scope.row.planSubject }}</el-tag>
                            </div>
                        </el-popover>
                    </template>
                </el-table-column>
                <el-table-column prop="planType.name" label="实施方式"></el-table-column>
                <el-table-column prop="customer.name" label="潜在客户"></el-table-column>
                <%--0未实施，2-待定，1-成功，-1失败--%>
                <el-table-column prop="state" label="实施结果">
                    <template slot-scope="scope">
                        <span v-if="scope.row.state == 0">未实施</span>
                        <span v-else-if="scope.row.state == 2" style="color: #1c2699">待定</span>
                        <span v-else-if="scope.row.state == 1" style="color: lime">成功</span>
                        <span v-else style="color: red">失败</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="400px">
                    <template slot-scope="scope">
                        <el-button size="mini" class="el-icon-edit" @click="editCustomerDevPlan(scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger" class="el-icon-delete" @click="deleteCustomerDevPlan(scope.row)">删除</el-button>
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
            disabled:false,
            /*展开form表单部分输入框*/
            formtitle: "新增",
            customerDevPlans: [],
            total:null,
            pageNum:1,
            pageSize:10,
            dialogVisible: false,
            planTypes:[], //所有实施方式
            customer:null, //临时保存当前客户
            customers:[], //所有客户
            customerDevPlan: {
                id:null,
                planTime: null,
                planSubject: null,
                planDetails: null,
                planType:null,
                customer:null,
                state:0
            },
            options: [{
                value: 'customerName',
                label: '客户名称'
            }, {
                value: 'state',
                label: '实施结果'
            }],
            <%--0未实行，2-待定，1-成功，-1失败--%>
            states:[{
                value: 0,
                label: '未实行',
                disabled:false
            }, {
                value: 2,
                label: '待定'
            }, {
                value: 1,
                label: '成功'
            }, {
                value: -1,
                label: '失败'
            }],

            beginDate:null,
            endDate:null,
            value: '',
            input: '',
            rules: {
                planSubject:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                planDetails:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                planType:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ],
                customer:[{
                    required: true,
                    message: '请输入信息！',
                    trigger: 'blur'
                }
                ]
            }
        },
        methods: {
            /*高级查询*/
            selectCustomerDevPlan(){
                this.pageNum = 1;
                this.loadCustomerDevPlans();
            },
            page(currentPage){
                this.pageNum = currentPage;
                this.loadCustomerDevPlans();
            },
            /*加载所有计划数据*/
            loadCustomerDevPlans(){
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
                axios.post("/customerDevPlan/findByPage",param).then((resp)=>{
                    console.debug(resp.data)
                    this.total = resp.data.total
                    this.customerDevPlans = resp.data.rows
                })
            },
            deleteCustomerDevPlan(row) {
                this.$confirm('此操作将永久删信息, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get("/customerDevPlan/delete",{
                        params:{id:row.id}
                    }).then((resp)=>{
                        if(resp.data.success){
                            this.loadCustomerDevPlans();
                        }
                        this.$message({
                            type: 'success',
                            message: resp.data.msg
                        });
                    })
                })
            },
            /*加载所有下拉框数据*/
            loadSelection(){
                /*加载所有潜在客户数据*/
                axios.post("/customer/list",{state:10}).then((resp)=>{
                    this.customers = resp.data
                })
                /*加载所有实施方式*/
                axios.post("/systemDictionaryItem/listNoPage",{
                    parentId:17
                }).then((resp)=>{
                    this.planTypes = resp.data.result
                })
            },
            openAdd() {
                this.loadSelection();
                this.disabled = false   //所有输入框可以输入
                this.states[0].disabled = false
                this.formtitle = "新增"
                this.customerDevPlan = {
                    id:null,
                    planTime: null,
                    planSubject: null,
                    planDetails: null,
                    planType:null,
                    customer:null,
                    state:0
                }
                this.dialogVisible = true
            },
            editCustomerDevPlan(row){
                this.loadSelection();
                this.formtitle = "修改"
                this.customerDevPlan = this.copyObj(row)
                this.customer = this.copyObj(row.customer)
                if(row.state != 0){
                    this.disabled = true
                    this.states[0].disabled = true
                    this.$message({
                        type: 'warning',
                        message: "不是未实施状态，不能修改计划"
                    });
                }else{
                    this.disabled = false
                    this.states[0].disabled = false
                }
                this.dialogVisible = true
            },
            saveCustomerDevPlan(){
                this.$refs['formName'].validate((valid) => {
                    if(valid) {
                        axios.post("/customerDevPlan/save",this.customerDevPlan)
                            .then((resp)=>{
                                if(resp.data.success){
                                    this.dialogVisible = false
                                    this.loadCustomerDevPlans();
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
            this.loadCustomerDevPlans();
        }
    })
</script>
</body>
</html>
