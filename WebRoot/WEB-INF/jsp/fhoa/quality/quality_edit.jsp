<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="quality/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="QUALITY_ID" id="QUALITY_ID" value="${pd.QUALITY_ID}"/>
						<input readonly type="hidden" name="XULEIHAO" id="XULEIHAO" value="${pd.XULEIHAO}"/>
						<input  type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目编号:</td>
								<td>
									<select class="chosen-select form-control" id="projectId"
											style="vertical-align:top;width: 68px; width: 98%">

									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目名称:</td>
								<td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="255" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">负责人:</td>
								<td><input type="text" name="FUZEREN" id="FUZEREN" value="${pd.FUZEREN}" maxlength="255" placeholder="这里输入负责人" title="负责人" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>

		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#PROJECT_ID").val()==""){
				$("#PROJECT_ID").tips({
					side:3,
		            msg:'请输入项目ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_ID").focus();
			return false;
			}
			if($("#PROJECT_NAME").val()==""){
				$("#PROJECT_NAME").tips({
					side:3,
		            msg:'请输入项目名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_NAME").focus();
			return false;
			}
			if($("#FUZEREN").val()==""){
				$("#FUZEREN").tips({
					side:3,
		            msg:'请输入负责人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FUZEREN").focus();
			return false;
			}

			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			var project = "${pd.XULEIHAO}";
			//项目编号
			$.ajax({
				type: "POST",
				url: '<%=basePath%>/projectbid/getProjectAll.do?tm=' + new Date().getTime(),
				dataType: 'json',
				cache: false,
				success: function (data) {
					if (data.errInfo == "success") {
						$("#projectId").append("<option value=''>请选择项目编号</option>");
						for (var i = 0; i < data.list.length; i++) {
							if (data.list[i].PROJECT_ID == project) {
								$("#projectId").append("<option value=" + data.list[i].PROJECT_ID + "=" + data.list[i].FUZEREN + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
							} else {
								$("#projectId").append("<option value=" + data.list[i].PROJECT_ID + "=" + data.list[i].FUZEREN + ">" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
							}
						}
						downList('projectId');
					}
				}
			});
			//项目编号
			$("#projectId").change(function () {
				var str = $("#projectId").val();
				var str1 = $("#projectId option:selected").text();

				$("#PROJECT_NAME").val('');
				$("#XULEIHAO").val('');
				$("#PROJECT_ID").val('');
				$("#FUZEREN").val('');
				$.ajax({
					type: "POST",
					url: '<%=basePath%>/projectbid/projectById.do?PROJECT_ID=' + str.substring(0, str.indexOf("=")),
					dataType: 'json',
					cache: false,
					success: function (data) {
						console.log(JSON.stringify(data))
						if (data.errInfo == "success") {
							$("#PROJECT_NAME").val(data.pd.PROJECT_NAME);
							$("#XULEIHAO").val(str.substring(0, str.indexOf("=")));


							$("#PROJECT_ID").val(data.pd.SYS_ID);
							$("#FUZEREN").val(data.pd.FUZEREN);


						}
					}

				});

			})
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});
		</script>
</body>
</html>