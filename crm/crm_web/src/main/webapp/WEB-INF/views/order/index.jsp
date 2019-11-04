<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
    <style type="text/css">
        .el-col {
            width: 1300px;
        }
    </style>
</head>
<body>
<div id="app">
    <el-row style="margin-top:10px">
        <el-col :span="21" :offset="2">
            <el-button size="medium" @click="open()" round type="primary">添加</el-button>
            用户名:<el-input v-model="name" style="width: 100px" placeholder="请输入客户名"></el-input>
           时间范围查找 <el-date-picker  v-model="beginTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                                   value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
           -<el-date-picker  v-model="endTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd "
                             value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            <el-button size="medium" @click="seach" round type="primary">搜索</el-button>
            <el-table :span="18" :offset="3" :data="orders" style="width: 100%">
                <el-table-column prop="sn" label="定金单号" width="220px"></el-table-column>
                <el-table-column prop="customer.name" label="客户姓名" width="100px"></el-table-column>
                <el-table-column prop="signTime" label="签订时间" width="120px"></el-table-column>
                <el-table-column prop="seller.username" label="销售人员" width="100px"></el-table-column>
                <el-table-column prop="sum" label="金额" width="100px"></el-table-column>
                <el-table-column prop="intro" label="描述" width="180"></el-table-column>
                <el-table-column prop="name" label="操作" width="300">
                    <template slot-scope="scope">
                        <el-button size="mini" type="primary" icon="el-icon-edit"  @click="handleEdit(scope.row)" ></el-button>
                        <el-button size="mini" type="danger" icon="el-icon-delete"  @click="handleDelete(scope.row)"></el-button>
                        <el-button size="mini" type="Warning" icon="el-icon-document"  @click="document(scope.row)">生成合同</el-button>
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
                        :title="title"
                        :visible.sync="dialogVisible"
                        width="30%">
                          <span>
                            <el-form  :model="order" label-width="90px" :height="hit">
                                <el-form-item label="id：" style="display: none;">
                                    <el-input v-model="order.id" style="display: none;"></el-input>
                              </el-form-item>
                               <el-form-item label="客户姓名：">
                                <el-input v-model="order.customerName" :readonly="isReadonly" @change="findCustomer"></el-input>

                              </el-form-item>
                                 <template>
                             <el-table
                                     :data="customer"
                                     style="width: 100%"
                                     :height="hit"
                                     show-header="false"
                                     @cell-click="choiceCustomer"
                                    >
                                 <el-table-column   prop="name"  label="姓名" width="100px"></el-table-column>
                                 <el-table-column  prop="gender" label="性别"  width="80px">
                                     <template slot-scope="scope">
                                        <span v-if="scope.row.gender==1">
                                            男
                                        </span>
                                        <span v-if="scope.row.gender==0">
                                             女
                                         </span>
                                        </template>
                                 </el-table-column>
                                    <el-table-column  prop="tel" label="电话"> </el-table-column>
                                    </el-table>
                                  </template>
                                <el-form-item label="金额：" >
                                <el-input v-model="order.sum" :readonly="isReadonly" ></el-input>
                              </el-form-item>
                                <el-form-item label="签订时间：" >
                                   <div class="block" >
                                    <el-date-picker
                                            v-model="order.signTime"
                                            type="date"
                                            placeholder="选择日期"
                                            format="yyyy-MM-dd hh:MM:ss"
                                            value-format="yyyy-MM-dd hh:MM:ss"
                                            style="width: 180px"
                                           >
                                    </el-date-picker>
                                  </div>
                                </el-form-item>

                                <el-form-item label="描述：" >
                                <el-input v-model="order.intro"></el-input>
                              </el-form-item>

                              <el-form-item>
                                <el-button type="primary" @click="save">保存</el-button>
                                <el-button type="primary" @click="reset">重置</el-button>
                              </el-form-item>
                            </el-form>
                          </span>
                </el-dialog>
            </template>
                <%--合同生成--%>
            <template>
                <el-dialog
                        title="合同生成"
                        :visible.sync="dialogVisible_contract"
                        width="30%">
                          <span>
                            <el-form  :model="contractData" label-width="120px">
                                <el-form-item label="id：" style="display: none;">
                                    <el-input v-model="contractData.id" style="display: none;"></el-input>
                              </el-form-item>
                               <el-form-item label="客户姓名：">
                                <el-input v-model="contractData.customer.name" readonly="true" @change="findCustomer"></el-input>
                              </el-form-item>

                                <el-form-item label="合同金额：" >
                                <el-input v-model="contractData.sum" ></el-input>
                              </el-form-item>

                                <el-form-item label="签订时间：" >
                                   <div class="block" >
                                    <el-date-picker
                                            v-model="contractData.signTime"
                                            type="date"
                                            placeholder="选择日期"
                                            value-format="yyyy-MM-dd"
                                            style="width: 180px"
                                    >
                                    </el-date-picker>
                                  </div>
                                </el-form-item>
                                <el-form-item label="描述：" >
                                <el-input v-model="contractData.intro"></el-input>
                              </el-form-item>

                              <el-form-item>
                                <el-button type="primary" @click="createContract">生成合同</el-button>
                                <el-button type="primary" @click="cancel">取消</el-button>
                              </el-form-item>
                            </el-form>
                          </span>
                </el-dialog>
            </template>
        </el-col>
    </el-row>
