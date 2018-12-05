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
		<link href="plugins/uploadify/uploadify.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="static/ace/js/jquery.js"></script>
		<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
		<script type="text/javascript" src="plugins/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<!-- 上传插件 -->
		<script type="text/javascript">
            var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
		</script>
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
					
					<form action="invoice/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"/>
						<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${pd.PARENT_ID}"/>

						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>期数:</td>
								<td><input type="text" name="BY_STAGES" id="BY_STAGES" value="${pd.BY_STAGES}" maxlength="100" placeholder="这里输入分期" title="分期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>发票号码:</td>
								<td><input type="text" name="INVOICENUMBER" id="INVOICENUMBER" value="${pd.INVOICENUMBER}" maxlength="100" placeholder="这里输入发票号码" title="发票号码" style="width:98%;"/></td>
							</tr>
						<%--	<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>--%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">金额:</td>
								<td><input type="number" name="MONEY" id="MONEY" value="${pd.MONEY}" maxlength="32" placeholder="这里输入分期金额" title="分期金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>文件名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="100" placeholder="这里输入文件名称" title="文件名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" id="FILEPATHn">文件:</td>
								<td>
									<input type="file" name="File_name" id="uploadify1" keepDefaultStyle = "true"/>
									<input type="hidden" name="FILEPATH" id="FILEPATH" value=""/>
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
		<script type="text/javascript">


            var str='';
            $("#uploadify1").uploadify({
                'buttonImg'	: 	"<%=basePath%>static/images/fileup.png",
                'uploader'	:	"<%=basePath%>plugins/uploadify/uploadify.swf",
                'script'    :	"<%=basePath%>plugins/uploadify/uploadFile.jsp;jsessionid="+jsessionid,
                'cancelImg' :	"<%=basePath%>plugins/uploadify/cancel.png",
                'folder'	:	"<%=basePath%>uploadFiles/uploadFile",//上传文件存放的路径,请保持与uploadFile.jsp中PATH的值相同
                'queueId'	:	"fileQueue",
                'queueSizeLimit'	:	1,//限制上传文件的数量
                //'fileExt'	:	"*.rar,*.zip",
                //'fileDesc'	:	"RAR *.rar",//限制文件类型
                'fileExt'     : '*.*;*.*;*.*',
                'fileDesc'    : 'Please choose(.*, .*, .*)',
                'auto'		:	false,
                'multi'		:	true,//是否允许多文件上传
                'simUploadLimit':	2,//同时运行上传的进程数量
                'buttonText':	"files",
                'scriptData':	{'uploadPath':'/uploadFiles/uploadFile/'},//这个参数用于传递用户自己的参数，此时'method' 必须设置为GET, 后台可以用request.getParameter('name')获取名字的值
                'method'	:	"GET",
                'onComplete':function(event,queueId,fileObj,response,data){
                    str = response.trim();//单个上传完毕执行
                },
                'onAllComplete' : function(event,data) {
                    //alert(str);	//全部上传完毕执行
                    $("#FILEPATH").val(str);
                    $("#Form").submit();
                    $("#zhongxin").hide();
                    $("#zhongxin2").show();
                },
                'onSelect' : function(event, queueId, fileObj){
                    $("#hasTp1").val("ok");
                }
            });




		$(top.hangge());
		//保存
		function save(){
			if($("#BY_STAGES").val()==""){
				$("#BY_STAGES").tips({
					side:3,
		            msg:'请输入分期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BY_STAGES").focus();
			return false;
			}
			if($("#INVOICENUMBER").val()==""){
				$("#INVOICENUMBER").tips({
					side:3,
		            msg:'请输入发票号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENUMBER").focus();
			return false;
			}

			if($("#MONEY").val()==""){
				$("#MONEY").tips({
					side:3,
		            msg:'请输入分期金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MONEY").focus();
			return false;
			}
            $('#uploadify1').uploadifyUpload();


		}
            String.prototype.trim=function(){
                return this.replace(/(^\s*)|(\s*$)/g,'');
            };
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});




		</script>
</body>
</html>