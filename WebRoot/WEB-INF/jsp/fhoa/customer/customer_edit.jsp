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

                        <form action="customer/${msg }.do" name="Form" id="Form1" method="post">
                            <input type="hidden" name="CUSTOMER_ID" id="CUSTOMER_ID" value="${pd.CUSTOMER_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
                            <input type="hidden" name="oafileList" id="oafileList">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <%--	<tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">主键:</td>
                                            <td><input type="text" name="CUSTOMER_ID" id="CUSTOMER_ID" value="${pd.CUSTOMER_ID}" maxlength="100" placeholder="这里输入备注1" title="备注1" style="width:98%;"/></td>
                                        </tr>--%>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>客户序号:</td>
                                        <td><input readonly="readonly" type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   maxlength="30" placeholder="" title="系统编序号"
                                                   style="width:98%;"/></td>
                                    </tr>
                                       <%-- <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">医院编号:</td>
                                            <td>
                                                <select class="chosen-select form-control"  id="k_selectCompany" data-placeholder="医院编号" style="vertical-align:top;width: 68px;">

                                                </select>
                                                <input type="text" hidden name="HOSPITAL_ID" id="HOSPITAL_ID" value="${pd.HOSPITAL_ID}"
                                                       maxlength="100" placeholder="这里输入医院" title="医院" style="width:98%;"/>
                                            </td>
                                        </tr>--%>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>公司全称:</td>
                                        <td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME"
                                                   value="${pd.COMPANY_NAME}" maxlength="50" placeholder="这里输入公司全称"
                                                   title="公司全称" style="width:98%;"/></td>
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
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">税号:</td>
                                        <td><input type="text" name="DUTY_PARAGRAPH" id="DUTY_PARAGRAPH"
                                                   value="${pd.DUTY_PARAGRAPH}" maxlength="150" placeholder="这里输入税号"
                                                   title="税号" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">开户行:</td>
                                        <td><input type="text" name="OPENING_BANK" id="OPENING_BANK"
                                                   value="${pd.OPENING_BANK}" maxlength="150" placeholder="这里输入开户行"
                                                   title="开户行" style="width:98%;"/></td>
                                    </tr>
                                        <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">开户行账号:</td>
                                        <td><input type="text" name="BANKACCOUNT" id="BANKACCOUNT"
                                                   value="${pd.BANKACCOUNT}" maxlength="150" placeholder="这里输入开户行账号"
                                                   title="开户行账号" style="width:98%;"/></td>
                                    </tr>
                                        <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">生产许可证到期日:</td>
                                            <td>
                                                <input placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly class="span10 date-picker" type="text" name="SHENGCHANXUKEZHENG" id="SHENGCHANXUKEZHENG" value="${pd.SHENGCHANXUKEZHENG}" maxlength="100" style="width:98%;"/>
                                                <span style="color:red;">注:请认真对证件是否过期</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">经营许可证到期日:</td>
                                            <td>
                                                <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly class="span10 date-picker" type="text" name="JINGYINGXUKEZHENG" id="JINGYINGXUKEZHENG" value="${pd.JINGYINGXUKEZHENG}" maxlength="100" style="width:98%;"/>
                                                <span style="color:red;">注:请认真对证件是否过期</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">法人授权书到期日:</td>
                                            <td>
                                                <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly class="span10 date-picker" type="text" name="FARENSHOUQUAN" id="FARENSHOUQUAN" value="${pd.FARENSHOUQUAN}" maxlength="100" style="width:98%;"/>
                                                <span style="color:red;">注:请认真对证件是否过期</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;">授权委托书到期日:</td>
                                            <td>
                                                <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly class="span10 date-picker" type="text" name="SHOUQUANWEITUO" id="SHOUQUANWEITUO" value="${pd.SHOUQUANWEITUO}" maxlength="100" style="width:98%;"/>
                                                <span style="color:red;">注:请认真对证件是否过期</span>
                                            </td>
                                        </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">医疗许可证:</td>
                                        <td>
                                            <select name="LICENCE" id="LICENCE" title="医疗许可证"
                                                    style="width:98%;"></select>
                                        </td>
                                    </tr>
                                    <%--<tr>
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
                                                                                           onclick="add('${pd.CUSTOMER_ID}','cf29c9db335046c58071d5dfc84d3d21');">上传</a>
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
                                                                <!-- /.col -->
                                                            </div>
                                                            <!-- /.row -->
                                                        </div>
                                                        <!-- /.page-content -->
                                                    </div>
                                                </div>
                                                <!-- /.main-content -->

                                                <!-- 返回顶部 -->
                                                <a href="#" id="btn-scroll-up"
                                                   class="btn-scroll-up btn btn-sm btn-inverse">
                                                    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
                                                </a>

                                            </div>

                                        </td>

                                    </tr>--%>

                                        <tr>
                                            <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>是否资料齐全:</td>
                                            <td>
                                                是<input type="radio" name="ISZILIAOQQ"  value="是" <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                                否<input type="radio" name="ISZILIAOQQ"  value="否" <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
                                            </td>
                                        </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="BZ" id="BZ" value="${pd.BZ}" maxlength="255"
                                                   placeholder="这里输入备注" title="备注" style="width:98%;"/>
                                            <span style="color: red;">注:如为资料更新,请明写更新资料</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                                            <a class="btn btn-mini btn-danger" onclick="  top.Dialog.close()">取消</a>
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
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!-- 上传附件 -->
<script src="upload/oaFile.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>

