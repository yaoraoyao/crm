<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>客户移交记录</title>
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
            <el-button type="primary" icon="el-icon-search" size="small" @click="selectCustomerTransfer">搜索</el-button>
        </el-col>
    </el-row>
    <el-row style="margin-top:10px">
        <el-col :span="22" :offset="1">
            <%--数据展示--%>
            <el-table :data="customerTransfers" stripe style="width: 100%">
                <el-table-column prop="customer" label="客户">
                    <template slot-scope="scope">
                        <el-popover trigger="hover" placement="top">
                            <p>电话: {{ scope.row.customer.tel }}</p>
                            <div slot="reference" class="name-wrapper">
                                <el-tag size="medium">{{ scope.row.customer.name }}</el-tag>
                            </div>
                        </el-popover>
                    </template>
                </el-table-column>
                <el-table-column prop="transUser.realname" label="移交人员"></el-table-column>
                <el-table-column prop="transTime" label="移交时间"></el-table-column>
                <el-table-column prop="oldSeller.realname" label="老市场专员"></el-table-column>
                <el-table-column prop="newSeller.realname" label="新市场专员"></el-table-column>
                <el-table-column prop="transReason" label="移交原因"></el-table-column>
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
            customerTransfers: [],
            total: null,
            pageNum: 1,
            pageSize: 10,
            options: [{
                value: 'customerName',
                label: '客户'
            }, {
                value: 'traceUserName',
                label: '移交人员'
            }],
            beginDate: null,
            endDate: null,
            value: '',
            input: ''
        },
        methods: {
            /*高级查询*/
            selectCustomerTransfer(){
                this.pageNum = 1;
                this.loadCustomerTransfer();
            },
            page(currentPage){
                this.pageNum = currentPage;
                this.loadCustomerTransfer();
            },
            /*加载所有跟进数据*/
            loadCustomerTransfer(){
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
                axios.post("/customerTransfer/page",param).then((resp)=>{
                    this.total = resp.data.total
                    this.customerTransfers = resp.data.rows
                })
            },
        },
        mounted(){
            this.loadCustomerTransfer();
        }
    })
</script>
</body>
</html>