</div>
<script >
   var app= new Vue({
        el:"#app",
        data:{
            hit:0,
            title:"添加订单",
            orders:[],
            total:100,
            pageNum:1,
            pageSize:10,
            order: {
                id : null,
                sn :null,
                customerId : null,
                customerName:null,
                signTime :null,
                sellerId : null,
                sum : null,
                intro : null
            },
            dialogVisible:false/*save窗口*/,
            dialogVisible_contract:false,/*合同窗口打开*/
            /*输入框是否为只读模式*/
            isReadonly:false,

            /*客户信息*/
            customer:[],
            height:0,
            contractData:{
                customer : {},
                signTime :null,
                sellerId : null,
                sum : null,
                intro : null
            },
            /*查询数据*/
            name:null,
            beginTime:null,
            endTime:null

        },
        methods:{
            loadData() {
                var param = {}
                param.pageNum = this.pageNum
                param.pageSize = this.pageSize
                param.name=this.name;
                param.beginTime=this.beginTime
                param.endTime=this.endTime
                axios.get("/order/page", {
                    params: param
                }).then((result) => {
                    this.total = result.data.total;
                    this.orders = result.data.rows;
                })
            },/*分页*/
            pageSelect(pageNum){
                this.pageNum=pageNum;
                this.loadData();

            },/*打开窗口*/
            open(){
                /*数据清除*/
                this.order= {
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
                    axios.get('/order/delete', {
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
              var order=  new URLSearchParams();
              order.append('id',this.order.id);
              order.append('sn',this.order.sn);
              order.append('customerId',this.order.customerId);
              order.append('signTime',this.order.signTime);
              order.append('sellerId',this.order.sellerId);
              order.append('sum',this.order.sum);
              order.append('intro',this.order.intro);
                axios.post('/order/save', this.order).then((response)=>{
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
            //重置
            reset(){
               this.contractData={
                    customer : {},
                    signTime :null,
                        sellerId : null,
                        sum : null,
                        intro : null
                }

            },
            /*修改*/
            handleEdit(row){
                axios.get('/order/findOne',{
                    params: {
                        id: row.id
                    }
                }).then((response)=>{
                    this.false=true;
                    //设置输入框为只读
                    this.dialogVisible = true;
                    this.order=response.data;
                    this.order.customerName=response.data.customer.name;
                    this.isReadonly=true;

                })
            },/*查找用户*/
            findCustomer(row){
                axios.get('/order/findCustomerByTelOrName',{
                    params: {
                        name:row
                    }
                }).then((response)=>{
                   if(response.data.length>0){
                       this.customer=response.data;
                       this.hit=response.data.length*50+50;
                   }
                   if(response.data.length==0)
                   {
                       this.hit=0;
                       alert("亲，没有你要的数据哦")
                   }
                })
            },/*用户选择双击选择*/
            choiceCustomer(row, column, cell, event){
                this.order.customerId=row.id;
                this.order.customerName=row.name;
                this.hit=0;
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
                    this.dialogVisible_contract=false;
                    this.loadData();
                })
            },
            /*取消方法*/
            cancel(){},
            /*搜索方法*/
            seach(){
                this.loadData();
            }

        },
        mounted() {
            this.loadData();
        }
    })
</script>
</body>
</html>
