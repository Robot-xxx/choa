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
					
					<form action="weibao/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">维保产品名称:</td>
								<td><input type="text" name="WEIBAOMINGCHENG" id="WEIBAOMINGCHENG" value="${pd.WEIBAOMINGCHENG}" maxlength="50" placeholder="这里输入维保产品名称" title="维保产品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">器械型号:</td>
								<td><input type="text" name="QIXIEXINGHAO" id="QIXIEXINGHAO" value="${pd.QIXIEXINGHAO}" maxlength="100" placeholder="这里输入器械型号" title="器械型号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">供应商名称:</td>
								<td><input type="text" name="GONGYINGSHANMINGCHENG" id="GONGYINGSHANMINGCHENG" value="${pd.GONGYINGSHANMINGCHENG}" maxlength="100" placeholder="这里输入供应商名称" title="供应商名称" style="width:98%;"/></td>
							</tr>
							<tr>

								<td style="width:75px;text-align: right;padding-top: 13px;">开始时间:</td>
								<td><input class="span10 date-picker" name="KAISHISHIJIAN" id="KAISHISHIJIAN"
										   value="${pd.KAISHISHIJIAN}" type="text"
										   data-date-format="yyyy-mm-dd" readonly="readonly"
										   placeholder="这里输入开始时间" title="开始时间" style="width:98%;"/>

								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">到期时间:</td>
								<td>
									<input class="span10 date-picker" name="DAOQISHIJIAN" id="DAOQISHIJIAN"
										   value="${pd.DAOQISHIJIAN}" type="text"
										   data-date-format="yyyy-mm-dd" readonly="readonly"
										   placeholder="这里输入到期时间" title="到期时间" style="width:98%;"/>
								</td>
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
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#WEIBAOMINGCHENG").val()==""){
				$("#WEIBAOMINGCHENG").tips({
					side:3,
		            msg:'请输入维保产品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WEIBAOMINGCHENG").focus();
			return false;
			}
			if($("#QIXIEXINGHAO").val()==""){
				$("#QIXIEXINGHAO").tips({
					side:3,
		            msg:'请输入器械型号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#QIXIEXINGHAO").focus();
			return false;
			}
			if($("#GONGYINGSHANMINGCHENG").val()==""){
				$("#GONGYINGSHANMINGCHENG").tips({
					side:3,
		            msg:'请输入供应商名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GONGYINGSHANMINGCHENG").focus();
			return false;
			}
			if($("#KAISHISHIJIAN").val()==""){
				$("#KAISHISHIJIAN").tips({
					side:3,
		            msg:'请输入开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#KAISHISHIJIAN").focus();
			return false;
			}
			if($("#DAOQISHIJIAN").val()==""){
				$("#DAOQISHIJIAN").tips({
					side:3,
		            msg:'请输入到期时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DAOQISHIJIAN").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});
		</script>
</body>
</html>