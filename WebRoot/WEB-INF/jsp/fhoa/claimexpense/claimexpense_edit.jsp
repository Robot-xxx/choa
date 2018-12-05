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
					
					<form action="claimexpense/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="CLAIMEXPENSE_ID" id="CLAIMEXPENSE_ID" value="${pd.CLAIMEXPENSE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">报销类型:</td>
								<td>
									<select class="chosen-select form-control" name="TYPE_ID" id="TYPE_ID"
											style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input hidden type="text" name="TYPE" id="TYPE" value="${pd.TYPE}" maxlength="255"  title="报销类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">金额:</td>
								<td>
									<input type="text" name="MONEY" value="${pd.MONEY}" maxlength="100" placeholder="这里输入金额" title="金额" style="width:98%;">
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">日期:</td>
								<td>
									<input type="hidden" name="COST_ID" value="${pd.COST_ID}">
									<input class="span10 date-picker" name="DATE" id="DATE" value="${pd.DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="日期" title="日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">内容:</td>
								<td><input type="text" name="CONTEXT" id="CONTEXT" value="${pd.CONTEXT}" maxlength="255" placeholder="这里输入内容" title="内容" style="width:98%;"/></td>
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
		/*	if($("#DATE").val()==""){
				$("#DATE").tips({
					side:3,
		            msg:'请输入日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DATE").focus();
			return false;
			}
			if($("#CONTEXT").val()==""){
				$("#CONTEXT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTEXT").focus();
			return false;
			}
			if($("#JIAOTONGFEI").val()==""){
				$("#JIAOTONGFEI").tips({
					side:3,
		            msg:'请输入交通费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JIAOTONGFEI").focus();
			return false;
			}
			if($("#GAOTIEFEI").val()==""){
				$("#GAOTIEFEI").tips({
					side:3,
		            msg:'请输入高铁费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GAOTIEFEI").focus();
			return false;
			}
			if($("#FEIJIFEI").val()==""){
				$("#FEIJIFEI").tips({
					side:3,
		            msg:'请输入飞机费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FEIJIFEI").focus();
			return false;
			}
			if($("#LUQIAOFEI").val()==""){
				$("#LUQIAOFEI").tips({
					side:3,
		            msg:'请输入路桥费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LUQIAOFEI").focus();
			return false;
			}
			if($("#JIAYOUFEI").val()==""){
				$("#JIAYOUFEI").tips({
					side:3,
		            msg:'请输入加油费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JIAYOUFEI").focus();
			return false;
			}
			if($("#CANYINFEI").val()==""){
				$("#CANYINFEI").tips({
					side:3,
		            msg:'请输入餐饮费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CANYINFEI").focus();
			return false;
			}
			if($("#JIUSHUIFEI").val()==""){
				$("#JIUSHUIFEI").tips({
					side:3,
		            msg:'请输入酒水费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JIUSHUIFEI").focus();
			return false;
			}
			if($("#ZHUSUFEI").val()==""){
				$("#ZHUSUFEI").tips({
					side:3,
		            msg:'请输入住宿费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZHUSUFEI").focus();
			return false;
			}
			if($("#GONGGUANFEI").val()==""){
				$("#GONGGUANFEI").tips({
					side:3,
		            msg:'请输入公关费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GONGGUANFEI").focus();
			return false;
			}
			if($("#BIAOSHUFEI").val()==""){
				$("#BIAOSHUFEI").tips({
					side:3,
		            msg:'请输入标书费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIAOSHUFEI").focus();
			return false;
			}
			if($("#QITAFEI").val()==""){
				$("#QITAFEI").tips({
					side:3,
		            msg:'请输入其他费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#QITAFEI").focus();
			return false;
			}
			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入小计',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
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
			}*/
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});


			var str= '${pd.TYPE_ID}';
            $.ajax({
                type: "POST",
                url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
                data: {DICTIONARIES_ID: 'a68970fe3eea413fba61ce7064aa5a70'},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $("#TYPE_ID").append("<option value=''>请选择类型</option>");
                    $.each(data.list, function (i, dvar) {
                        if (str == dvar.BIANMA) {
                            $("#TYPE_ID").append("<option value=" + dvar.BIANMA + " selected='selected'>" + dvar.NAME + "</option>");
                        } else {
                            $("#TYPE_ID").append("<option value=" + dvar.BIANMA + ">" + dvar.NAME + "</option>");
                        }
                    });
                }
            });

            $("#TYPE_ID").change(function (){
                $("#TYPE").val($("#TYPE_ID option:selected").text());

			})


		});
		</script>
</body>
</html>