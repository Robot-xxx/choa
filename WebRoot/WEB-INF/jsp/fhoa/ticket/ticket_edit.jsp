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
					
					<form action="ticket/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TICKET_ID" id="TICKET_ID" value="${pd.TICKET_ID}"/>
						<input type="hidden" name="msg" id="msg" value="${msg }"/>
						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID }">
						<input type="hidden" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME }">
						<input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS }">
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
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>开票编号:</td>
								<td><input type="text" readonly name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}" maxlength="100" placeholder="这里输入开票编号" title="开票编号" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>采购合同:</td>
								<td>
									<select class="chosen-select form-control"  id="jinxiang" style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input type="text" hidden name="ENTRYTICKETNAME" id="ENTRYTICKETNAME" value="${pd.ENTRYTICKETNAME}" maxlength="255"  style="width:98%;"/>
									<input type="text" hidden name="JINXIANGID" id="JINXIANGID" value="${pd.JINXIANGID}" maxlength="255"  style="width:98%;"/>
								</td>



							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>进项票总额(元):</td>
								<td><input type="text" name="TICKET_PRICE" id="TICKET_PRICE" value="${pd.TICKET_PRICE}" maxlength="12" placeholder="这里输入进项票金额(元)" title="进项票金额(元)" style="width:98%;"/></td>
							</tr>


							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>销售合同:</td>
								<td>
									<select class="chosen-select form-control"  id="xiaoshou" style="vertical-align:top;width: 68px; width: 98%">

									</select>
									<input type="text" hidden name="SALES_CONTRACT_ID" id="SALES_CONTRACT_ID" value="${pd.SALES_CONTRACT_ID}" maxlength="255"  style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>合同总额(元):</td>
								<td><input type="text" name="OPEN_TICKET_PRICE" id="OPEN_TICKET_PRICE" value="${pd.OPEN_TICKET_PRICE}" maxlength="11" placeholder="这里输入合同总额" title="合同总额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>开票金额:</td>
								<td><input type="text" name="KAIPIAOJINE" id="KAIPIAOJINE" value="${pd.KAIPIAOJINE}" maxlength="255" placeholder="这里输入开票金额" title="开票金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>已开票金额:</td>
								<td><input type="text" name="YIKAIPIAOJINE" id="YIKAIPIAOJINE" value="${pd.YIKAIPIAOJINE}" maxlength="255" placeholder="这里输入已开票金额" title="已开票金额" style="width:98%;"/></td>
							</tr>
                            <tr>
                                <td style="width:75px;text-align: right;padding-top: 13px;">进项票备注:</td>
                                <td><input type="text" name="TICKET_INFO" id="TICKET_INFO" value="${pd.TICKET_INFO}" maxlength="255" placeholder="这里输入进项票备注" title="进项票备注" style="width:98%;"/></td>
                            </tr>

                            <tr>
                            <td style="width:75px;text-align: right;padding-top: 13px;">开票原因:</td>
                            <td><input type="text" name="OPEN_TICKET_YUANYIN" id="OPEN_TICKET_YUANYIN" value="${pd.OPEN_TICKET_YUANYIN}" maxlength="255" placeholder="开票原因" title="开票原因" style="width:98%;"/>
								<span style="color: red">注：请注明回款时间</span>
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

