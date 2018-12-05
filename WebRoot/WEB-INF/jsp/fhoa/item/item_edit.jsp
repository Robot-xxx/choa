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
					
					<form action="item/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>费用名称:</td>
								<td><input type="text" name="ITEM_NAME" id="ITEM_NAME" value="${pd.ITEM_NAME}" maxlength="100" placeholder="这里输入费用名称" title="费用名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>金额:</td>
								<td><input type="text" name="ITEM_MONEY" id="ITEM_MONEY" value="${pd.ITEM_MONEY}" maxlength="13" placeholder="这里输入金额" title="金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>支付时间:</td>
								<td><input class="span10 date-picker" name="PAY_DATE" id="PAY_DATE" value="${pd.PAY_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="支付时间" title="支付时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>退回时间:</td>
								<td><input class="span10 date-picker" name="BACK_DATE" id="BACK_DATE" value="${pd.BACK_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="退回时间" title="退回时间" style="width:98%;"/></td>
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
			if($("#ITEM_NAME").val()==""){
				$("#ITEM_NAME").tips({
					side:3,
		            msg:'请输入费用名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ITEM_NAME").focus();
			return false;
			}
			if($("#ITEM_MONEY").val()==""){
				$("#ITEM_MONEY").tips({
					side:3,
		            msg:'请输入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ITEM_MONEY").focus();
			return false;
			}
			if($("#PAY_DATE").val()==""){
				$("#PAY_DATE").tips({
					side:3,
		            msg:'请输入支付时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAY_DATE").focus();
			return false;
			}
			if($("#BACK_DATE").val()==""){
				$("#BACK_DATE").tips({
					side:3,
		            msg:'请输入退回时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BACK_DATE").focus();
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