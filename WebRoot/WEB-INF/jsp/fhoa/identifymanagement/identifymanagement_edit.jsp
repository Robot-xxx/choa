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
					
					<form action="identifymanagement/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="IDENTIFYMANAGEMENT_ID" id="IDENTIFYMANAGEMENT_ID" value="${pd.IDENTIFYMANAGEMENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<%--	<tr>	<td style="width:75px;text-align: right;padding-top: 13px;">项目编号:</td>
								<td>
									<select class="chosen-select form-control"  id="projectId" style="vertical-align:top;width: 68px; width: 98%">

									</select>

									<input hidden type="text" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" maxlength="100" placeholder="这里输入项目编号" title="项目编号" style="width:98%;"/></td>


							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目名称:</td>
								<td><input readonly type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="50" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>--%>
                            <tr>
                                <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>回款期数:</td>
                                <td><input type="text" name="HUIKUAN" id="HUIKUAN" value="${pd.HUIKUAN}" maxlength="32" placeholder="这里输入回款期数" title="回款期数" style="width:98%;"/></td>
                            </tr>
                            <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>进款金额:</td>
								<td><input type="number" name="INCOME_MONEY" id="INCOME_MONEY" value="${pd.INCOME_MONEY}" maxlength="32" placeholder="这里输入进款金额" title="进款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>回款单位:</td>
								<td><input name="RETURN_MONEY" id="RETURN_MONEY" value="${pd.RETURN_MONEY}" type="text" placeholder="回款单位" title="回款单位" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>日期:</td>
								<td><input class="span10 date-picker" name="CREATE_DATE" id="CREATE_DATE" value="${pd.CREATE_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="日期" title="日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">汇款备注:</td>
								<td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255" placeholder="这里输入汇款备注" title="汇款备注" style="width:98%;"/></td>
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
		            msg:'请输入项目编号',
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
			if($("#INCOME_MONEY").val()==""){
				$("#INCOME_MONEY").tips({
					side:3,
		            msg:'请输入进款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INCOME_MONEY").focus();
			return false;
			}
			if($("#RETURN_MONEY").val()==""){
				$("#RETURN_MONEY").tips({
					side:3,
		            msg:'请输入回款单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RETURN_MONEY").focus();
			return false;
			}
			if($("#CREATE_DATE").val()==""){
				$("#CREATE_DATE").tips({
					side:3,
		            msg:'请输入日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATE_DATE").focus();
			return false;
			}

			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}



        function getInfo(){
            var project="${pd.PROJECT_ID}";

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
                            if (data.list[i].SYS_ID  == project) {
                                $("#projectId").append("<option value=" +  data.list[i].SYS_ID  + " selected='selected'>" + data.list[i].SYS_ID+"-"+data.list[i].PROJECT_NAME + "</option>");
                            } else {
                                $("#projectId").append("<option value=" + data.list[i].SYS_ID  + ">" + data.list[i].SYS_ID+"-"+data.list[i].PROJECT_NAME + "</option>");
                            }
                        }
                        downList('projectId');
                    }
                }
            });
		}

		$(function() {

            $("#projectId").change(function (){
                $("#PROJECT_NAME").val('');
                $("#PROJECT_ID").val('');
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>/projectbid/projectById.do?PROJECT_ID=' + $("#projectId").val(),
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if (data.errInfo == "success") {
                            $("#PROJECT_NAME").val(data.pd.PROJECT_NAME);
                            $("#PROJECT_ID").val($("#projectId").val());
                        }
                    }
                });
            })



		    getInfo();
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});
		</script>
</body>
</html>