<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>
<script type="text/javascript">



		$(top.hangge());
		//保存
		function save(){
			if($("#xuanzeCompany").val()==""){
				$("#xuanzeCompany").tips({
					side:3,
		            msg:'请选择公司',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#xuanzeCompany").focus();
			return false;
			}
		if($("#SYS_ID").val()==""){
				$("#SYS_ID").tips({
					side:3,
		            msg:'开票编号不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SYS_ID").focus();
			return false;
			}
		if($("#jinxiang").val()==""){
				$("#jinxiang").tips({
					side:3,
		            msg:'采购合同不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#jinxiang").focus();
			return false;
			}
		if($("#TICKET_PRICE").val()==""){
				$("#TICKET_PRICE").tips({
					side:3,
		            msg:'进项票总额不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TICKET_PRICE").focus();
			return false;
			}
		if($("#xiaoshou").val()==""){
				$("#xiaoshou").tips({
					side:3,
		            msg:'销售合同不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#xiaoshou").focus();
			return false;
			}
		if($("#OPEN_TICKET_PRICE").val()==""){
				$("#OPEN_TICKET_PRICE").tips({
					side:3,
		            msg:'合同总额不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OPEN_TICKET_PRICE").focus();
			return false;
			}
		if($("#KAIPIAOJINE").val()==""){
				$("#KAIPIAOJINE").tips({
					side:3,
		            msg:'开票金额不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#KAIPIAOJINE").focus();
			return false;
			}
		if($("#YIKAIPIAOJINE").val()==""){
				$("#YIKAIPIAOJINE").tips({
					side:3,
		            msg:'已开票金额不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#YIKAIPIAOJINE").focus();
			return false;
			}



			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

        function getInfo(){
            var project="${pd.JINXIANGID}";

            //获取采购合同
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/projectpurchase/getCgAll.do?tag=inputticket&tm=' + new Date().getTime(),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
				$("#jinxiang").append("<option value=''>请选择采购合同</option>");
			for (var i = 0; i < data.list.length; i++) {
				if (data.list[i].SYS_ID  == project) {
					$("#jinxiang").append("<option value=" +  data.list[i].PURCHASE_ID  +"=》"+data.list[i].CONTRACT_PRICE+ " selected='selected'>" +data.list[i].SYS_ID +"=》"+data.list[i].PROJECTNAME +"</option>");
				} else {
					$("#jinxiang").append("<option value=" + data.list[i].PURCHASE_ID  +"=》"+data.list[i].CONTRACT_PRICE+ ">" +data.list[i].SYS_ID +"=》"+data.list[i].PROJECTNAME+ "</option>");
				}
			}
			downList('jinxiang');
		}
		}
		});


		var SALES_CONTRACT_ID="${pd.SALES_CONTRACT_ID}";

		//获取销售合同
		$.ajax({
                type: "POST",
                url: '<%=basePath%>/projectmarket/getMarketAll.do?tag=ticket&tm=' + new Date().getTime(),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#xiaoshou").append("<option value=''>请选择销售合同</option>");
                        for (var i = 0; i < data.list.length; i++) {
                            if (data.list[i].SALES_CONTRACT_ID  == SALES_CONTRACT_ID) {
                                $("#xiaoshou").append("<option value=" +  data.list[i].CONTRACT_PRICE  +"=》"+ data.list[i].SALES_CONTRACT_ID + " selected='selected'>" +data.list[i].SYS_ID+"=》"+data.list[i].PROJECT_NAME+ "</option>");
                            } else {
                                $("#xiaoshou").append("<option value=" +data.list[i].CONTRACT_PRICE  +"=》"+ data.list[i].SALES_CONTRACT_ID  + ">" +data.list[i].SYS_ID+"=》"+data.list[i].PROJECT_NAME+  "</option>");
                            }
                        }
                        downList('xiaoshou');
                    }
                }
            });

        }

		$(function() {

            //选择进项票信息
            $("#jinxiang").change(function (){
                $("#TICKET_PRICE").val('');
                $("#TICKET_INFO").val('');
                $("#ENTRYTICKETNAME").val('');
                $("#JINXIANGID").val('');
				var str1 =$("#jinxiang").val();
				$("#TICKET_PRICE").val(str1.substring(str1.indexOf("=》")+2,str1.length))
				console.log(str1.substring(0,str1.indexOf("=》")))
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>/inputticket/getJinxXiangById.do?SYS_ID=' + str1.substring(0,str1.indexOf("=》")),
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if (data.errInfo == "success") {
                        	console.log(JSON.stringify(data))
                            $("#TICKET_PRICE").val(data.pd.JINPRICE);
                            $("#TICKET_INFO").val(data.pd.JINBZ);
                            $("#ENTRYTICKETNAME").val($("#jinxiang option:selected").text());
                            $("#JINXIANGID").val($("#jinxiang").val());
                        }
                    }
                });
            })

            //选择销售合同
            $("#xiaoshou").change(function (){
				var str1= $("#xiaoshou option:selected").text();

				var str2= $("#xiaoshou").val();
                $("#SALES_CONTRACT_ID").val(str2.substring(str2.indexOf("=》")+2,str1.length)+"-"+str1.substring(str1.indexOf("=》")+2,str1.length));

                $("#OPEN_TICKET_PRICE").val(str2.substring(0,str2.indexOf("=》")));

                $("#PROJECT_ID").val(str1.substring(0,str1.indexOf("=》")))

                $("#PROJECT_NAME").val(str1.substring(str1.indexOf("=》")+2,str1.length))


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

            if($("#msg").val()=="save"){
                $("#SYS_ID").val( getSysId('K'));
            }

			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});

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
		</script>
</body>
</html>