<script type="text/javascript">






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
        if ($("#COMPANY_NAME").val() == "") {
            $("#COMPANY_NAME").tips({
                side: 3,
                msg: '请输入公司全称',
                bg: '#AE81FF',
                time: 2
            });
            $("#COMPANY_NAME").focus();
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


       /* if ($("#LICENCE").val() == "") {
            $("#LICENCE").tips({
                side: 3,
                msg: '请选择医疗许可证',
                bg: '#AE81FF',
                time: 2
            });
            $("#LICENCE").focus();
            return false;
        }*/
        if ($("#ACCESSORY").val() == "") {
            $("#ACCESSORY").tips({
                side: 3,
                msg: '请上传附件',
                bg: '#AE81FF',
                time: 2
            });
            $("#ACCESSORY").focus();
            return false;
        }
    /*    if ($("#BZ").val() == "") {
            $("#BZ").tips({
                side: 3,
                msg: '请输入备注',
                bg: '#AE81FF',
                time: 2
            });
            $("#BZ").focus();
            return false;
        }*/
        $("#Form1").submit();


        $("#zhongxin").hide();
        $("#zhongxin2").show();
        //localStorage.setItem("Identification", "save");

    }

    $(function () {

        var kh="${pd.HOSPITAL_ID}";
console.log(kh);
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/k_ClienteleAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#k_selectCompany").append("<option value=''>请选择医院编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID  == kh) {
                            $("#k_selectCompany").append("<option value=" +  data.list[i].SYS_ID+"@"+data.list[i].HOSPITAL_NAME+"#"+data.list[i].LINKMAN+"="+data.list[i].PHONE+ " selected='selected'>"  + data.list[i].SYS_ID+"-"+data.list[i].HOSPITAL_NAME+"</option>");
                        } else {
                            $("#k_selectCompany").append("<option value=" + data.list[i].SYS_ID+"@"+data.list[i].HOSPITAL_NAME+"#"+data.list[i].LINKMAN+"="+data.list[i].PHONE + ">"  + data.list[i].SYS_ID+"-"+data.list[i].HOSPITAL_NAME+"</option>");
                        }
                    }
                    downList('k_selectCompany');
                }
            }
        });

        //医院信息
        $("#k_selectCompany").change(function (){
            var str =$("#k_selectCompany").val();
console.log(str);
            $("#COMPANY_NAME").val(str.substring(str.indexOf("@")+1,str.indexOf("#")));
            $("#LINKMAN").val(str.substring(str.indexOf("#")+1,str.indexOf("=")));
            $("#PHONE").val(str.substring(str.indexOf("=")+1,str.length));
            $("#HOSPITAL_ID").val(str.substring(0,str.indexOf("@")));

        })

        if($("#msg").val()=="save"){
            $("#SYS_ID").val( getSysId('K'));
        }


        top.hangge();

        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});

        var LICENCE = "${pd.LICENCE}";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
            data: {DICTIONARIES_ID: '5696fb6f00b54056839fbc1acdbb166d'},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#LICENCE").append("<option value=''>请选择类型</option>");
                $.each(data.list, function (i, dvar) {
                    if (LICENCE == dvar.BIANMA) {
                        $("#LICENCE").append("<option value=" + dvar.BIANMA + " selected='selected'>" + dvar.NAME + "</option>");
                    } else {
                        $("#LICENCE").append("<option value=" + dvar.BIANMA + ">" + dvar.NAME + "</option>");
                    }
                });
            }
        });

    });
</script>
</body>
</html>