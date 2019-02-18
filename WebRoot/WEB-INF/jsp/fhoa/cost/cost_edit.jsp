<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
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

                        <form action="cost/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="COST_ID" id="COST_ID" value="${pd.COST_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
                            <input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS }">


                            <input type="hidden" name="oafileList" id="oafileList">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>是否代理商付款:
                                        </td>
                                        <%--<td><input type="text" name="IS_THEAGENT" id="IS_THEAGENT" value="${pd.IS_THEAGENT}" maxlength="50" placeholder="这里输入是否代理商付款" title="是否代理商付款" style="width:98%;"/></td>--%>
                                        <td align="left">
                                            是<input checked type="radio" name="IS_THEAGENT"
                                                    <c:if test="${pd.IS_THEAGENT==是}">checked</c:if> value="是"/>
                                            否<input type="radio" name="IS_THEAGENT"
                                                    <c:if test="${pd.IS_THEAGENT==否}">checked</c:if> value="否"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>费用类型:
                                        </td>
                                        <%--<td><input type="text" name="IS_THEAGENT" id="IS_THEAGENT" value="${pd.IS_THEAGENT}" maxlength="50" placeholder="这里输入是否代理商付款" title="是否代理商付款" style="width:98%;"/></td>--%>
                                        <td align="left">
                                            客户结算<input checked type="radio"  onchange="SelectChange('ISJIESUAN1')" id="ISJIESUAN1" class="ISJIESUAN" name="ISJIESUAN"
                                                       <c:if test="${pd.ISJIESUAN==1}">checked</c:if> value="1"/>
                                            日常<input onchange="SelectChange('ISJIESUAN2')" type="radio" id="ISJIESUAN2" class="ISJIESUAN" name="ISJIESUAN"
                                                     <c:if test="${pd.ISJIESUAN==0}">checked</c:if> value="0"/>
                                        </td>
                                    </tr>

                                    <tr id="projectIdTr" <c:if test="${pd.ISJIESUAN==0}">hidden</c:if> >
                                        <td style="width:75px;text-align: right;padding-top: 13px;">项目编号:</td>
                                        <td>
                                            <select class="chosen-select form-control" id="projectId"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input hidden type="text" name="PROJECT_ID" id="PROJECT_ID"
                                                   value="${pd.PROJECT_ID}" maxlength="100" placeholder="这里输入项目编号"
                                                   title="项目编号" style="width:98%;"/></td>
                                    </tr>
                                    <tr id="PROJECT_NAMETr" <c:if test="${pd.ISJIESUAN==0}">hidden</c:if>>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目名称:
                                        </td>
                                        <td><input type="text" readonly name="PROJECT_NAME" id="PROJECT_NAME"
                                                   value="${pd.PROJECT_NAME}" maxlength="100" placeholder="项目名称"
                                                   title="项目名称" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">部门:</td>
                                        <td><input name="DEPARTMENT" id="DEPARTMENT" value="${pd.DEPARTMENT}"
                                                   type="text" placeholder="部门" title="部门" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>日期:
                                        </td>
                                        <td><input class="span10 date-picker" name="CREATE_DATE" id="CREATE_DATE"
                                                   value="${pd.CREATE_DATE}" type="text" data-date-format="yyyy-mm-dd"
                                                   readonly="readonly" placeholder="日期" title="日期" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>报销人:
                                        </td>
                                        <td><input type="text" name="BXR" readonly id="BXR" value="${pd.BXR}"`
                                                   maxlength="50" placeholder="这里输入报销人" title="报销人" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>报销截止日期:
                                        </td>
                                        <td><input class="span10 date-picker" name="JIEZHIRIQI" id="JIEZHIRIQI"
                                                   value="${pd.JIEZHIRIQI}" type="text" data-date-format="yyyy-mm-dd"
                                                   readonly="readonly" placeholder="报销截止日期" title="报销截止日期" style="width:98%;"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255"
                                                   placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
                                    src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4>
                            </div>
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
<%@ include file="../../system/index/foot.jsp" %>
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
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>
<script type="text/javascript">
    $(top.hangge());

    //保存
    function save() {




        if ($("#CREATE_DATE").val() == "") {
            $("#CREATE_DATE").tips({
                side: 3,
                msg: '请输入日期',
                bg: '#AE81FF',
                time: 2
            });
            $("#CREATE_DATE").focus();
            return false;
        }
        if ($("#BXR").val() == "") {
            $("#BXR").tips({
                side: 3,
                msg: '请输入报销人',
                bg: '#AE81FF',
                time: 2
            });
            $("#BXR").focus();
            return false;
        }


        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
        localStorage.setItem("Identification", "save");
    }


    function getInfo() {
        var project = "${pd.PROJECT_ID}";

        //项目编号
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/getAllProject.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#projectId").append("<option value=''>请选择项目编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == project) {
                            $("#projectId").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        } else {
                            $("#projectId").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        }
                    }
                    downList('projectId');
                }
            }
        });
    }

    function SelectChange(obj){
        $("#projectIdTr").removeAttr("hidden");
        $("#PROJECT_NAMETr").removeAttr("hidden");
        if(  $("#"+obj+"").val()==0){
         $("#projectIdTr").attr("hidden","hidden");
         $("#PROJECT_NAMETr").attr("hidden","hidden");
        }
    }

    $(function () {




        getInfo();

        //项目编号
        $("#projectId").change(function () {
            var str = $("#projectId option:selected").text();
            $("#PROJECT_NAME").val(str.substr(str.indexOf("-") + 1, str.length));
            $("#PROJECT_ID").val($("#projectId").val());

        })


        getPath('<%=basePath%>');

        getAllFile("${pd.COST_ID}");
        fuxuan();
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});


    });
</script>
</body>
</html>