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
    th{
        text-align: center;
    }
    td{
        text-align: center;
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
                <th colspan="8"><h2>项目结算单</h2></th>
            </tr>
            <tr style="background-color: #fbf8e5">
                <th>项目编号</th>
                <th>项目名称</th>
                <th>项目负责人</th>
                <th>中标金额</th>
                <th>项目回款金额</th>
                <th>尾款时间</th>
            </tr>
            <tr>
                <td>${pd.PROJECT_ID}</td>
                <td>${pd.PROJECT_NAME}</td>
                <td>${pd.PROJECT_MAN}</td>
                <td>${pd.BID_PRICE}</td>
                <td>${pd.PROJECT_MONEY}</td>
                <td>${pd.DATE}</td>
            </tr>
            <tr style="background-color: #e2efda">

                <th>成本</th>
                <th>费用名称</th>
                <th>金额</th>
                <th>支付时间</th>
                <th>退回时间</th>
                <th>备注</th>
            </tr>
            <c:choose>
                <c:when test="${not empty map}">

                      <c:forEach items="${map.l}" var="var" varStatus="vs">
                          <tr>
                              <td style="text-align: center">成本</td>
                                <td style="text-align: center">投标保证金</td>
                                <td style="text-align: center">${var.GUARANTEE_MONEY}</td>
                                <td style="text-align: center">${var.END_TIME_}</td>
                                <td style="text-align: center"><input type="text"></td>
                                <td style="text-align: center"><input type="text"></td>


                          </tr>
                        </c:forEach>
                        <c:forEach items="${map.l1}" var="var" varStatus="vs">
                            <tr>
                                <td style="text-align: center">成本</td>
                            <td style="text-align: center">中标服务费</td>
                            <td style="text-align: center">${var.SERVICE_PRICE}</td>
                            <td style="text-align: center">${var.END_TIME_}</td>
                            <td style="text-align: center"><input type="text"></td>
                            <td style="text-align: center"><input type="text"></td>
                            </tr>
                        </c:forEach>
                        <c:forEach items="${map.l2}" var="var" varStatus="vs">
                            <tr>
                                <td style="text-align: center">成本</td>
                            <td style="text-align: center">采购成本</td>
                            <td style="text-align: center">${var.CONTRACT_PRICE}</td>
                            <td style="text-align: center">${var.END_TIME_}</td>
                            <td style="text-align: center"><input type="text"></td>
                            <td style="text-align: center"><input type="text"></td>
                            </tr>
                        </c:forEach>
                        <c:forEach items="${map.l3}" var="var" varStatus="vs">
                        <tr>
                            <td style="text-align: center">成本</td>
                            <td style="text-align: center">报销成本</td>
                            <td style="text-align: center">${var.MONEY}</td>
                            <td style="text-align: center">${var.END_TIME_}</td>
                            <td style="text-align: center"><input type="text"></td>
                            <td style="text-align: center"><input type="text"></td>
                        </tr>
                        </c:forEach>
                    <tr>
                        <td style="text-align: center">成本总额:</td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center">${map.count}</td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center" >没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>



        </table>

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