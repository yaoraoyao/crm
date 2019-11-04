<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<!--导入Bootstrap的核心样式文件-->
		<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css" />
		<!--导入jQuery文件-->
		<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
		<!--
			导入Bootstrap的核心js文件
			注意：
				1)Bootstrap的核心js文件是依赖于jQuery文件，所以必须先导入jQuery文件
				2)Bootstrap要求jQuery文件版本不低于1.9
		-->
		<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
		<style type="text/css">
			.list-group-item>.list-group {
				display: none;
			}
			
			.list-group-item>span {
				cursor: pointer;
				display: block;
				height: 30px;
				line-height: 30px;
			}
			
			.list-group-item>span:hover {
				background-color: #F5F2F0;
			}
			/*Tab标签页的关闭按钮的样式*/
			.close{position: relative;top: -42px;left: -5px;color:red;}
		</style>
		<script type="text/javascript">
			$(function() {
				//给一级菜单元素绑定点击事件【jQuery的写法】
				$(".list-group-item>span").click(function() {
					if($(this).attr("expand") == "0") {
						//点击之后将span下面的ul展示出来
						$(this).next(".list-group").show();
						$(this).attr("expand", "1");
					} else {
						//点击之后将span下面的ul收缩
						$(this).next(".list-group").hide();
						$(this).attr("expand", "0");
					}
				});
				
				//给Tab标签页的关闭按钮绑定点击事件
				$(document).on("click",".close",function(){
					var id = $(this).prev("a").attr("href");
					//删除li元素 是span的父级元素
					$(this).parent().remove();
					//删除下面的对应的小div
					$(id).remove();
					
					//将原来的Tab标签页取消选中状态[去掉class="active"即可]
					$("#nav-tabs>li").removeClass("active");		//jQuery会自动循环
					$("#tab-content>div").removeClass("active");
					//删除之后选中最后一个Tab标签页
					var i = $("#nav-tabs>li").length;
					$("#nav-tabs>li").eq(i-1).addClass("active");
					$("#tab-content>div").eq(i-1).addClass("active");
				});
			});
			/**
			 * 添加Tab标签页
			 * 	注意：Bootstrap中所有同一小组内部的元素如果是处于选中状态就添加class="active"属性
			 */
			var tabNames = ["Home"]; //已有哪些Tab标签页
			function addTab(name, url){
				//将原来的Tab标签页取消选中状态[去掉class="active"即可]
				$("#nav-tabs>li").removeClass("active");		//jQuery会自动循环
				$("#tab-content>div").removeClass("active");
				if(tabNames.join(",").indexOf(name) == -1){
					tabNames.push(name);
					var i = $("#nav-tabs>li").length;
					$("#nav-tabs").append('<li class="active" name="'+name+'">'+
								'<a href="#tab'+i+'" data-toggle="tab">'+name+'</a>'+
								'<span class="close">&times;</span>'+
							'</li>');
					$("#tab-content").append('<div class="tab-pane active" id="tab'+i+'">'+
						'<iframe src="'+url+'" width="100%" height="600px" frameborder="no" scrolling="auto"></iframe></div>');
				}else{
					//选中它并且刷新它
					$("#nav-tabs>li[name="+name+"]").addClass("active");
					var id = $("#nav-tabs>li[name="+name+"]").find("a").attr("href");
					$(id).addClass("active");
					//刷新页面内容【只需要将iframe的src属性重新赋值即可】
					$(id).find("iframe").attr("src", url+"?"+Math.random());
				}
			}
		</script>
	</head>

	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#aaa" aria-expanded="false">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				    </button>
					<a class="navbar-brand" href="#">Brand</a>
					<b>XXX公司企业官网内容管理系统</b>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="aaa">
					<ul class="nav navbar-nav">
						<li class="active">
							<a href="#">首页 <span class="sr-only">(current)</span></a>
						</li>
						<li>
							<a href="#">关于我们</a>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">产品列表 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li>
									<a href="#">JAVA</a>
								</li>
								<li>
									<a href="#">H5</a>
								</li>
								<li>
									<a href="#">Python</a>
								</li>
								<li role="separator" class="divider"></li>
								<li>
									<a href="#">全栈</a>
								</li>
							</ul>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#">欢迎你，张三丰</a>
						</li>
						<li>
							<a href="#" class="btn btn-default btn-sm">退出</a>
						</li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

		<div class="container-fluid" style="margin-top: 50px;">
			<div class="row">
				<div class="col-md-2" style="height: 663px;background-color: #999999;">
					<ul class="list-group">
						<li class="list-group-item">
							<span expand="0">员工管理1</span>
							<ul class="list-group">
								<li class="list-group-item">
									<a href="javascript:addTab('用户管理','/user/index.do');">用户管理</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:addTab('部门管理','https://www.jd.com');">部门管理</a>
								</li>
							</ul>
						</li>
						<li class="list-group-item">
							<span expand="0">员工管理2</span>
							<ul class="list-group">
								<li class="list-group-item">
									<a href="javascript:addTab('员工管理','https://www.taobao.com');">员工管理</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:addTab('员工管理','https://www.163.com');">部门管理</a>
								</li>
							</ul>
						</li>
						<li class="list-group-item">
							<span expand="0">员工管理3</span>
							<ul class="list-group">
								<li class="list-group-item">
									<a href="javascript:addTab('员工管理','https://lol.qq.com');">员工管理</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:addTab('员工管理','https://www.iqiyi.com');">部门管理</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="col-md-10" style="height: 663px;background-color: #C1E2B3;">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" id="nav-tabs">
						<li role="presentation" class="active">
							<a href="#home" data-toggle="tab">Home</a>
						</li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content" id="tab-content">
						<div class="tab-pane active" id="home">欢迎你</div>
					</div>
					
				</div>
			</div>
		</div>
	</body>

</html>