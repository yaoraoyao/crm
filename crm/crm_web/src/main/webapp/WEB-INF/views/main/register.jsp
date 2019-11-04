<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <<%@ include file="/WEB-INF/views/common.jsp" %>
    <%--百度地图相关--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";font-size:14px;}
        #l-map{height:300px;width:100%;}
        #r-result{width:100%;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=nbOoF1wAGtwE1z9jm5fkqwLUf7ECyZeI"></script>
    <title>关键字输入提示词条</title>
    <style type="text/css">
        html{height:100%}
        body{height:100%;margin:0px;padding:0px}
        #container{height:100%}
        .tangram-suggestion-main {
            z-index: 999999;
        }
    </style>
    <%--end--%>
    <style scoped>
        .regform {
            margin: 20px auto;
            width: 330px;
            background: #fff;
            box-shadow: 0 0 10px #B4BCCC;
            padding: 30px 30px 0 30px;
            border-radius: 25px;
        }
        .submitBtn {
            width: 65%;
        }
        .to {
            color: #FA5555;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div id="app">
        <el-form
                :model="ReginForm"
                ref="ReginForm"
                :rules="rule"
                class="regform"
                label-width="0">

            <h3>用户注册</h3>

            <el-form-item prop="companyName">
                <el-input
                        type="text"
                        v-model="ReginForm.companyName"
                        placeholder="公司注册名称">
                </el-input>
            </el-form-item>

            <el-form-item  prop="companyTel" required>
                <el-input
                        type="text"
                        v-model.number="ReginForm.companyTel"
                        autocomplete="off"
                        placeholder="手机电话">
                </el-input>
            </el-form-item>

            <el-form-item prop="companyNum">
                <el-input
                        type="text"
                        v-model.number="ReginForm.companyNum"
                        placeholder="座机电话">
                </el-input>
            </el-form-item>
            <el-form-item prop="email">
                <el-input
                        type="email"
                        v-model="ReginForm.email"
                        placeholder="邮件">
                </el-input>
            </el-form-item>
            <el-form-item prop="sysName">
                <el-input
                        type="text"
                        v-model="ReginForm.sysName"
                        placeholder="公司账号">
                </el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input
                        type="password"
                        v-model="ReginForm.password"
                        placeholder="密码">
                </el-input>
            </el-form-item>
            <el-form-item >
            <el-input
                    type="text"
                    v-model="ReginForm.address"
                    placeholder="地址" @focus="openMap">
            </el-input>
        </el-form-item>
        <el-form-item >
                <el-button
                        type="success"
                        class="submitBtn"
                        round
                        @click="submit"
                        :loading="logining">
                    注册
                </el-button>
                <el-button
                        type="primary"
                        class="resetBtn"
                        round
                        @click="reset">
                    重置
                </el-button>
                <hr>
                <p>已经有账号，马上去<span class="to" @click="login()">登录</span></p>
            </el-form-item>
        </el-form>
    <%--百度地图--%>
    <el-dialog
            :visible.sync="dialogVisible_contract"
            width="80%" >
        <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:500px;height:auto; display:none;"></div>
        <div id="r-result">请输入:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /><el-button size="mini" round @click="mapYes">确定</el-button></div>

        <div id="container" style="height: 300px"> </div>

    </el-dialog>

</div>
<script>
  var app=  new Vue({
         el:"#app",
        data:{
            /*百度地图窗口*/
          dialogVisible_contract:false,
          ReginForm: {
                  companyName:'',
                  password:'',
                  companyTel:'',
                  companyNum:'',
                  email:'',
                  sysName:'',
                  /**
                   * 公司地址：省市区(县)街道(大厦)门号，一个真实的具体的地址，用于百度地图
                   */
                address:'',
                  /**
                   * 公司坐标
                   * 根据输入的地址，系统自动生成
                   */
                coordinate:''
          },
            options: [],
            logining: false,
            rule: {
                companyName: [
                    {
                        required: true,
                        max: 14,
                        min: 7,
                        message: '用户名是必须的，长度为7-14位',
                        trigger: 'blur'
                    }
                ],
                password: [
                    {
                        required: true,
                        message: '密码是必须的！',
                        trigger: 'blur'
                    }
                ],
                companyTel: [
                    {
                        required: true,
                       validator:  (rule, value, callback)=> {
                        if (value === '') {
                              return callback(new Error('电话号码是必须的'))
                          } else if (!Number.isInteger(value)) {
                              return callback(new Error('电话号码必须是数字'))
                          } else if (value.toString().length !== 11) {
                              return callback(new Error('电话号码必须是11位数字'))
                          } else {
                              callback()
                          }
                          },
                        trigger: 'blur'
                    }
                ],
                companyNum:[
                    {
                        required: true,
                        validator:  (rule, value, callback)=> {
                            if (value === '') {
                                return callback(new Error('座机号码号码是必须的'))
                            } else if (!Number.isInteger(value)) {
                                return callback(new Error('电话号码必须是数字'))
                            } else if (value.toString().length !== 8) {
                                return callback(new Error('电话号码必须是11位数字'))
                            } else {
                                callback()
                            }
                        },
                        trigger: 'blur'
                    }
                ],
                email: [
                    {
                        required: true,
                        type: 'email',
                        message: '请输入正确的电子邮件格式(xxx@xxx.com)',
                        trigger: 'blur'
                    }
                ],/*公司账号*/
                sysName:[
                    {
                        required: true,
                        validator: (rule, value, callback)=> {
                            axios.get('/userSole', {params: {
                                username: value
                            }
                            }).then((resp)=>{
                                if(resp.data.success){
                                    callback()
                                }else {
                                    return callback(new Error('该用户存在'))
                                }
                            })
                        },
                        trigger: 'blur'
                    }
                ],
                name: [
                    {
                        required: true,
                        max: 12,
                        min: 2,
                        message: '昵称是必须的，最好是汉字',
                        trigger: 'blur'
                    }
                ]
            }
        },
      methods: {
          // 提交
          submit () {
              this.$refs['ReginForm'].validate((value) => {
                   if(value){
                       axios.post('/register',this.ReginForm).then((resp)=>{
                           if(resp.data.success){
                               location='/login'
                           }else {
                               this.$message({
                                   type: 'error',
                                   message: '登录失败！'
                               });
                           }

                       })
                   }else{
                       this.$message({
                           type: 'error',
                           message: '请按要求认真填写信息'
                       });
                   }
              })

          },
          reset () {
             this. ReginForm= {
                  companyName:'',
                      password:'',
                      companyTel:'',
                      companyNum:'',
                      email:'',
                      sysName:'',
                      address:'',
                      coordinate:''
              }

          },
          openMap(){
              app.ReginForm.coordinate=''
              this.dialogVisible_contract=true
              this.$nextTick( () =>{
                  var map = new BMap.Map("container");
                  map.centerAndZoom("北京",12);
                  // 初始化地图,设置城市和地图级别。
                  function G(id) {
                      return document.getElementById(id);
                  }
                  var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
                      {"input" : "suggestId"
                          ,"location" : map
                      });
                  ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
                      var str = "";
                      var _value = e.fromitem.value;
                      var value = "";
                      if (e.fromitem.index > -1) {
                          value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
                      }
                      str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

                      value = "";
                      if (e.toitem.index > -1) {
                          _value = e.toitem.value;

                          value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;

                      }
                      str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
                      G("searchResultPanel").innerHTML = str;
                  });

                  var myValue;
                  ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
                      var _value = e.item.value;
                      myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
                      app.ReginForm.address=myValue;/*给地址赋值*/
                      G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
                      var myGeo = new BMap.Geocoder();
                      myGeo.getPoint(app.ReginForm.address, function(point){
                          console.debug(point)
                          app.ReginForm.coordinate=point.lat+","+point.lng;
                          console.debug(app.ReginForm.coordinate)
                          if (point) {
                              map.centerAndZoom(point, 16);
                              map.addOverlay(new BMap.Marker(point));
                          }else{
                              alert("您选择地址没有解析到结果!");
                          }
                      }, "北京市");
                      setPlace();
                  });/*将地址解析为坐标*/


                  function setPlace(){
                      map.clearOverlays();    //清除地图上所有覆盖物
                      function myFun(){
                          var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                          map.centerAndZoom(pp, 18);
                          map.addOverlay(new BMap.Marker(pp));    //添加标注
                      }
                      var local = new BMap.LocalSearch(map, { //智能搜索
                          onSearchComplete: myFun
                      });
                      local.search(myValue);
                  }
              })

          },
          mapYes(){
              this.dialogVisible_contract=false
          }
          ,login(){
              window.location='/login'
      }
      }
    })
</script>



</body>
</html>
