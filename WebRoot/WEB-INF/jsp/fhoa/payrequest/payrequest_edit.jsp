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

                        <form action="payrequest/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="REQUEST_ID" id="REQUEST_ID" value="${pd.REQUEST_ID}"/>
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
                                        <td style="width:75px;text-align: right;padding-top: 13px;">付款申请编号:</td>
                                        <td><input type="text" name="REQUEST_NO" readonly id="REQUEST_NO"
                                                   value="${pd.REQUEST_NO}" maxlength="100" placeholder="这里输入付款申请编号"
                                                   title="付款申请编号" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">申请日期:</td>
                                        <td><input class="span10 date-picker" name="REQUEST_DATE" id="REQUEST_DATE"
                                                   value="${pd.REQUEST_DATE}" type="text" data-date-format="yyyy-mm-dd"
                                                   readonly="readonly" placeholder="申请日期" title="申请日期"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>经办人:
                                        </td>
                                        <td><input readonly type="text" name="RESPONSIBLEPERSON" id="RESPONSIBLEPERSON"
                                                   value="${pd.RESPONSIBLEPERSON}" maxlength="50" placeholder="这里输入经办人"
                                                   title="经办人" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>申请类型:
                                        </td>
                                        <td>
                                            <select name="requesttype" id="requesttype" title=""
                                                    style="width:38%;"></select>
                                            <input hidden type="text" name="REQUEST_TYPE" id="REQUEST_TYPE"
                                                   value="${pd.REQUEST_TYPE}" maxlength="50" placeholder="这里输入申请类型"
                                                   title="申请类型" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>支付方式:
                                        </td>
                                        <td>
                                            <select name="paymethod" id="paymethod" title=""
                                                    style="width:38%;"></select>
                                            <input hidden type="text" name="PAY_METHOD" id="PAY_METHOD"
                                                   value="${pd.PAY_METHOD}" maxlength="50" placeholder="这里输入支付方式"
                                                   title="支付方式" style="width:98%;"/></td>
                                    </tr>
                                    <%--     <tr>
                                             <td style="width:75px;text-align: right;padding-top: 13px;">账户类型:</td>
                                             <td>
                                                 <select name="paytype" id="paytype" title=""
                                                         style="width:38%;"></select>
                                                 <input hidden type="text" name="ACCOUNT_TYPE" id="ACCOUNT_TYPE"
                                                        value="${pd.ACCOUNT_TYPE}" maxlength="50" style="width:98%;"/></td>
                                         </tr>--%>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">是否合作方</td>
                                        <td>
                                            <select id="IsHeZuo" name="ISHEZUO">
                                                <option value="是">是</option>
                                                <option value="否">否</option>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr hidden id="hiddenTr1">
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>非合作方:
                                        </td>
                                        <td>
                                            <select class="chosen-select form-control" id="PARTNERS1"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input hidden type="text" name="PARTNERS" id="PARTNERS"
                                                   value="${pd.PARTNERS}"
                                                   maxlength="255" placeholder="非合作方" title="非合作方"
                                                   style="width:98%;"/>
                                            <input hidden type="text" name="COMPANY_NAME" id="COMPANY_NAME"
                                                   value="${pd.COMPANY_NAME}"
                                                   maxlength="255" placeholder="非合作方" title="非合作方"
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>


                                    <tr id="hiddenTr">
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>收款单位:
                                        </td>
                                        <td>
                                            <select class="chosen-select form-control" name="PAYEE_ID"
                                                    id="gongyingshang"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input hidden type="text" name="PAYEE" id="PAYEE" value="${pd.PAYEE}"
                                                   maxlength="255" placeholder="这里输入收款单位" title="收款单位"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <%--   <tr>
                                           <td style="width:75px;text-align: right;padding-top: 13px;">收款单位地址:</td>
                                           <td><input type="text" name="PAYEEADDRESS" id="PAYEEADDRESS"
                                                      value="${pd.PAYEEADDRESS}" maxlength="255" placeholder="这里输入收款单位地址"
                                                      title="收款单位地址" style="width:98%;"/></td>
                                       </tr>--%>


                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>收款单位银行:
                                        </td>
                                        <td><input type="text" name="PAYEEBANK" id="PAYEEBANK" value="${pd.PAYEEBANK}"
                                                   maxlength="255" placeholder="这里输入收款单位银行" title="收款单位银行"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>银行账号:
                                        </td>
                                        <td><input type="text" name="BANKACCOUNT" id="BANKACCOUNT"
                                                   value="${pd.BANKACCOUNT}" maxlength="100" placeholder="这里输入银行账号"
                                                   title="银行账号" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">附言:</td>
                                        <td><input type="text" name="POSTSCRIPT" id="POSTSCRIPT"
                                                   value="${pd.POSTSCRIPT}" maxlength="255" placeholder="这里输入附言"
                                                   title="附言" style="width:98%;"/></td>
                                    </tr>
                                    <tr id="hidden2">
                                        <td style="width:75px;text-align: right;padding-top: 13px;">合同编号:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="hetongbianhao"
                                                    id="hetongbianhao" data-placeholder="请选择"
                                                    style="vertical-align:top;width: 120px;">

                                            </select>
                                            <input hidden type="text" name="CONTRACT_NO" id="CONTRACT_NO"
                                                   value="${pd.CONTRACT_NO}" maxlength="100" placeholder="这里输入合同编号"
                                                   title="合同编号" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目编号:
                                        </td>
                                        <td><input type="text" name="PROJIECT_ID" id="PROJIECT_ID"
                                                   value="${pd.PROJIECT_ID}" maxlength="100" placeholder="这里输入项目ID"
                                                   title="项目ID" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目名称:
                                        </td>
                                        <td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME"
                                                   value="${pd.PROJECT_NAME}" maxlength="255" placeholder="这里输入项目名称"
                                                   title="项目名称" style="width:98%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>实付金额(元):
                                        </td>
                                        <td><input type="text" name="MONEY" id="MONEY" value="${pd.MONEY}"
                                                   maxlength="13" placeholder="这里输入金额" title="金额" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>垫付金额(元):
                                        </td>
                                        <td><input type="text" name="PAY_ACCOUNT" id="PAY_ACCOUNT"
                                                   value="${pd.PAY_ACCOUNT}" maxlength="13" placeholder="这里输入垫付金额"
                                                   title="垫付金额" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>来款单位:
                                        </td>
                                        <td><input type="text" name="PAY_UNIT" id="PAY_UNIT" value="${pd.PAY_UNIT}"
                                                   maxlength="255" placeholder="这里输入来款单位" title="来款单位"
                                                   style="width:98%;"/></td>
                                    </tr>
                                   <%-- <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>付款剩余余额:
                                        </td>
                                        <td><input type="text" name="YUYUEFUKUAN" id="YUYUEFUKUAN"
                                                   value="${pd.YUYUEFUKUAN}" maxlength="13" placeholder="这里输入付款剩余余额"
                                                   title="付款剩余余额" style="width:98%;"/></td>
                                    </tr>--%>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">付款约定:</td>
                                        <td><input type="text" name="FUKUANYUEDING" id="FUKUANYUEDING"
                                                   value="${pd.FUKUANYUEDING}" maxlength="255" placeholder="这里输入付款约定"
                                                   title="付款约定" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="BZ" id="BZ"
                                                   value="${pd.BZ}" maxlength="255" placeholder="这里输入备注"
                                                   title="备注" style="width:98%;"/></td>
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
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>
<script type="text/javascript">
    $(top.hangge());


    //保存
    function save() {
        if ($("#REQUEST_NO").val() == "") {
            $("#REQUEST_NO").tips({
                side: 3,
                msg: '请输入付款申请编号',
                bg: '#AE81FF',
                time: 2
            });
            $("#REQUEST_NO").focus();
            return false;
        }
        if ($("#REQUEST_DATE").val() == "") {
            $("#REQUEST_DATE").tips({
                side: 3,
                msg: '请输入申请日期',
                bg: '#AE81FF',
                time: 2
            });
            $("#REQUEST_DATE").focus();
            return false;
        }
        if ($("#RESPONSIBLEPERSON").val() == "") {
            $("#RESPONSIBLEPERSON").tips({
                side: 3,
                msg: '请输入经办人',
                bg: '#AE81FF',
                time: 2
            });
            $("#RESPONSIBLEPERSON").focus();
            return false;
        }
        if ($("#REQUEST_TYPE").val() == "") {
            $("#REQUEST_TYPE").tips({
                side: 3,
                msg: '请输入申请类型',
                bg: '#AE81FF',
                time: 2
            });
            $("#REQUEST_TYPE").focus();
            return false;
        }
        if ($("#PAY_METHOD").val() == "") {
            $("#PAY_METHOD").tips({
                side: 3,
                msg: '请输入支付方式',
                bg: '#AE81FF',
                time: 2
            });
            $("#PAY_METHOD").focus();
            return false;
        }


        if ($("#PROJECT_NAME").val() == "") {
            $("#PROJECT_NAME").tips({
                side: 3,
                msg: '请输入项目名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#PROJECT_NAME").focus();
            return false;
        }
        if ($("#MONEY").val() == "") {
            $("#MONEY").tips({
                side: 3,
                msg: '请输入金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#MONEY").focus();
            return false;
        }


        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

    $(function () {

        $("#LICENCE").change(function () {
            if ($("#LICENCE").val() == "其他") {
                $("#xuanzeCompany").removeAttr("hidden");
                $("#xuanzeCompany").val('');
            } else {
                $("#xuanzeCompany").attr("hidden", "hidden");
                $("#xuanzeCompany").val($("#LICENCE").val());
            }


        })


        var str = '${pd.ISHEZUO}';
        var msg = '${msg}';
        if (msg == "edit") {
            if (str == "否") {
                $("#IsHeZuo").val('否');
                $("#hiddenTr").attr("hidden", "hidden");
                $("#hidden2").attr("hidden", "hidden");
                $("#hiddenTr1").removeAttr("hidden");

            }
        }


        $("#PARTNERS1").change(function () {
            var str = $("#PARTNERS1").val();
            console.log(str);
            console.log(str.substring(str.indexOf("-") + 1, str.indexOf("=")))
            console.log(str.substring(str.indexOf("=") + 1, str.length));
            $("#PAYEEBANK").val(str.substring(str.indexOf("-") + 1, str.indexOf("=")));
            $("#BANKACCOUNT").val(str.substring(str.indexOf("=") + 1, str.length));
            $("#PAYEE").val(str.substring(str.indexOf("-") + 1, str.indexOf("=")));
            $("#PARTNERS").val(str.substring(0, str.indexOf("-")));
            $("#COMPANY_NAME").val($("#PARTNERS1 option:selected").text());
        })


        $("#IsHeZuo").change(function () {


            if ($("#IsHeZuo").val() == "否") {


                $("#hiddenTr").attr("hidden", "hidden");
                $("#hidden2").attr("hidden", "hidden");

                $("#hiddenTr1").removeAttr("hidden");
                $("#PAY_ACCOUNT").val("/");
                $("#PAY_UNIT").val("/");
                $("#PROJIECT_ID").val("/");
                $("#YUYUEFUKUAN").val("/");
                $("#PAYEE").val("");

            } else {
                $("#hiddenTr").removeAttr("hidden");
                $("#hiddenTr2").removeAttr("hidden");
                $("#hiddenTr1").attr("hidden", "hidden");
                $("#PAY_ACCOUNT").val("");
                $("#PAY_UNIT").val("");
                $("#PROJIECT_ID").val("");
                $("#YUYUEFUKUAN").val("");
                $("#PAYEE").val("");

            }
        });

        var PARTNERS = "${pd.PARTNERS}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>partners/getPartners.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#PARTNERS1").append("<option value=''>请选择</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].PARTNERS_ID == PARTNERS) {
                            $("#PARTNERS1").append("<option value=" + data.list[i].PARTNERS_ID + "-" + data.list[i].BANK_ACCOUNT + "=" + data.list[i].OPEN_ACCOUNT + " selected='selected'>" + data.list[i].COMPANY_NAME + "</option>");
                        } else {
                            $("#PARTNERS1").append("<option value=" + data.list[i].PARTNERS_ID + "-" + data.list[i].BANK_ACCOUNT + "=" + data.list[i].OPEN_ACCOUNT + ">" + data.list[i].COMPANY_NAME + "</option>");
                        }
                    }
                    downList('PARTNERS1');

                }
            }
        });


        var project = "${pd.PAYEE_ID}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>supplier/getAllSupplier.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#gongyingshang").append("<option value=''>请选择</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SUPPLIER_ID == project) {
                            $("#gongyingshang").append("<option value=" + data.list[i].SUPPLIER_ID + " selected='selected'>" + data.list[i].COMPANY_NAME + "</option>");
                        } else {
                            $("#gongyingshang").append("<option value=" + data.list[i].SUPPLIER_ID + ">" + data.list[i].COMPANY_NAME + "</option>");
                        }
                    }
                    downList('gongyingshang');
                }
            }
        });

        $("#gongyingshang").change(function () {
            $("#PAYEEBANK").val("");
            $("#BANKACCOUNT").val("");
            $("#PAYEE").val("");
            $.ajax({
                type: "POST",
                url: '<%=basePath%>supplier/getSupplierById.do?tm=' + new Date().getTime(),
                dataType: 'json',
                data: {'SUPPLIER_ID': $("#gongyingshang").val()},
                cache: false,
                success: function (data) {
                    $("#PAYEEBANK").val(data.pd.OPENING_BANK);
                    $("#BANKACCOUNT").val(data.pd.BANKACCOUNT);
                    $("#PAYEE").val($("#gongyingshang option:selected").text());

                }
            });
        })


        var str = new Date();
        $("#REQUEST_DATE").val(str.getFullYear() + "/" + (parseInt(str.getMonth()) + 1) + "/" + str.getDate());

        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
        var strmsg = '${msg }';
        if (strmsg == "save") {
            $("#REQUEST_NO").val(randomNumber());
        }

        //加载申请类型
        var requesttype = "${pd.REQUEST_TYPE}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
            data: {DICTIONARIES_ID: 'ff461bfcd87c422b8145d0bb49fce7d3'},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#requesttype").append("<option value=''>请选择类型</option>");
                $.each(data.list, function (i, dvar) {
                    if (requesttype == dvar.NAME) {
                        $("#requesttype").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                    } else {
                        $("#requesttype").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                    }
                });
            }
        });
        //加载支付方式
        var paymethod = "${pd.PAY_METHOD}";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
            data: {DICTIONARIES_ID: '1ff8c7ff6476468a8393ba79d83416e1'},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#paymethod").append("<option value=''>请选择支付方式</option>");
                $.each(data.list, function (i, dvar) {
                    if (paymethod == dvar.NAME) {
                        $("#paymethod").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                    } else {
                        $("#paymethod").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                    }
                });
            }
        });
        //加载账号类型
        var paytype = "${pd.ACCOUNT_TYPE}";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
            data: {DICTIONARIES_ID: 'd326eeb243554ef886845e83bccdc1b7'},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#paytype").append("<option value=''>请选择账号类型</option>");
                $.each(data.list, function (i, dvar) {
                    if (paytype == dvar.NAME) {
                        $("#paytype").append("<option value=" + dvar.NAME + " selected='selected'>" + dvar.NAME + "</option>");
                    } else {
                        $("#paytype").append("<option value=" + dvar.NAME + ">" + dvar.NAME + "</option>");
                    }
                });
            }
        });

        //类型改变
        $("#requesttype").change(function () {
            $("#REQUEST_TYPE").val($("#requesttype").val());
        })
        //支付方式改变
        $("#paymethod").change(function () {
            $("#PAY_METHOD").val($("#paymethod").val());
        })
        //账号类型改变
        $("#paytype").change(function () {
            $("#ACCOUNT_TYPE").val($("#paytype").val());
        })

        //初始化合同编号
        getInfo();

        //选择合同改变
        $("#hetongbianhao").change(function () {
            var str = $("#hetongbianhao").val();
            var CONTRACT_NO = str.substring(0, str.indexOf("-"));
            var PROJIECT_ID = str.substring(str.indexOf("-") + 1, str.indexOf("+"));
            var PROJECT_NAME = str.substring(str.indexOf("+") + 1, str.indexOf("@"));
            var MONEY = str.substring(str.indexOf("@") + 1, str.length);

            $("#CONTRACT_NO").val(CONTRACT_NO);
            $("#PROJIECT_ID").val(PROJIECT_ID);
            $("#PROJECT_NAME").val(PROJECT_NAME);
            $("#MONEY").val(MONEY);


        })


    });

    //初始化合同编号
    function getInfo() {
        var weituo = "${pd.CONTRACT_NO}";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/projectpurchase/getCgAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#hetongbianhao").append("<option value=''>请选择合同编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].PURCHASE_CONTRACT_ID == weituo) {
                            $("#hetongbianhao").append("<option value=" + data.list[i].PURCHASE_CONTRACT_ID + "-" + data.list[i].SYS_ID + "+" + data.list[i].PROJECTNAME + "@" + data.list[i].CONTRACT_PRICE + " selected='selected'>" + data.list[i].PURCHASE_CONTRACT_ID + "</option>");
                        } else {
                            $("#hetongbianhao").append("<option value=" + data.list[i].PURCHASE_CONTRACT_ID + "-" + data.list[i].SYS_ID + "+" + data.list[i].PROJECTNAME + "@" + data.list[i].CONTRACT_PRICE + ">" + data.list[i].PURCHASE_CONTRACT_ID + "</option>");
                        }
                    }
                    downList('hetongbianhao');
                }
            }
        });
    }

    //生成流水号
    function randomNumber() {
        var now = new Date();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hour = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        //month = this.setTimeDateFmt(month);
        //hour = this.setTimeDateFmt(hour);
        //minutes = this.setTimeDateFmt(minutes);
        //seconds = this.setTimeDateFmt(seconds);
        return now.getFullYear().toString() + month.toString() + day + hour + minutes + seconds + (Math.round(Math.random() * 89 + 100)).toString()
    }
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