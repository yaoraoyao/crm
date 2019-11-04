<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>BOSS客户管理系统</title>
    <%@include file="/WEB-INF/views/common.jsp" %>
    <style type="text/css">
        .is-selected {
            color: #1989FA;
        }

        .el-header {
            line-height: 60px;
            background-color: #687179;
            color: #ced0d2;
            opacity: 0.6;
        }

        .el-aside {
            color: #333;
            opacity: 0.6;
        }

        .el-select .el-input {
            width: 130px;
        }

        .input-with-select .el-input-group__prepend {
            background-color: #fff;
        }

        .el-tree-node__label {
            line-height: 26px;
            color: #FFFFFF;

        }

        .el-tree-node__content {
            height: 50px;
            text-align: center;
            background-color: rgb(84, 92, 100);
        }

        .el-tree-node:focus > .el-tree-node__content {
            background-color: #303133;
        }

        .el-tree-node__content:hover {
            background-color: #303133;
        }

        .el-header > span:nth-child(3) {
            margin-left: -20px;
        }

        .index {
            filter: alpha(Opacity=85);
            -moz-opacity: 0.85;
            opacity: 0.85;
        }

        .el-icon-setting {
            color: #0b0101;
        }

        .el-header > span:nth-child(1) {
            /* font-size: 36px; */
            font-size: 50px;
        }

        .el-main {
            opacity: 0.85;
        }

        .el-tabs--border-card > .el-tabs__header .el-tabs__item:not(.is-disabled):hover {
            color: #141515;
        }

        .el-tabs--border-card > .el-tabs__header .el-tabs__item.is-active {
            color: #101011;
        }

    </style>
</head>
<body>

    <div class="pull-height animated"
         style="background-image:url(/exclusive/images/gallery_7.webp);background-size: 100% 100%;height: 1000px;">
        <div id="app">
            <el-container style="height: 97%; min-height:97vh; border: 1px solid #eee">
                <el-header style="height: 100px; ">
                    <span style="font-size:36px">BOSS客户管理系统</span>
                    <el-dropdown @command="handleCommand" style="margin-left: 800px;margin-top: 80px">
                        <i class="el-icon-setting" style="margin-right: 26px">操作</i>
                        <el-dropdown-menu slot="dropdown">
                            <el-dropdown-item command="logout">注销</el-dropdown-item>
                            <el-dropdown-item>修改密码</el-dropdown-item>
                        </el-dropdown-menu>
                    </el-dropdown>
                    <span>欢迎${loginUser.username}大老板登录!</span>
                </el-header>
                <%--<el-header style="text-align: right; font-size: 16px">--%>
                <%----%>
                <%--</el-header>--%>

                <el-container>
                    <%--左侧树形菜单--%>
                    <el-aside width="200px">
                        <el-tree :data="menus" :props="defaultProps" @node-click="handleNodeClick">

                        </el-tree>
                    </el-aside>
                    <%-- 右侧主页--%>
                    <el-main>
                        <el-row>
                            <el-col :span="24">
                                <el-tabs v-model="editableTabsValue" type="border-card" editable @edit="handleTabsEdit">
                                    <el-tab-pane
                                            :key="item.name"
                                            v-for="(item, index) in editableTabs"
                                            :label="item.title"
                                            :name="item.name">

                                        <el-calendar v-if="index==0" v-model="value">
                                        </el-calendar>
                                        <iframe height="90%" width="100%" style='border:none' :src='item.content'
                                                v-if="index>0" :id=item.name></iframe>
                                    </el-tab-pane>
                                </el-tabs>
                            </el-col>
                        </el-row>
                    </el-main>
                </el-container>
            </el-container>
        </div>
    </div>

<script>

    var app = new Vue({
        el: "#app",
        data() {
            return {
                value: new Date(),
                editableTabsValue: '1',
                editableTabs: [{
                    title: '首页',
                    name: '1',
                    content: ""
                }],
                tabIndex: 1,
                menus: [],
                defaultProps: {
                    children: 'children',
                    label: 'label'
                }
            };
        },
        methods: {
            handleNodeClick(data) {
                console.debug(!data.parentId)
                if (data.parentId != null) {
                    //取得当前已打开的tab页
                    let tabs = this.editableTabs;
                    let flag = true;//表示可以新打开
                    tabs.forEach((tab, index) => {
                        if (tab.title === data.label) {
                            //如果打开则选中
                            this.editableTabsValue = tab.name;
                            document.getElementById(this.editableTabsValue).contentWindow.location.reload(true);
                            flag = false;//表示已打开
                            return;
                        }
                    });
                    if (flag) {//如果没有打开则添加
                        let newTabName = ++this.tabIndex + '';
                        this.editableTabs.push({
                            title: data.label,
                            name: newTabName,
                            content: data.url
                        });
                        this.editableTabsValue = newTabName;
                    }
                }
            },
            handleTabsEdit(targetName, action) {
                if (action === 'remove') {
                    let tabs = this.editableTabs;
                    //获取当前选中的tab页
                    let activeName = this.editableTabsValue;
                    if (activeName === targetName) {
                        tabs.forEach((tab, index) => {
                            if (tab.name === targetName) {
                                //取得当前选中页的前一页
                                let previousTab = tabs[index - 1];
                                if (previousTab) {//如果是首页就不删除
                                    tabs.splice(index, 1);//删除当前页
                                    activeName = previousTab.name;//将选中项设置为前一个tab标签页
                                }
                            }
                        });
                    }
                    this.editableTabsValue = activeName;
                    //this.editableTabs = tabs.filter(tab => tab.name !== targetName);
                    this.editableTabs = tabs;
                }
            },
            //下拉菜单指令
            handleCommand(command) {
                if (command == 'logout') {
                    this.logout();
                }
            },
            logout() {
                location.href = '/logout'
            },
            loadMenus() {
                var that = this;
                axios.post('/menu/list')
                    .then(function (response) {
                        console.debug(response.data.result)
                        that.menus = response.data.result;
                    })
            }
        },
        mounted() {
            this.loadMenus();
            if (window.top != window) {
                window.top.location = "/main";
            }
        }

    })

</script>

</body>
</html>
