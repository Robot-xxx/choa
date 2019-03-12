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
					
					<form action="projectproduct/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROJECTPRODUCT_ID" id="PROJECTPRODUCT_ID" value="${pd.PROJECTPRODUCT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font
										color="red">*</font>产品类型:
								</td>
								<td>
									<select class="chosen-select form-control" name="PRODUCTTYPE"
											id="productType"  data-placeholder="产品类型"
											style="vertical-align:top;width: 68px;">

									</select>


								</td>

							</tr>
							<tr id="tr1">
								<td style="width:75px;text-align: right;padding-top: 13px;"><font
										color="red">*</font>器械名称:
								</td>
								<td>
									<select class="chosen-select form-control" name="PRODUCT_ID"
											id="c_selectCompany" data-placeholder="器械编号"
											style="vertical-align:top;width: 68px;">

									</select>

									<input type="text" hidden name="PARENT_ID" id="PARENT_ID"
										   value="${pd.PARENT_ID}" maxlength="100" style="width:48%;"/>
									<span style="color: red">注:需先在器械管理处填写资料并通过质控审批后才能选择</span>
								</td>

							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">器械名称:</td>
								<td><input type="text" name="PRODUCT_NAME" id="PRODUCT_NAME" value="${pd.PRODUCT_NAME}" maxlength="255" placeholder="这里输入器械名称" title="器械名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">器械型号:</td>
								<td><input type="text" name="PRODUCT_MODEL" id="PRODUCT_MODEL" value="${pd.PRODUCT_MODEL}" maxlength="255" placeholder="这里输入器械型号" title="器械型号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">器械到期日:</td>
								<td>
									<input name="PRODUCT_TIME" id="PRODUCT_TIME"
										   value="${pd.PRODUCT_TIME}" type="text" readonly="readonly"
										   style="width:98%;"/>
									<span style="color: red">注:注意核对到期日情况</span>
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
	<!-- 下拉列表框 -->
	<script src="common/downList.js"></script>
		<script type="text/javascript">

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

                                    $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "-" + data.list[i].MODEL + "</option>");

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

                                    $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "-" + data.list[i].MODEL + "</option>");

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

                                    $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "-" + data.list[i].MODEL + "</option>");

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

                                    $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "-" + data.list[i].MODEL + "</option>");

                                }

                                downList('c_selectCompany');
                            }
                        }
                    });
                }
                if(	$("#productType").val()=="claimant"){
                    var cp = "${pd.PRODUCT_NAME}";
                    //产品管理
                    $.ajax({
                        type: "POST",
                        url: '<%=basePath%>/claimant/getAllInstrument.do?tm=' + new Date().getTime(),
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            if (data.errInfo == "success") {
                                $("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
                                for (var i = 0; i < data.list.length; i++) {

                                    $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].PRODUCT_NAME + "-" + data.list[i].MODEL + "</option>");

                                }

                                downList('c_selectCompany');
                            }
                        }
                    });
                }
			});


		$(top.hangge());
		//保存
		function save(){
			if($("#PRODUCT_NAME").val()==""){
				$("#PRODUCT_NAME").tips({
					side:3,
		            msg:'请输入器械名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCT_NAME").focus();
			return false;
			}
			if($("#PRODUCT_TIME").val()==""){
				$("#PRODUCT_TIME").tips({
					side:3,
		            msg:'请输入器械到期日',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCT_TIME").focus();
			return false;
			}
			if($("#PRODUCT_MODEL").val()==""){
				$("#PRODUCT_MODEL").tips({
					side:3,
		            msg:'请输入器械型号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCT_MODEL").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {

            downList('c_selectCompany');




            //产品信息
            $("#c_selectCompany").change(function () {
                var str1= $("#c_selectCompany option:selected").text();
                var str = $("#c_selectCompany").val();

                $("#PRODUCT_TIME").val(fmtDate(parseFloat(str.substring(str.indexOf("=") + 1, str.length))));

                $("#PRODUCT_NAME").val('');

                $("#PRODUCT_NAME").val(str1.substring(0,str1.indexOf("-")));

                $("#PRODUCT_MODEL").val(str1.substring(str1.indexOf("-")+1,str1.length));

            })

            function fmtDate(obj) {
                var date = new Date(obj);
                var y = 1900 + date.getYear();
                var m = "0" + (date.getMonth() + 1);
                var d = "0" + date.getDate();
                return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
            }
            //截取字符串
            function jiequ(str) {
                return str.substring(str.lastIndexOf('=') + 1, str.length);
            }
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});

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
		});
		</script>
</body>
</html>