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

                        <form action="hospital/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="HOSPITAL_ID" id="HOSPITAL_ID" value="${pd.HOSPITAL_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
                            <input type="hidden" name="oafileList" id="oafileList">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>医院编号:</td>
                                        <td><input readonly type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   maxlength="100" placeholder="这里输入医院编号" title="医院编号"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>区域:</td>
                                        <td><input type="text" name="ARER" id="ARER" value="${pd.ARER}" maxlength="50"
                                                   placeholder="这里输入区域" title="区域" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>医院全称:</td>
                                        <td><input type="text" name="HOSPITAL_NAME" id="HOSPITAL_NAME"
                                                   value="${pd.HOSPITAL_NAME}" maxlength="50" placeholder="这里输入医院全称"
                                                   title="医院全称" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>联系人:</td>
                                        <td><input type="text" name="LINKMAN" id="LINKMAN" value="${pd.LINKMAN}"
                                                   maxlength="50" placeholder="这里输入联系人" title="联系人" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>联系电话:</td>
                                        <td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}"
                                                   maxlength="20" placeholder="这里输入联系电话" title="联系电话"
                                                   style="width:98%;"/></td>
                                    </tr>
                                   <%-- <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">附件:</td>
                                        &lt;%&ndash;<td><input type="text" name="ACCESSORY" id="ACCESSORY" value="${pd.ACCESSORY}" maxlength="255" placeholder="这里输入附件" title="附件" style="width:98%;"/></td>&ndash;%&gt;
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
                                                                                <th class="center">文件大小</th>
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
                                                                                           onclick="add('${pd.HOSPITAL_ID}','6f24a1ad16dd48a0bc8e4599901419ec');">上传</a>
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
                                        <td style="width:75px;text-align: right;padding-top: 13px;">是否资料齐全:</td>
                                        <td>
                                            是<input type="radio" name="ISZILIAOQQ"  value="是" <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                            否<input type="radio" name="ISZILIAOQQ"  value="否" <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
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
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<!-- 上传附件 -->
<script src="upload/oaFile.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<script type="text/javascript">
    $(top.hangge());

    //保存
    function save() {
        if ($("#SYS_ID").val() == "") {
            $("#SYS_ID").tips({
                side: 3,
                msg: '请输入系统编序号',
                bg: '#AE81FF',
                time: 2
            });
            $("#SYS_ID").focus();
            return false;
        }
        if ($("#ARER").val() == "") {
            $("#ARER").tips({
                side: 3,
                msg: '请输入区域',
                bg: '#AE81FF',
                time: 2
            });
            $("#ARER").focus();
            return false;
        }
        if ($("#HOSPITAL_NAME").val() == "") {
            $("#HOSPITAL_NAME").tips({
                side: 3,
                msg: '请输入医院全称',
                bg: '#AE81FF',
                time: 2
            });
            $("#HOSPITAL_NAME").focus();
            return false;
        }
        if ($("#LINKMAN").val() == "") {
            $("#LINKMAN").tips({
                side: 3,
                msg: '请输入联系人',
                bg: '#AE81FF',
                time: 2
            });
            $("#LINKMAN").focus();
            return false;
        }
        if ($("#PHONE").val() == "") {
            $("#PHONE").tips({
                side: 3,
                msg: '请输入联系电话',
                bg: '#AE81FF',
                time: 2
            });
            $("#PHONE").focus();
            return false;
        }

        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
       /* localStorage.setItem("Identification", "save");*/
    }

    $(function () {

        if($("#msg").val()=="save"){
            $("#SYS_ID").val( getSysId('Y'));
        }

        top.hangge();


        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});


    });
</script>
</body>
</html>