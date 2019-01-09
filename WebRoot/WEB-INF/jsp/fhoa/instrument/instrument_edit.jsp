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
					
					<form action="instrument/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="INSTRUMENT_ID" id="INSTRUMENT_ID" value="${pd.INSTRUMENT_ID}"/>
						<input type="hidden" name="msg" id="msg" value="${msg }"/>
						<input type="hidden" name="oafileList" id="oafileList">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>器械编号:</td>
								<td><input type="text" name="SYS_ID" id="SYS_ID" readonly value="${pd.SYS_ID}" maxlength="100" placeholder="这里输入器械编号" title="器械编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>器械名称:</td>
								<td><input type="text" name="PRODUCT_NAME" id="PRODUCT_NAME" value="${pd.PRODUCT_NAME}" maxlength="100" placeholder="这里输入产品名称" title="产品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>器械型号:</td>
								<td><input type="text" name="MODEL" id="MODEL" value="${pd.MODEL}" maxlength="100" placeholder="这里输入型号丶规格" title="型号丶规格" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>生产厂家:</td>
								<td><input type="text" name="MANUFACTURERS" id="MANUFACTURERS" value="${pd.MANUFACTURERS}" maxlength="100" placeholder="这里输入生产厂家" title="生产厂家" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>注册证号:</td>
								<td><input type="text" name="REGISTRATION" id="REGISTRATION" value="${pd.REGISTRATION}" maxlength="100" placeholder="这里输入注册证号" title="注册证号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>生产批次:</td>
								<td><input type="text" name="BATCH" id="BATCH" value="${pd.BATCH}" maxlength="100" placeholder="这里输入生产批次" title="注册证号" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>有效期:</td>
								<td><input class="span10 date-picker" type="text" name="VALIDITY" id="VALIDITY" value="${pd.VALIDITY}" maxlength="100" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="这里输入有效期" title="注册证号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>注册证类别:</td>
								<td>
									<select name="LICENCE" id="LICENCE" title="注册证类别"
											style="width:54%;"></select>
									<input type="text" name="BUSINESS" id="BUSINESS" value="${pd.BUSINESS}" maxlength="100" placeholder="这里输入生注册证类别" title="注册证类别" style="width:44%;"/>
								</td>
							</tr>

                            <tr>
                                <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>是否资料齐全:</td>
                                <td>
                                    是<input type="radio" name="ISZILIAOQQ"  value="是" <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                    否<input type="radio" name="ISZILIAOQQ"  value="否" <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
                                </td>
                            </tr>
                            <%--
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>生产批次:</td>
								<td><input type="text" name="BATCH" id="BATCH" value="${pd.BATCH}" maxlength="100" placeholder="这里输入生产批次" title="生产批次" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>有效期:</td>
								<td><input class="span10 date-picker" name="VALIDITY" id="VALIDITY" value="${pd.VALIDITY}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="有效期" title="有效期" style="width:98%;"/></td>
							</tr>--%>
							<%--<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">附件:</td>
								<td>
									<div class="main-container" id="main-container">
										<!-- /section:basics/sidebar -->
										<div class="main-content">
											<div class="main-content-inner">
												<div class="page-content">
													<div class="row">
														<div class="col-xs-12">

															<!-- 检索  -->
															<form action="oafile/list.do" method="post"
																  name="Form" id="Form2">


																<table id="simple-table"
																	   class="table table-striped table-bordered table-hover"
																	   style="margin-top:5px;">
																	<thead>
																	<tr>
																		<th class="center" style="width:35px;">
																			<label class="pos-rel"><input
																					type="checkbox" class="ace"
																					id="zcheckbox"/><span
																					class="lbl"></span></label>
																		</th>
																		<th class="center" style="width:50px;">
																			序号
																		</th>
																		<th class="center">文件名</th>
																		<th class="center">上传者</th>
													 					<th class="center">上传时间</th>
																		<th class="center">文件类型</th>
																		<th class="center">备注</th>
																	</tr>
																	</thead>
																	<tbody id="append">


																	</tbody>

																</table>
																<div class="page-header position-relative">
																	<table style="width:100%;">
																		<tr>
																			<td style="vertical-align:top;">
																				<a class="btn btn-mini btn-success"
																				   onclick="add('${pd.INSTRUMENT_ID}','2edba70525574ebfacda36e4e7607034');">上传</a>
																				<a class="btn btn-mini btn-danger"
																				   onclick="makeAll('确定要删除选中的数据吗?');"
																				   title="批量删除"><i
																						class='ace-icon fa fa-trash-o bigger-120'></i></a>
																			</td>
																		</tr>
																	</table>
																</div>
															</form>
														</div>
													</div>
												</div>
											</div>
										</div>

										<!-- 返回顶部 -->
										<a href="#" id="btn-scroll-up"
										   class="btn-scroll-up btn btn-sm btn-inverse">
											<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
										</a>

									</div>
								</td>
							</tr>--%>
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
            if($("#LICENCE").val()==""){
                $("#LICENCE").tips({
                    side:3,
                    msg:'请选择类型',
                    bg:'#AE81FF',
                    time:2
                });
                $("#LICENCE").focus();
                return false;
            }
			if($("#BUSINESS").val()==""){
				$("#BUSINESS").tips({
					side:3,
		            msg:'注册证类别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUSINESS").focus();
			return false;
			}
			/*if($("#BATCH").val()==""){
				$("#BATCH").tips({
					side:3,
		            msg:'请输入生产批次',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BATCH").focus();
			return false;
			}*//*
			if($("#VALIDITY").val()==""){
				$("#VALIDITY").tips({
					side:3,
		            msg:'请输入有效期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VALIDITY").focus();
			return false;
			}*/


            $("#BUSINESS").val($("#LICENCE").val()+"-"+$("#BUSINESS").val());


			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
       /*     localStorage.setItem("Identification", "save");*/
		}
		
		$(function() {

            if($("#msg").val()=="save"){
                $("#SYS_ID").val( getSysId('PQ'));
            }

			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});


            var BUSINESS = "${pd.BUSINESS}";
            var number="";
            number=BUSINESS.substring(BUSINESS.indexOf("-")+1,BUSINESS.length);
            $("#BUSINESS").val(number);
            BUSINESS=BUSINESS.substring(0,BUSINESS.indexOf("-"));

            $.ajax({
                type: "POST",
                url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
                data: {DICTIONARIES_ID: '65b4c530e6d244c78deedcd0d49250f8'},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $("#LICENCE").append("<option value=''>请选择类型</option>");
                    $.each(data.list, function (i, dvar) {
                        if (BUSINESS == dvar.NAME) {
                            $("#LICENCE").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                        } else {
                            $("#LICENCE").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                        }
                    });
                }
            });

		});
		</script>
</body>
</html>