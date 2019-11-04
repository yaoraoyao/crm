
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>合同页面</title>
    <jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
    <style type="text/css">

        div.el-dialog__wrapper:nth-child(7) > div:nth-child(1) > div:nth-child(2) {
            width: 700px;
        }

        div.el-dialog__wrapper:nth-child(7) > div:nth-child(1) {
            /* width: 80%; */
            width: 760px;
        }

    </style>
</head>
<body>
<div id="app">
    <el-row style="margin-top:10px">
        <el-col :span="21" :offset="2">
            用户名:<el-input v-model="name" style="width: 100px" placeholder="请输入客户名"></el-input>
            时间范围查找 <el-date-picker  v-model="beginTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                                    value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            -<el-date-picker  v-model="endTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                              value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            <el-button size="small" @click="seach" type="primary" round icon="el-icon-search">搜索</el-button>
            <el-table :span="18" :offset="3" :data="contracts" style="width: 100%">
                <el-table-column prop="sn" label="合同单号" width="220px"></el-table-column>
                <el-table-column prop="customer.name" label="客户姓名" width="100px"></el-table-column>
                <el-table-column prop="signTime" label="签订时间" width="120"></el-table-column>
                <el-table-column prop="seller.username" label="销售人员" width="100px"></el-table-column>
                <el-table-column prop="sum" label="金额" width="100px"></el-table-column>
                <el-table-column prop="intro" label="描述" width="250px"></el-table-column>
                <el-table-column prop="name" label="操作" width="100px">
                    <template slot-scope="scope">
                        <el-button size="mini" type="primary" icon="el-icon-info"  @click="particulars(scope.row)">详情</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <%--分页--%>
            <template>
                <div style="text-align: right;margin-top: 10px;margin-right: 20%">
                    <el-pagination
                            background
                            layout="prev, pager, next"
                            :total="total"
                            :page-size="pageSize"
                            :current-page="pageNum"
                            @current-change="pageSelect">
                    </el-pagination>
                </div>
            </template>
            <template>
                <el-dialog
                        title="明细"
                        :visible.sync="dialogVisible_item"
                        width="80%">
                    <el-button size="mini" @click="openitem" round type="primary">添加</el-button>
                    <%--合同详情信息--%>
                    <el-table :span="18" :offset="3" :data="items" style="width: 100%">
                        <el-table-column prop="contractId" label="合同单号" width="250"></el-table-column>
                        <el-table-column prop="payTime" label="付款日期" width="120px"></el-table-column>
                        <el-table-column prop="money" label="付款金额" width="100px" ></el-table-column>
                        <el-table-column prop="scale" label="所占比例" width="120"></el-table-column>
                        <el-table-column prop="isPayment" label="是否付款" width="100">
                            <template slot-scope="scope">
                                    <span v-if="scope.row.isPayment==true">已支付</span>
                                    <span v-if="scope.row.isPayment==false">
                                        <el-button size="mini" @click="pay(scope.row)" type="primary">确认收款</el-button>
                                    </span>
                            </template>
                        </el-table-column>
                    </el-table>
                </el-dialog>
            </template>
            <%--明细添加--%>
            <template>
                <el-dialog
                        title="添加明细"
                        :visible.sync="dialogVisible_additem"
                        width="30%">
                            <span>
                            <el-form  :model="item" label-width="90px">
                                <el-form-item label="id：" style="display: none;">
                                    <el-input v-model="item.id" style="display: none;"></el-input>
                              </el-form-item>

                                <el-form-item label="所属合同：" >
                                <el-input v-model="item.contractId" readonly="true"></el-input>
                              </el-form-item>

                                <el-form-item label="付款金额：" >
                                <el-input v-model="item.money"  @change="changemoney"></el-input>
                              </el-form-item>
                                <el-form-item label="所占比例：" >
                                <el-input v-model="item.scale"  @change="changescale" style="width: 50px"></el-input>%
                              </el-form-item>

                                <el-form-item label="付款时间：" >
                                   <div class="block" >
                                    <el-date-picker
                                            v-model="item.payTime"
                                            type="date"
                                            placeholder="选择日期"
                                            value-format="yyyy-MM-dd HH:mm:ss"
                                            style="width: 180px"
                                    >
                                    </el-date-picker>
                                  </div>
                                </el-form-item>
                                <el-form-item label="是否付款：" >
                                    <el-radio v-model="item.isPayment" label="true">是</el-radio>
                                     <el-radio v-model="item.isPayment" label="false">否</el-radio>
                              </el-form-item>

                              <el-form-item>
                                <el-button size="mini" type="primary" @click="addItem">添加</el-button>
                                <el-button size="mini" type="primary" @click="cancel">取消</el-button>
                              </el-form-item>
                            </el-form>
                          </span>
                </el-dialog>
            </template>
        </el-col>
    </el-row>
