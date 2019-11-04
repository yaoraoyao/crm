
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>售后</title>
    <jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
    <style type="text/css">
        .el-col-offset-2 {
            margin-left: 210px;
        }
        .el-col-22 {
            width: 100%;
        }

    </style>
</head>
<body>
<div id="app">
    <el-row style="margin-top:10px">
        <el-col :span="22" :offset="2">
            姓名:<el-input v-model="name" style="width: 100px" placeholder="请输入客户名"></el-input>
            时间范围查找 <el-date-picker  v-model="beginTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                                    value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            -<el-date-picker  v-model="endTime"  type="date"  placeholder="选择日期" style="width: 180px" format="yyyy-MM-dd"
                              value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            <el-button size="medium" @click="seach" round type="primary">搜索</el-button>
            <el-table :data="contracts" style="width: 100%">
                <el-table-column prop="sn" label="保修单号" width="250"></el-table-column>
                <el-table-column prop="customer.name" label="客户姓名" width="180"></el-table-column>
                <el-table-column prop="expireTime" label="到期时间" width="180"></el-table-column>
                <el-table-column prop="name" label="操作" width="200">
                    <template slot-scope="scope">
                        <el-button size="mini" type="primary"   @click="particulars(scope.row)" >详情</el-button>
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
                        :visible.sync="dialogVisible_item"
                        width="80%">
                    <el-button size="medium" @click="openitem" round type="primary">添加</el-button>
                    <%--合同详情信息--%>
                    <el-table :span="18" :offset="3" :data="items" style="width: 100%">

                        <el-table-column prop="sn" label="保修单号" width="250"></el-table-column>
                        <el-table-column prop="repairTime" label="保修日期" width="180"></el-table-column>
                        <el-table-column prop="content" label="原因" width="180"></el-table-column>
                        <el-table-column prop="isSolve" label="是否解决" width="180">
                            <template slot-scope="scope">
                                <span v-if="scope.row.isSolve==true">
                                    已解决
                                </span>
                                <span v-if="scope.row.isSolve==false">
                                        <el-button size="medium" @click="pay(scope.row)" round type="primary">待解决</el-button>
                                    </span>
                            </template>
                        </el-table-column>
                    </el-table>
                </el-dialog>
            </template>
            <%--明细添加窗口--%>
            <template>
                <el-dialog
                        title="添加明细"
                        :visible.sync="dialogVisible_additem"
                        width="30%">
                            <span>
                            <el-form  :model="item" label-width="90px">
                                <el-form-item label="保修编号：" >
                                <el-input v-model="item.sn" readonly="true"></el-input>
                              </el-form-item>

                                <el-form-item label="原因：" >
                                <el-input v-model="item.content"></el-input>
                                </el-form-item>
                                <el-form-item label="保修时间：" >
                                   <div class="block" >
                                    <el-date-picker
                                            v-model="item.repairTime"
                                            type="date"
                                            placeholder="选择日期"
                                            value-format="yyyy-MM-dd HH:mm:ss"
                                            style="width: 180px"
                                    >
                                    </el-date-picker>
                                  </div>
                                </el-form-item>
                                <el-form-item label="是否解决：" >
                                    <el-radio v-model="item.isSolve" label="true">是</el-radio>
                                     <el-radio v-model="item.isSolve" label="false">否</el-radio>
                              </el-form-item>
                              <el-form-item>
                                <el-button type="primary" @click="addItem">添加</el-button>
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
    new Vue({
        el:"#app",
        data:{
            title:"添加订单",
            contracts:[],
            total:100,
            pageNum:1,
            pageSize:10,
            contract: {
                id:null,
                sn:null,
                customer:null,
                expireTime:null,
                tenantId:null
            },
            dialogVisible:false/*save窗口*/,
            /*输入框是否为只读模式*/
            dialogVisible_item:false,
            /*明细添加窗口*/
            dialogVisible_additem:false,
            isReadonly:false,
            /*当前查看合同选中行数据*/
            row:null,
            /*查询数据*/
            name:null,
            beginTime:null,
            endTime:null,
            /*合同详情数据*/
            items:[],
            item:{
                id:null,
                sn:null,
                repairTime:null,
                content:null,
                isSolve:null
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
                axios.get("/aftersale/page", {
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
                this.contracts=  {
                    id:null,
                    sn:null,
                    customer:null,
                    expireTime:null,
                    tenantId:null
                },
                    this.dialogVisible=true;
                this.isReadonly=false;
            },
            /*删除*/
            handleDelete(row){
                this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
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
                axios.post('/aftersaleitem/save', this.contracts).then((response)=>{
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
            },
            /*取消方法*/
            cancel(){},
            /*查看详情*/
            particulars(row){
                /*清空items数据*/
                this.dialogVisible_item=true;
                /*查看时设置合同编号*/
                this.contract=row;
                this.loadItemData();
            },
            /*添加明细按钮方法*/
            openitem(){
                this.item={
                    id:null,
                    sn:this.contract.sn,
                    content:null,
                    isSolve:null
                }
                this.dialogVisible_additem=true;
            },
            addItem(){
                axios.post('/aftersaleitem/save',this.item).then(
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
                axios.get('/aftersaleitem/findAllBySn',{
                    params: {
                        sn: this.contract.sn
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
                axios.post('/aftersaleitem/save',row).then((response) => {
                    if (response.data.success) {
                        this.$message({
                            type: 'success',
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
