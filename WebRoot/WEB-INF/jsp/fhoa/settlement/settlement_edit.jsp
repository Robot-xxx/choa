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
					
					<form action="settlement/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SETTLEMENT_ID" id="SETTLEMENT_ID" value="${pd.SETTLEMENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目编号:</td>
								<td>
									<select class="chosen-select form-control" id="projectId"
											style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input hidden type="text" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" maxlength="100" placeholder="这里输入项目编号" title="项目编号" style="width:98%;"/></td>
									<input hidden type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}" maxlength="100" placeholder="这里输入项目编号" title="项目编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目名称:</td>
								<td><input readonly type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="100" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目负责人:</td>
								<td><input type="text" name="PROJECT_MAN" id="PROJECT_MAN" value="${pd.PROJECT_MAN}" maxlength="50" placeholder="这里输入项目负责人" title="项目负责人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">中标金额(万元):</td>
								<td><input readonly type="text" name="BID_PRICE" id="BID_PRICE" value="${pd.BID_PRICE}" maxlength="13" placeholder="这里输入中标金额" title="中标金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目回款金额(万元):</td>
								<td><input readonly type="text" name="PROJECT_MONEY" id="PROJECT_MONEY" value="${pd.PROJECT_MONEY}" maxlength="13" placeholder="这里输入项目回款金额" title="项目回款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">尾款时间:</td>
								<td><input class="span10 date-picker" name="DATE" id="DATE" value="${pd.DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="尾款时间" title="尾款时间" style="width:98%;"/></td>
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
		/*	if($("#PROJECT_MAN").val()==""){
				$("#PROJECT_MAN").tips({
					side:3,
		            msg:'请输入项目负责人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_MAN").focus();
			return false;
			}*/
		/*	if($("#BID_PRICE").val()==""){
				$("#BID_PRICE").tips({
					side:3,
		            msg:'请输入中标金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BID_PRICE").focus();
			return false;
			}
			if($("#PROJECT_MONEY").val()==""){
				$("#PROJECT_MONEY").tips({
					side:3,
		            msg:'请输入项目回款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_MONEY").focus();
			return false;
			}
			if($("#DATE").val()==""){
				$("#DATE").tips({
					side:3,
		            msg:'请输入尾款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DATE").focus();
			return false;
			}*/
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});


            var project = "${pd.SYS_ID}";
            //项目编号
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/project/getAllProject.do?tm=' + new Date().getTime(),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#projectId").append("<option value=''>请选择项目编号</option>");
                        for (var i = 0; i < data.list.length; i++) {
                            if (data.list[i].PROJECT_ID == project) {
                                $("#projectId").append("<option value=" + data.list[i].PROJECT_ID + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                            } else {
                                $("#projectId").append("<option value=" + data.list[i].PROJECT_ID + ">" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                            }
                        }
                        downList('projectId');
                    }
                }
            });

            //项目编号
            $("#projectId").change(function () {
                var str = $("#projectId option:selected").text();
                $("#PROJECT_NAME").val(str.substr(str.indexOf("-")+1,str.length));
                $("#PROJECT_ID").val(str.substring(0,str.indexOf("-")));
                $("#SYS_ID").val($("#projectId").val());


                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>/projectbid/getBid.do?tm=' + new Date().getTime(),
					data:{'PROJECT_ID':$("#projectId").val()},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        console.log(data)
                         $("#BID_PRICE").val(data.list[0].WINNING_PRICE);
                         $("#PROJECT_MONEY").val(data.count);

                    }
                });

            })

		});
		</script>
</body>
</html>