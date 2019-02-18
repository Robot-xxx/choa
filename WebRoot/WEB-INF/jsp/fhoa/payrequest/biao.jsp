<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/static/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
	</head>
	<body style="background-color: white">
	<button style="background-color: #91b684;color: white;" onclick="window.print()">打印</button>
		<div style="margin: 0 auto;width:800px ;height:120px;">	
				<div style="width: 100%;height: 100%;">
					<div style="width: 100%;height: 50px;">
						<div style="text-align: center;line-height:50px;font-size: 25px;">
							付款申请书
						</div>
					</div>
					
					<div style="width: 550px;height: 50px; float: left;">
						<div style="line-height:75px;float: left;">
							付款申请编号：
						</div>
						<div style="line-height:75px;width: 50px;height: 20px;float: left;">
							<input value="${pd.REQUEST_NO}" style="width:400px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
					</div>
					<div style="width: 250px;height: 50px;float: left;">
						<div style="width: 80px;float: left;">
								<div style="line-height:25px;text-align: right;">
									申请日期：
								</div>					
								<div style="line-height:25px;text-align: right;">
									经办人：
								</div>
						</div>
						
						<div style="width: 170px;float: left;">
								<div style="float: left;line-height:25px;width: 170px;float: left;">
									<input value="${pd.REQUEST_DATE}"  style="width:150px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
								</div>
								<div style="float: left;line-height:25px;width: 170px;height: 20px;float: left;">
									<input value="${pd.RESPONSIBLEPERSON}" style="width:150px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
								</div>
						</div>		
					</div>
				</div>
				
				
				<!-- 线条<div style="width:100%;height:1px;border-bottom:1px solid #558db5"></div>			-->
		</div>
		<!--border:2px solid #558db5;-->
		<div style="width:850px;height: 100px;margin: 0 auto;">
			<div style="width:100%;height: 40px;text-align:center;">
				账号信息
				<hr style="width: 95%;border:1px solid #558db5;"/>
			</div>
			<div style="width: 120px; height: 100px;float: left;">
				<div style="text-align: right;float: left;width: 130px;">
					申请类型：
				</div>
				<div style="text-align: right;float: left;width: 130px;">
					<c:if test="${pd.ISHEZUO=='否'}">非合作单位：</c:if>
					<c:if test="${pd.ISHEZUO=='是'}">收款单位：</c:if>

				</div>
				<div style="text-align: right;float: left;width: 130px;">
					收款单位银行：
				</div>
				<div style="text-align: right;float: left;width: 130px;">
					附言：
				</div>
			</div>
			<div style="width: 305px; height: 100%;float: left;">
				<div style="float: left;width: 300px;">
					<input value="${pd.REQUEST_TYPE}"  style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>

				</div>
				<div style="text-align: right;float: left;width: 300px;">
                    <c:if test="${pd.ISHEZUO=='否'}">					<input  value="${pd.COMPANY_NAME}" style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </c:if>
                    <c:if test="${pd.ISHEZUO=='是'}">					<input  value="${pd.PAYEE}" style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </c:if>

                </div>
				<div style="text-align: right;float: left;width: 300px;">
					<input  value="${pd.PAYEEBANK}" style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
								
				</div>
				<div style="text-align: right;float: left;width: 700px;">
					<input value="${pd.POSTSCRIPT}" style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
								
				</div>
			</div>
			
			
			<div style="width: 120px; height: 60px;float: left;">
				<div style="text-align: right;float: left;width: 130px;">
					付款方式：
				</div>
				<div style="text-align: right;float: left;width: 130px;">
					银行账号：
				</div>
			</div>
			<div style="width: 300px; height: 100%;float: left;">
				<div style="float: left;width: 300px;">
					<input  value="${pd.PAY_METHOD}"  style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
				</div>

				<div style="text-align: right;float: left;width: 300px;">
					<input value="${pd.BANKACCOUNT}"  style="margin-left:5px;width:300px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
								
				</div>
				
			</div>
			<div style="width:850px;height: 100px;margin: 0 auto;">
				<div style="width:100%;height: 140px;text-align:center;">
					付款明细
					<hr style="width: 95%;border:1px solid #558db5;"/>
				</div>
				<div style="width: 120px; height: 60px;float: left;">
					<div style="text-align: right;float: left;width: 130px;">
						项目编号：
					</div>
					<div style="text-align: right;float: left;width: 130px;">
						项目名称：
					</div>
					<div style="text-align: right;float: left;width: 130px;">
						合同号：
					</div>
						<div style="text-align: right;float: left;width: 130px;">
						金额：
					</div>
					<%--<div style="text-align: right;float: left;width: 130px;">
						垫付金额：
					</div>
					<div style="text-align: right;float: left;width: 130px;">
						 来款单位：
					</div>--%>
					<div style="text-align: right;float: left;width: 130px;">
						预付款剩余金额：
					</div>
						<div style="text-align: right;float: left;width: 130px;">
						付款约定：
					</div>
				</div>
				<div style="width: 300px; height: 100%;float: left;">
					<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.PROJIECT_ID}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>
					<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.PROJECT_NAME}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>
						<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.CONTRACT_NO}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>
					<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.MONEY}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>
					<%--<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.PAY_ACCOUNT}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>
					<div style="text-align: right;float: left;width: 700px;">
						<input value="${pd.PAY_UNIT}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
									
					</div>--%>
					<div style="text-align: right;float: left;width: 700px;">
						<input type="text" value="${pd.YUYUEFUKUAN}"  style="margin-left:5px;width:700px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>

					</div>
					<div style="text-align: right;float: left;width: 700px;">
						<textarea  style="width: 100%; resize:none;">${pd.FUKUANYUEDING}</textarea>


					</div>
				</div>

			</div>

				<%--<div style="width:850px;height: 200px;margin-top: 280px;">
					<div style="width:100%;height:40px;text-align:center;">
						审批流程
						<hr style="width: 95%;border:1px solid #558db5;"/>
					</div>
						<div style="text-align: right;float: left;width: 190px;">
							经办人：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						<div style="text-align: right;float: left;width: 190px;">
							备注：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						
						<div style="text-align: right;float: left;width: 190px;">
							经办人经理：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						<div style="text-align: right;float: left;width: 190px;">
							备注：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						
						
						<div style="text-align: right;float: left;width: 190px;">
							质控：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						<div style="text-align: right;float: left;width: 190px;">
							备注：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						
						
						<div style="text-align: right;float: left;width: 190px;">
							运营：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						<div style="text-align: right;float: left;width: 190px;">
							备注：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						
						
							
						<div style="text-align: right;float: left;width: 190px;">
							财务：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						<div style="text-align: right;float: left;width: 190px;">
							备注：
						</div>
						<div style="text-align: left;float: left;width: 170px;">
							<input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
						</div>
						
				</div>--%>
			<%--<div style="width:850px;height: 120px;margin-top: 10px;">
                <div style="width:100%;height:40px;text-align:center;">
                    进项票情况
                    <hr style="width: 95%;border:1px solid #558db5;"/>
                </div>

                    <div style="text-align: right;float: left;width: 190px;">
                        发票号：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>
                    <div style="text-align: right;float: left;width: 190px;">
                        发票金额：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>

                    <div style="text-align: right;float: left;width: 190px;">
                        项目编号：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>
                    <div style="text-align: right;float: left;width: 190px;">
                        采购合同号：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>

                    <div style="text-align: right;float: left;width: 190px;">
                        付款约定：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>
                    <div style="text-align: right;float: left;width: 190px;">
                        备注：
                    </div>
                    <div style="text-align: left;float: left;width: 170px;">
                        <input  style="width:190px;border-bottom:1px solid #558db5;border-right: 0px;border-left: 0px;border-top: 0px;"/>
                    </div>

            </div>
        --%>
		</div>

	</body>
</html>
<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=basePath%>static/ace/js/jquery.js'>"+"<"+"/script>");
</script>
<!-- <![endif]-->
<!--[if IE]>
<script type="text/javascript">
	window.jQuery || document.write("<script src='<%=basePath%>static/ace/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='<%=basePath%>static/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");
</script>
<script src="../../../../static/ace/js/bootstrap.js"></script>


<!-- ace scripts -->
<script src="../../../../static/ace/js/ace/ace.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
    $(top.hangge());
</script>