</div>
<script >
    new Vue({
        el:"#app",
        data:{
            title:"添加订单",
            contracts:[],
            total:100,
            pageNum:1,
            pageSize:10,
            contract: {
                id : null,
                sn :null,
                customer: {},
                signTime :null,
                seller : {},
                sum : null,
                intro : null
            },
            dialogVisible:false/*save窗口*/,
            /*输入框是否为只读模式*/
            dialogVisible_item:false,
            /*明细添加窗口*/
            dialogVisible_additem:false,
            isReadonly:false,
            /*当前查看合同选中行数据*/
            row:null,
            /*客户提示数据*/
            customerlist:{
                id:null,
                age:null,
                gender:null,
                tel:null
            },
            name:null,
            beginTime:null,
            endTime:null,
            /*合同详情数据*/
            items:[],
            item:{
                /*合同编号*/
                contractId:null,
                /*付款金额*/
                money:null,
                /*所占比例*/
                scale:null,
                /*付款时间*/
                payTime:null,
                /*是否付款*/
                isPayment:null
            }
        },
        methods:{
            loadData() {
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                param.name=this.name;
                param.beginTime=this.beginTime
                param.endTime=this.endTime
                axios.get("/contract/page", {
                    params: param
                }).then((result) => {
                    this.total = result.data.total;
                    this.contracts = result.data.rows;
                })
            },/*分页*/
            pageSelect(pageNum){
                this.pageNum=pageNum;
                this.loadData();

            },/*打开窗口*/
            open(){
                /*数据清除*/
                this.contracts= {
                    id : null,
                    sn :null,
                    customerId : null,
                    signTime :null,
                    sellerId : null,
                    sum : null,
                    intro : null
                },
                    this.dialogVisible=true;
                this.isReadonly=false;
            },
            /*删除*/
            handleDelete(row){
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get('/contract/delete', {
                        params: {
                            id: row.id
                        }
                    }).then((response) => {
                        if (response.data.success) {
                            this.$message({
                                type: 'success',
                                message: response.data.msg
                            });
                        } else {
                            this.$message({
                                type: 'error',
                                message: response.data.msg
                            });
                        }
                        this.loadData();
                    })
                })
            },/*修改&添加*/
            save(){
                axios.post('/contract/save', this.contracts).then((response)=>{
                    if(response.data.success){
                        this.$message({
                            type: 'success',
                            message: response.data.msg
                        });
                    }else {
                        this.$message({
                            type: 'error',
                            message: response.data.msg
                        });
                    }
                    this.loadData();
                    this.dialogVisible = false;

                })


            },
            //输入验证
            reset(){

            },
            /*修改*/
            handleEdit(row){
                axios.get('/contract/findOne',{
                    params: {
                        id: row.id
                    }
                }).then((response)=>{
                    this.false=true;
                    //设置输入框为只读
                    this.dialogVisible = true;
                    this.contracts=response.data;
                    this.isReadonly=true;

                })
            },/*查找用户*/
            findCustomer(val){
                this.customerlist={
                    id:1,
                    name:'张',
                    age:24,
                    gender:1,
                    tel:11234567
                }
                this.height=0
            },/*用户选择双击选择*/
            onDblClickSelect(row){

            },/*合同生成*/
            document(row){
                axios.get('/order/findOne',{
                    params: {
                        id: row.id
                    }
                }).then((response)=>{
                    this.false=true;
                    this.dialogVisible_contract = true;
                    this.contractData=response.data;
                    this.isReadonly=true;
                    console.debug(this.contractData)

                })

            },/*生成合同*/
            createContract(){
                axios.post('/contract/save',this.contractData).then((response)=>{
                    console.debug(response)
                })
            },
            /*取消方法*/
            cancel(){},
            /*查看合同详情*/
            particulars(row){
                /*清空items数据*/
                this.dialogVisible_item=true;
                /*查看时设置合同编号*/
                this.item.contractId=row.sn;
                this.contract.sum=row.sum;
              this.loadItemData();
            },
            /*添加明细按钮方法*/
            openitem(){
               this.item={
                    /*合同编号*/
                    contractId:this.item.contractId,
                        /*付款金额*/
                        money:null,
                        /*付款时间*/
                        payTime:null,
                        /*是否付款*/
                        isPayment:null
                }
                this.dialogVisible_additem=true;
            },
            addItem(){
            axios.post('/contractitem/save',this.item).then(
                (response)=>{
                    if (response.data.success) {
                        this.$message({
                            type: 'success',
                            message: response.data.msg
                        });
                    } else {
                        this.$message({
                            type: 'error',
                            message: response.data.msg
                        });
                    }/*关闭添加明细窗口*/
                    this.dialogVisible_additem=false;
                    this.loadItemData();
                })

            },
            /*加载当前合同明细数据*/
            loadItemData(){
                axios.get('/contractitem/findbycid',{
                    params: {
                        id: this.item.contractId
                    }
                }).then((response)=>{
                    this.items=response.data;
                })
            },
            /*查询*/
            seach(){
                this.loadData();
            },/*金额输入框改变事件*/
            changemoney(row){
                this.item.scale= row / this.contract.sum * 100;
            },/*占比输入框改变事件*/
            changescale(row){
                this.item.money= this.contract.sum*row/100;
            },/*确认收款*/
            pay(row){
                axios.get('/contractitem/update',{
                    params: {
                        id: row.id
                    }
                }).then((response) => {
                    if (response.data.success) {
                        this.$message({
                            type: 'success',
                            message: response.data.msg
                        });
                    } else {
                        this.$message({
                            type: 'error',
                            message: response.data.msg
                        });
                    }
                    this.loadItemData();
                })
                this.dialogVisible_item=false;
                this.loadItemData();
            }
        },
        mounted() {
            this.loadData();
        }
    })
</script>
</body>
</html>
