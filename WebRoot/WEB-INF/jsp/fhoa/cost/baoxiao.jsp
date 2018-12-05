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
<style>
    td{
        text-align: right;
    }
    .val{
        text-align: left;
    }
table td{
   border-bottom: 1px solid black;
}
</style>
<body style="background-color: white">
    <div >
        <button style="background-color: #91b684;color: white;" onclick="window.print()">打印</button>
        <table  style="width: 100%;" >
            <tr>
                <th colspan="8">费用报销单（客户结算□日常□）</th>
            </tr>
            <tr>
                <td>报销时间:</td>
                <td class="val">${pd.CREATE_DATE}</td>
                <td>项目编号:</td>
                <td class="val">${pd.PROJECT_ID}</td>
                <td>项目名称:</td>
                <td class="val">${pd.PROJECT_NAME}</td>
                <td style="text-align: center" colspan="2">单据及附件</td>
            </tr>
            <tr>
                <td>报销部门:</td>
                <td class="val">${pd.DEPARTMENT}</td>
                <td>报销人:</td>
                <td class="val" colspan="3">${pd.BXR}</td>

                <td>报销费用起止时间:</td>
                <td class="val">${pd.CREATE_DATE}</td>
            </tr>
            <tr style="text-align: center">
                <td style="text-align: center">报销类型</td>
                <td style="text-align: center">日期</td>
                <td style="text-align: center">金额</td>
                <td style="text-align: center" colspan="3">内容</td>
                <td style="text-align: center" colspan="2">备注</td>
            </tr>

            <c:choose>
                <c:when test="${not empty list}">

                        <c:forEach items="${list}" var="var" varStatus="vs">
                            <tr>

                                <td style="text-align: center">${var.TYPE}</td>
                                <td style="text-align: center">${var.DATE}</td>
                                <td style="text-align: center">${var.MONEY}</td>
                                <td  style="text-align: center" colspan="3">${var.CONTEXT}</td>

                                <td  style="text-align: center" colspan="2">${var.BZ}</td>

                            </tr>

                        </c:forEach>

                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center" >没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>

        </table>
        <hr style="color: black">
        <div>
        <table width="100%">
            <tr>
                <th style="text-align: center">费用名称</th>
                <th style="text-align: center"></th>
                <th style="text-align: center"></th>
                <th style="text-align: center"></th>
                <th style="text-align: center">费用总额</th>
            </tr>

            <c:choose>
                <c:when test="${not empty map}">

                    <c:forEach  var="m" items="${map}" begin="0"  varStatus="status">
                        <tr>
                            <td style="text-align: center">${m.key}</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: center">${m.value}</td>
                        </tr>
                    </c:forEach>

                    <tr>
                        <td style="text-align: center"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td style="text-align: center">总计：${zong}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center" >没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            <tr>
                <th style="text-align: center">报销人:</th>
                <th style="text-align: center">部门经理审核:</th>
                <th style="text-align: center">财务复核:</th>
                <th style="text-align: center">领导审批:</th>
                <th style="text-align: center">出纳:</th>
            </tr>
        </table>
        </div>
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