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
					
					<form action="inputticket/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"/>
						<input type="hidden" name="msg" id="msg" value="${msg }"/>
						<input type="hidden" name="oafileList" id="oafileList">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>选择公司:</td>
								<td>
									<select name="LICENCE" id="LICENCE" title=""
											style="width:38%;"></select>
									<input type="text" hidden name="SELECTCOMPANY" id="xuanzeCompany"
										   value="${pd.SELECTCOMPANY}"
										   maxlength="100" placeholder="这里输入公司名称" title="公司名称"
										   style="width:60%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目编号:</td>

								<td>
									<select class="chosen-select form-control"  id="projectId" style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input hidden type="text" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" maxlength="100" placeholder="这里输入项目编号" title="项目编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目名称:</td>
								<td><input readonly type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="100" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>采购合同编号:</td>
								<td>
									<select class="chosen-select form-control"  id="cghetong" style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input hidden type="text" name="PURCHASENUMBER" id="PURCHASENUMBER" value="${pd.PURCHASENUMBER}" maxlength="100" placeholder="这里输入采购合同编号" title="采购合同编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>进项票总额(万元):</td>
								<td><input readonly type="text" name="JINPRICE" id="JINPRICE" value="${pd.JINPRICE}" maxlength="12" placeholder="这里输入进项票金额(万元)" title="进项票金额(万元)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>发票号:</td>
								<td><input  type="text" name="TICKET_NO" id="TICKET_NO" value="${pd.TICKET_NO}" maxlength="12" placeholder="发票号码" title="发票号码" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>已回票金额(万元):</td>
								<td><input  type="number" name="YIHUIPIAOJINE" id="YIHUIPIAOJINE" value="${pd.YIHUIPIAOJINE}" maxlength="12" placeholder="这里输入已回票金额" title="已回票金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>金额(万元):</td>
								<td><input  type="number" name="MONEY" id="MONEY" value="${pd.MONEY}" maxlength="12" placeholder="这里输入金额" title="金额" style="width:98%;"/></td>
							</tr>



							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="JINBZ" id="JINBZ" value="${pd.JINBZ}" maxlength="255" placeholder="这里输入进项票备注" title="进项票备注" style="width:98%;"/></td>
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
<!-- 文件上传-->
<script src="upload/oaFile.js"></script>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>
		<script type="text/javascript">
            var str = "<option value=''>请选择类型</option>";
		$(top.hangge());
		//保存
		function save(){
			if($("#xuanzeCompany").val()==""){
				$("#xuanzeCompany").tips({
					side:3,
		            msg:'请输入选择公司',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#xuanzeCompany").focus();
			return false;
			}
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
			if($("#YIHUIPIAOJINE").val()==""){
				$("#YIHUIPIAOJINE").tips({
					side:3,
		            msg:'请输入已回票金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#YIHUIPIAOJINE").focus();
			return false;
			}
			if($("#PURCHASENUMBER").val()==""){
				$("#PURCHASENUMBER").tips({
					side:3,
		            msg:'请输入采购合同编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PURCHASENUMBER").focus();
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
			if($("#JINPRICE").val()==""){
				$("#JINPRICE").tips({
					side:3,
		            msg:'请输入进项票金额(万元)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JINPRICE").focus();
			return false;
			}
			if($("#TICKET_NO").val()==""){
				$("#TICKET_NO").tips({
					side:3,
		            msg:'请输入发票号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TICKET_NO").focus();
			return false;
			}
			if($("#MONEY").val()==""){
				$("#MONEY").tips({
					side:3,
		            msg:'请输入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MONEY").focus();
			return false;
			}

			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
            localStorage.setItem("Identification", "save");
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
                                    $("#projectId").append("<option value=" +  data.list[i].PROJECT_ID  + " selected='selected'>" + data.list[i].SYS_ID+"=>"+data.list[i].PROJECT_NAME + "</option>");
                                } else {
                                    $("#projectId").append("<option value=" + data.list[i].PROJECT_ID  + ">" + data.list[i].SYS_ID+"=>"+data.list[i].PROJECT_NAME + "</option>");
                                }
                            }
                            downList('projectId');
                        }
                    }
                });

                var cg="${pd.PURCHASE_ID}";
                //采购合同编号
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>/projectpurchase/getCgAll.do?tm=' + new Date().getTime(),
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if (data.errInfo == "success") {
                            $("#cghetong").append("<option value=''>请选择采购合同编号</option>");
                            for (var i = 0; i < data.list.length; i++) {
                                if (data.list[i].PURCHASE_ID  == cg) {
                                    $("#cghetong").append("<option value=" +  data.list[i].PURCHASE_ID+"-"+data.list[i].CONTRACT_PRICE  + " selected='selected'>" + data.list[i].PURCHASE_CONTRACT_ID+"-"+data.list[i].PROJECTNAME + "</option>");
                                } else {
                                    $("#cghetong").append("<option value=" + data.list[i].PURCHASE_ID+"-"+data.list[i].CONTRACT_PRICE   + ">" + data.list[i].PURCHASE_CONTRACT_ID+"-"+data.list[i].PROJECTNAME + "</option>");
                                }
                            }
                            downList('cghetong');
                        }
                    }
                });




            }
            //截取字符串
            function jiequ(str){
                return str.substring(0,str.indexOf('-'));
            }
		$(function() {



            $("#cghetong").change(function (){
           		var str= $("#cghetong").val();
           		$("#PURCHASENUMBER").val(jiequ($("#cghetong option:selected").text()));
           		$("#JINPRICE").val(str.substring(str.indexOf("-")+1,str.length));

            })


            $("#projectId").change(function (){
                var str=$("#projectId option:selected").text();

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
                            $("#PROJECT_ID").val(str.substring(0,str.indexOf("=>")));
                        }
                    }
                });
            })
            getInfo();

            $("#LICENCE").change(function () {
                if ($("#LICENCE").val() == "其他") {
                    $("#xuanzeCompany").removeAttr("hidden");
                    $("#xuanzeCompany").val('');
                } else {
                    $("#xuanzeCompany").attr("hidden", "hidden");
                    $("#xuanzeCompany").val($("#LICENCE").val());
                }


            })
            getPath('<%=basePath%>');
            getAllFile("${pd.SYS_ID}");
            fuxuan();
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});

            var BUSINESS = "${pd.SELECTCOMPANY}";
            var tagbool = true;
            $.ajax({
                type: "POST",
                url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
                data: {DICTIONARIES_ID: 'cb8c6f2673bc4358b170efc7e2c6e309'},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $("#LICENCE").append("<option value=''>请选择类型</option>");
                    $.each(data.list, function (i, dvar) {
                        if (BUSINESS == dvar.NAME) {
                            tagbool = false;
                            $("#LICENCE").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                        } else {
                            $("#LICENCE").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                        }
                    });
                    if ($('#msg').val() == "edit") {
                        if (tagbool) {
                            $("#xuanzeCompany").removeAttr("hidden");
                            $("#xuanzeCompany").val(BUSINESS);
                            $("#LICENCE").val("其他");

                        }
                    }
                }
            });
		});
		</script>
<script src="searchableSelect/jquery.searchableSelect.js"></script>
</body>
</html>