<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用户管理</title>
		<!--导入Bootstrap的核心样式文件-->
		<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css"/>
		<!--导入jQuery文件-->
		<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
		<!--
			导入Bootstrap的核心js文件
			注意：
				1)Bootstrap的核心js文件是依赖于jQuery文件，所以必须先导入jQuery文件
				2)Bootstrap要求jQuery文件版本不低于1.9
		-->
		<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$(function(){
				if($("#userid").val()){
					//应该弹出编辑的模态窗口
					$("#myModal2").modal("show");				
				}
			});
		</script>
	</head>
	<body>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
			<i class="glyphicon glyphicon-user"></i>&nbsp;新增
		</button>
		<table class="table table-hovered table-bordered table-striped">
			<thead>
				<tr>
					<th>编号</th>
					<th>名字</th>
					<th>密码</th>
					<th>性别</th>
					<th>年龄</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="u">
					<tr>
						<td>${u.id }</td>
						<td>${u.name }</td>
						<td>${u.pwd }</td>
						<td>${u.gender }</td>
						<td>${u.age }</td>
						<td>
							<a href="/user/findById.do?id=${u.id}" class="btn btn-info btn-xs" data-toggle="modal"><i class="glyphicon glyphicon-pencil"></i>编辑</a>
							<a href="/user/delete.do?id=${u.id}" onclick="return confirm('你确定忍心删除这行数据吗？');" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i>删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<form action="/user/add.do" method="post">
			<div class="modal fade" id="myModal" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel"><i class="glyphicon glyphicon-user"></i>&nbsp;新增用户</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<input type="text" name="name" placeholder="用户名" class="form-control" />
							</div>
							<div class="form-group">
								<input type="password" name="pwd" placeholder="密码" class="form-control" />
							</div>
							<div class="form-group">
								<input type="text" name="age" placeholder="年龄" class="form-control" />
							</div>
							<div class="form-group">
								<input type="radio" name="gender" value="1" />男
								<input type="radio" name="gender" value="0" />女
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-send"></i>&nbsp;确认提交</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		<form action="/user/update.do" method="post">
			<input type="hidden" name="id" value="${user.id}" id="userid">
			<div class="modal fade" id="myModal2" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel"><i class="glyphicon glyphicon-pencil"></i>&nbsp;编辑用户</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<input type="text" name="name" placeholder="用户名" class="form-control" value="${user.name}" />
							</div>
							<div class="form-group">
								<input type="password" name="pwd" placeholder="密码" class="form-control" value="${user.pwd}" />
							</div>
							<div class="form-group">
								<input type="text" name="age" placeholder="年龄" class="form-control" value="${user.age}" />
							</div>
							<div class="form-group">
								<input type="radio" name="gender" value="1" <c:if test="${user.gender==1}">checked</c:if> />男
								<input type="radio" name="gender" value="0" <c:if test="${user.gender==0}">checked</c:if> />女
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-send"></i>&nbsp;确认提交</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>