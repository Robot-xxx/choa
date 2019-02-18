<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="tongji/bootstrap.min.css" />
	<link rel="stylesheet" href="yetep/css/ystep.css">

	<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<script type="text/javascript">
setTimeout("top.hangge()",500);
</script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎使用 OA;
							</div>
							
							


							
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->

					<div class="ystep4" style="width: 100%"></div>
					<div class="ystep5" style="width: 100%"></div>



			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script src="tongji/bootstrap.min.js"></script>
	<script src="tongji/jquery.min.js"></script>
		<script src="yetep/js/ystep.js"></script>





		<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
        //根据jQuery选择器找到需要加载ystep的容器
        //loadStep 方法可以初始化ystep

        $(".ystep4").loadStep({
            size: "small",
            color: "blue",
            steps: [{
                title: "项目立项",
                content: "接到项目后立项"
            },{
                title: "首营资料",
                content: "在合作方管理、产品管理处填写首营资料并通过质控审批后方可进行投标、销售、采购等流程"
            },{
                title: "项目投标",
                content: "填写投标相关的基本信息，具体要求详见流程图"
            },{
                title: "项目销售",
                content: "填写销售相关的基本信息，具体要求详见流程图"
            },{
                title: "项目采购",
                content: "填写采购相关的基本信息，具体要求详见流程图"
            }]
        });
        $(".ystep5").loadStep({
            size: "small",
            color: "blue",
            steps: [{
                title: "付款申请",
                content: "填写上游管理并通过审批后方可进行（非合作方请在非合作方管理处填写，无需审批），需要部门经理（运营部）审批后方可打印付款申请单"
            },{
                title: "认款管理",
                content: "需先完成项目立项。填写回款基本信息，点击认款认领对应款项，并上传银行底单"
            },{
                title: "进项票",
                content: "需先完成立项流程与采购合同流程。填写进项票情况，下载模板并填写完成后，将其上传到附件处，等待审批流程完成"
            },{
                title: "开票",
                content: "需先完成立项流程、采购合同流程和销售合同流程。填写开票情况，下载模板并填写完成后，将其上传到附件处，等待审批流程完成"
            },{
                title: "报销流程",
                content: "若为项目相关报销则需先完成立项流程"
            }]
        });
        $(".ystep4").setStep(5);
        $(".ystep5").setStep(5);


	</script>


<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>