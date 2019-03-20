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
					
					<form action="projectinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROJECTINFO_ID" id="PROJECTINFO_ID" value="${pd.PROJECTINFO_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font
										color="red">*</font>产品类型:
								</td>
								<td>
									<select class="chosen-select form-control" name="PRODUCTTYPE"
											id="productType" data-placeholder="产品类型"
											style="vertical-align:top;width: 68px;">

									</select>


								</td>

							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>产品ID:</td>
								<td>
									<select class="chosen-select form-control"  name="PRODUCT_ID" data-placeholder="选择产品" id="c_selectCompany" style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input hidden type="text" name="PARENT_ID" id="PARENT_ID" value="${pd.PARENT_ID}" />
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>产品名称:</td>
								<td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="100" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>产品数量:</td>
								<td><input type="number" name="PROJECTNUMBER" id="PROJECTNUMBER" value="${pd.PROJECTNUMBER}" maxlength="32" placeholder="这里输入项目数量" title="项目数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>单价:</td>
								<td><input type="text" name="PROJECTPRICE" id="PROJECTPRICE" value="${pd.PROJECTPRICE}" maxlength="12" placeholder="这里输入单价" title="单价" style="width:98%;"/></td>
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

			if($("#PROJECTNUMBER").val()==""){
				$("#PROJECTNUMBER").tips({
					side:3,
		            msg:'请输入项目数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECTNUMBER").focus();
			return false;
			}
			if($("#PROJECTPRICE").val()==""){
				$("#PROJECTPRICE").tips({
					side:3,
		            msg:'请输入单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECTPRICE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}




		$(function() {
			downList('c_selectCompany');

			$("#productType").change(function(){

				$('#c_selectCompany').empty();

				if($('#productType').val()!=''){
					$('#c_selectCompany').chosen("destroy")
				}


				if(	$("#productType").val()=="instrument"){
					var cp = "${pd.PRODUCT_NAME}";
					//产品管理
					$.ajax({
						type: "POST",
						url: '<%=basePath%>/project/c_ProductAll.do?tm=' + new Date().getTime(),
						dataType: 'json',
						cache: false,
						success: function (data) {
							if (data.errInfo == "success") {
								$("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
								for (var i = 0; i < data.list.length; i++) {

									$("#c_selectCompany").append("<option value=" + data.list[i].INSTRUMENT_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "=>" + data.list[i].MODEL + "</option>");

								}

								downList('c_selectCompany');
							}
						}
					});
				}

				if(	$("#productType").val()=="informatization"){
					var cp = "${pd.PRODUCT_NAME}";
					//产品管理
					$.ajax({
						type: "POST",
						url: '<%=basePath%>/informatization/getAllInstrument.do?tm=' + new Date().getTime(),
						dataType: 'json',
						cache: false,
						success: function (data) {
							if (data.errInfo == "success") {
								$("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
								for (var i = 0; i < data.list.length; i++) {

									$("#c_selectCompany").append("<option value=" + data.list[i].INFORMATIZATION_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "=>" + data.list[i].MODEL + "</option>");

								}

								downList('c_selectCompany');
							}
						}
					});
				}
				if(	$("#productType").val()=="equipment"){
					var cp = "${pd.PRODUCT_NAME}";
					//产品管理
					$.ajax({
						type: "POST",
						url: '<%=basePath%>/equipment/getAllInstrument.do?tm=' + new Date().getTime(),
						dataType: 'json',
						cache: false,
						success: function (data) {
							if (data.errInfo == "success") {
								$("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
								for (var i = 0; i < data.list.length; i++) {

									$("#c_selectCompany").append("<option value=" + data.list[i].EQUIPMENT_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "=>" + data.list[i].MODEL + "</option>");

								}

								downList('c_selectCompany');
							}
						}
					});
				}
				if(	$("#productType").val()=="otherequipment"){
					var cp = "${pd.PRODUCT_NAME}";
					//产品管理
					$.ajax({
						type: "POST",
						url: '<%=basePath%>/otherequipment/getAllInstrument.do?tm=' + new Date().getTime(),
						dataType: 'json',
						cache: false,
						success: function (data) {
							if (data.errInfo == "success") {
								$("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
								for (var i = 0; i < data.list.length; i++) {
									$("#c_selectCompany").append("<option value=" + data.list[i].EQUIPMENT_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "=>" + data.list[i].MODEL + "</option>");
								}

								downList('c_selectCompany');
							}
						}
					});
				}
				if(	$("#productType").val()=="consumable"){
					var cp = "${pd.PRODUCT_NAME}";
					//产品管理
					$.ajax({
						type: "POST",
						url: '<%=basePath%>/consumable/getAllInstrument.do?tm=' + new Date().getTime(),
						dataType: 'json',
						cache: false,
						success: function (data) {
							if (data.errInfo == "success") {
								$("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
								for (var i = 0; i < data.list.length; i++) {
									$("#c_selectCompany").append("<option value=" + data.list[i].CONSUMABLE_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "=>" + data.list[i].MODEL + "</option>");
								}

								downList('c_selectCompany');
							}
						}
					});
				}
            });
            //项目编号
            $("#c_selectCompany").change(function () {
                var str1 = $("#c_selectCompany option:selected").text();
                var projectname = str1.substring(0,str1.indexOf("=>"));
                var projectid = str1.substring(str1.indexOf("=>") + 1, str1.length);

                $("#PROJECT_ID").val(projectid);
                $("#PROJECT_NAME").val(projectname);


            });



            //日期框
            $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
            $.ajax({
                type: "POST",
                url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
                data: {DICTIONARIES_ID: 'fd8cdef8abc048c392920efbda667841'},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $("#productType").append("<option value=''>请选择类型</option>");
                    $.each(data.list, function (i, dvar) {
                        $("#productType").append("<option value=" + dvar.NAME_EN + " >" + dvar.NAME + "</option>");
                    });
                    downList('productType');
                }
            });

        })
		</script>
</body>
</html>