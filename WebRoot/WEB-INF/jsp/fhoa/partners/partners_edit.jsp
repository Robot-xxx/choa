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
					
					<form action="partners/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PARTNERS_ID" id="PARTNERS_ID" value="${pd.PARTNERS_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">公司名称:</td>
								<td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="100" placeholder="这里输入公司名称" title="公司名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开户行:</td>
								<td><input type="text" name="BANK_ACCOUNT" id="BANK_ACCOUNT" value="${pd.BANK_ACCOUNT}" maxlength="100" placeholder="这里输入开户行" title="开户行" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开户账号:</td>
								<td><input type="text" name="OPEN_ACCOUNT" id="OPEN_ACCOUNT" value="${pd.OPEN_ACCOUNT}" maxlength="100" placeholder="这里输入开户账号" title="开户账号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系人:</td>
								<td><input type="text" name="LINKMAN" id="LINKMAN" value="${pd.LINKMAN}" maxlength="100" placeholder="这里输入联系人" title="联系人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系人电话:</td>
								<td><input type="text" name="LINKMAN_PHONE" id="LINKMAN_PHONE" value="${pd.LINKMAN_PHONE}" maxlength="100" placeholder="这里输入联系人电话" title="联系人电话" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
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
			if($("#COMPANY_NAME").val()==""){
				$("#COMPANY_NAME").tips({
					side:3,
		            msg:'请输入公司名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_NAME").focus();
			return false;
			}
			if($("#BANK_ACCOUNT").val()==""){
				$("#BANK_ACCOUNT").tips({
					side:3,
		            msg:'请输入开户行',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANK_ACCOUNT").focus();
			return false;
			}
			if($("#OPEN_ACCOUNT").val()==""){
				$("#OPEN_ACCOUNT").tips({
					side:3,
		            msg:'请输入开户账号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OPEN_ACCOUNT").focus();
			return false;
			}
			if($("#LINKMAN").val()==""){
				$("#LINKMAN").tips({
					side:3,
		            msg:'请输入联系人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LINKMAN").focus();
			return false;
			}
			if($("#LINKMAN_PHONE").val()==""){
				$("#LINKMAN_PHONE").tips({
					side:3,
		            msg:'请输入联系人电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LINKMAN_PHONE").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
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