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
					
					<form action="claimant/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"/>
						<input type="hidden" name="money" id="money" value="${pd.money}"/>
						<input type="hidden" name="moneyId" id="moneyId" value="${pd.moneyId}"/>
						<input type="hidden" name="CONTRACT_PRICE" id="hetongMoney" value=""/>
						<input type="hidden" name="PROJECT_MARKET_ID" id="PROJECT_MARKET_ID" value="${pd.PROJECT_MARKET_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>认款类型:</td>
								<td>
									<select name="RENKUAILEIXING" id="RENKUAILEIXING" title=""
											style="width:38%;"></select>
								</td>
							</tr>
							<tr>	<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目编号:</td>
                                <td>
                                    <select class="chosen-select form-control"  id="projectId" style="vertical-align:top;width: 68px; width: 98%">

                                    </select>

                                    <input hidden type="text" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" maxlength="100" placeholder="这里输入项目编号" title="项目编号" style="width:98%;"/></td>


                            </tr>
                            <tr>
                                <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目名称:</td>
                                <td><input readonly type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="50" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
                            </tr>
						<%--	<tr>


								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>合同总额:</td>
								<td><input  name="CONTRACT_PRICE" id="CONTRACT_PRICE" value="${pd.CONTRACT_PRICE}" type="text"  placeholder="合同总额" title="合同总额" style="width:98%;"/></td>
							</tr>--%>
							<tr>


								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>认领时间:</td>
								<td><input class="span10 date-picker" name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="认领时间" title="认领时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>认领人名称:</td>
								<td><input type="text" name="CLAIMANT_NAME" id="CLAIMANT_NAME" value="${pd.CLAIMANT_NAME}" maxlength="100" placeholder="这里输入认领人名称" title="认领人名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>认领金额(元):</td>
								<td><input type="number" name="CLAIMANT_MONEY" id="CLAIMANT_MONEY" value="${pd.CLAIMANT_MONEY}" maxlength="32" placeholder="这里输入认领金额" title="认领金额" style="width:98%;"/></td>
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
			if($("#RENKUAILEIXING").val()==""){
				$("#RENKUAILEIXING").tips({
					side:3,
		            msg:'请选择认款类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RENKUAILEIXING").focus();
			return false;
			}
		/*	if($("#CONTRACT_PRICE").val()==""){
				$("#CONTRACT_PRICE").tips({
					side:3,
		            msg:'请输入合同总额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_PRICE").focus();
			return false;
			}*/
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
			if($("#CREATE_TIME").val()==""){
				$("#CREATE_TIME").tips({
					side:3,
		            msg:'请输入认领时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATE_TIME").focus();
			return false;
			}
			if($("#CLAIMANT_NAME").val()==""){
				$("#CLAIMANT_NAME").tips({
					side:3,
		            msg:'请输入认领人名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CLAIMANT_NAME").focus();
			return false;
			}
			if($("#CLAIMANT_MONEY").val()==""){
				$("#CLAIMANT_MONEY").tips({
					side:3,
		            msg:'请输入认领金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CLAIMANT_MONEY").focus();
			return false;
			}


			if(parseFloat($("#CLAIMANT_MONEY").val())>parseFloat($("#money").val())){
			    alert("认款金额过大，认款失败！");
			    return false;
			}
            if(parseFloat($("#CLAIMANT_MONEY").val())>parseFloat($("#hetongMoney").val())){
                alert("认款金额超过合同金额，认款失败！");
                return false;
            }
            $("#Form").submit();
            $("#zhongxin").hide();
            $("#zhongxin2").show();
		}



		$(function() {

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
							$("#projectId").append("<option value=" +  data.list[i].PROJECT_MARKET_ID  + ">" + data.list[i].SYS_ID+"=>"+data.list[i].PROJECT_NAME + "</option>");

						}
						downList('projectId');
					}
				}
			});

            var date = new Date();
		    $("#CREATE_TIME").val(date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate());

            $("#projectId").change(function (){
                var str= $("#projectId option:selected").text();
                $("#PROJECT_NAME").val('');
                $("#PROJECT_ID").val('');
                $("#PROJECT_MARKET_ID").val('');

                $("#PROJECT_NAME").val(str.substring(str.indexOf('=>')+2,str.length));
                $("#PROJECT_ID").val(str.substring(0,str.indexOf('=>')));
                $("#PROJECT_MARKET_ID").val($("#projectId").val());


            })

			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
            var BUSINESS = "${pd.RENKUAILEIXING}";
            $.ajax({
                type: "POST",
                url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
                data: {DICTIONARIES_ID: '02f895c7cf44412bb8ed79df27d019de'},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $("#RENKUAILEIXING").append("<option value=''>请选择类型</option>");
                    $.each(data.list, function (i, dvar) {
                        if (BUSINESS == dvar.NAME) {
                            $("#RENKUAILEIXING").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                        } else {
                            $("#RENKUAILEIXING").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                        }
                    });

                }
            });

		});
		</script>
</body>
</html>