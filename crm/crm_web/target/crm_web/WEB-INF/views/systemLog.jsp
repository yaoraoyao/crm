<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
    <style type="text/css">
        .el-pagination {
            margin-left: -175px;
        }

    </style>
</head>
<body>
<div id="app">
    <template>
        <el-row>
            <el-col :span="8" :offset="8">
                <el-input
                        placeholder="请输入搜索内容"
                        v-model="str"
                        clearable>
                    <el-button size="mini" slot="append" @click="handleSearch()" round type="primary">搜索</el-button>
                </el-input>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="11" :offset="12" v-if="systemLogs.length == 0" style="margin-top: 50px">{{render}}</el-col>
            <el-col v-else :span="23" :offset="1">
                <el-table  :data="systemLogs" size="mini" :fit="fit">
                    <el-table-column type="index" label="#"></el-table-column>
                    <el-table-column prop="opUser" label="操作人">
                        <template slot-scope="scope">
                            <span v-html="scope.row.opUser"></span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="opTimeStr" label="操作时间">
                        <template slot-scope="scope">
                            <span v-html="scope.row.opTimeStr"></span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="opIp" label="操作IP">
                        <template slot-scope="scope">
                            <span v-html="scope.row.opIp"></span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="function" label="操作内容">
                        <template slot-scope="scope">
                            <span v-html="scope.row.function"></span>
                        </template>
                    </el-table-column>
                    <%--<el-table-column prop="params" label="参数">--%>
                        <%--<template slot-scope="scope">--%>
                            <%--<span v-html="scope.row.params.substring(0,20)"></span>--%>
                        <%--</template>--%>
                    <%--</el-table-column>--%>
                    <el-table-column prop="name" label="详情">
                        <template slot-scope="scope">
                            <el-button size="mini" type="info" icon="el-icon-search" @click="handleEdit(scope.$index)"
                            >查看参数
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-row>
    </template>
    <template>
        <el-col v-if="systemLogs.length > 0" :span="6" :offset="18">
            <el-pagination
                    background
                    size="mini"
                    layout="prev, pager, next"
                    :total="total"
                    :page-size="pageSize"
                    :current-page="pageNum"
                    @current-change="pageSelect">
            </el-pagination>
        </el-col>
    </template>
    <template>
        <el-dialog
                :title="title"
                :visible.sync="dialogVisible"
                width="35%">
				  <span>
				  	<el-form :model="systemLog" size="mini"
                             :label-width="width" label-position="top">
					  <%--<el-form-item label="操作人：">--%>
					    <%--<el-input v-model="systemLog.opUser" :readonly="true" :style="style"></el-input>--%>
					  <%--</el-form-item>--%>
					  <%--<el-form-item label="操作时间：">--%>
					    <%--<el-input v-model="systemLog.opTimeStr" :readonly="true" :style="style"></el-input>--%>
					  <%--</el-form-item>--%>
                        <%--<el-form-item label="操作IP：">--%>
					    <%--<el-input v-model="systemLog.opIp" :readonly="true" :style="style"></el-input>--%>
					  <%--</el-form-item>--%>
                        <%--<el-form-item label="操作：">--%>
					    <%--<el-input v-model="systemLog.function" :readonly="true" :style="style"></el-input>--%>
					  <%--</el-form-item>--%>
                      <el-form-item>
					    <el-input v-model="systemLog.params" type="textarea" :readonly="true"></el-input>
					  </el-form-item>
					</el-form>
				  </span>
        </el-dialog>
    </template>

</div>

<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data: {
            systemLogs: [],
            dialogVisible: false,
            title: "参数",
            pageNum: 1,
            pageSize: 10,
            str:null,
            total: 0,
            fit: true,
            width: "0px",
            style: {
                width: "0px"
            },
            systemLog: {
                id: null,
                opUser: null,
                opTimeStr: null,
                opIp: null,
                function: null,
                params: null
            },
            render:"请搜索"
        },
        methods: {
            handleSearch() {
                this.pageNum = 1;
                this.loadData();
            },
            handleEdit(index) {
                if (index >= 0 && index < this.systemLogs.length) {
                    for (var key in this.systemLogs[index]) {
                        this.systemLog[key] = this.systemLogs[index][key];
                    }
                }
                this.dialogVisible = true;
            },
            loadData() {
                var param = {}
                param.pageNum = this.pageNum;
                param.pageSize = this.pageSize;
                param.str = this.str;

                if (this.str) {
                    axios.post("/systemLog/list", param).then((result) => {
                        this.total = result.data.result.total;
                        this.systemLogs = result.data.result.rows;
                        if(this.systemLogs && this.systemLogs.length == 0 ){
                            this.render = "没有查询到数据";
                        }
                    }).catch(function (error) {
                        this.render = "没有查询到数据";
                    });
                }else {

                }
            },
            pageSelect(pageNum) {
                this.pageNum = pageNum;
                this.loadData();
            }
        },
        mounted() {
            this.width = document.body.clientWidth * 0.10 + "px";
            this.style.width = document.body.clientWidth * 0.20 + "px";
        }
    })

</script>
</body>
</html>
