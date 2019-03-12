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
					
					<form action="informatization/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="INFORMATIZATION_ID" id="INFORMATIZATION_ID" value="${pd.INFORMATIZATION_ID}"/>
						<input type="hidden" name="msg" id="msg" value="${msg }"/>
						<input type="hidden" name="oafileList" id="oafileList">
						<input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS }">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">系统编序号:</td>
								<td><input readonly type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}" maxlength="100" placeholder="这里输入系统编序号" title="系统编序号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>产品名称:</td>
								<td><input type="text" name="PRODUCT_NAME" id="PRODUCT_NAME" value="${pd.PRODUCT_NAME}" maxlength="255" placeholder="这里输入产品名称" title="产品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>型号丶规格:</td>
								<td><input type="text" name="MODEL" id="MODEL" value="${pd.MODEL}" maxlength="255" placeholder="这里输入型号丶规格" title="型号丶规格" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>生产厂家:</td>
								<td><input type="text" name="MANUFACTURERS" id="MANUFACTURERS" value="${pd.MANUFACTURERS}" maxlength="255" placeholder="这里输入生产厂家" title="生产厂家" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>注册证号:</td>
								<td><input type="text" name="REGISTRATION" id="REGISTRATION" value="${pd.REGISTRATION}" maxlength="255" placeholder="这里输入注册证号" title="注册证号" style="width:98%;"/></td>
							</tr>

                            <tr>
                                <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>纸质资料是否齐全:</td>
                                <td>
                                    是<input type="radio" name="ISZILIAOQQ" checked  value="是" <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                    否<input type="radio" name="ISZILIAOQQ"  value="否" <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
                                </td>
                            </tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">补交时间:</td>
								<td>
									<input  placeholder="这里输入补交时间" data-date-format="yyyy-mm-dd" readonly class="span10 date-picker" type="text" name="BUJIAOSHIJIAN" id="BUJIAOSHIJIAN" value="${pd.BUJIAOSHIJIAN}" maxlength="100" style="width:98%;"/>
									<span style="color: red">注：若资料不齐全，则此项必填</span>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td>
									<input type="text" name="BUSINESS" id="BUSINESS" value="${pd.BUSINESS}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
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
<!-- 上传附件 -->
<script src="upload/oaFile.js"></script>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#SYS_ID").val()==""){
				$("#SYS_ID").tips({
					side:3,
		            msg:'请输入系统编序号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SYS_ID").focus();
			return false;
			}
			if($("#PRODUCT_NAME").val()==""){
				$("#PRODUCT_NAME").tips({
					side:3,
		            msg:'请输入产品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCT_NAME").focus();
			return false;
			}
			if($("#MODEL").val()==""){
				$("#MODEL").tips({
					side:3,
		            msg:'请输入型号丶规格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODEL").focus();
			return false;
			}
			if($("#MANUFACTURERS").val()==""){
				$("#MANUFACTURERS").tips({
					side:3,
		            msg:'请输入生产厂家',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MANUFACTURERS").focus();
			return false;
			}
			if($("#REGISTRATION").val()==""){
				$("#REGISTRATION").tips({
					side:3,
		            msg:'请输入注册证号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REGISTRATION").focus();
			return false;
			}




			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {

            if($("#msg").val()=="save"){
                $("#SYS_ID").val( getSysId('PX'));
            }

			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});


		});
		</script>
</body>
</html>