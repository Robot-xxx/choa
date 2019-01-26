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

                        <form action="project/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
                            <input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS }">
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

                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目编号:</td>
                                        <td><input type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   maxlength="100" placeholder="这里输入项目编号" title="系统编序号"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目名称:</td>
                                        <td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME"
                                                   value="${pd.PROJECT_NAME}" maxlength="100" placeholder="这里输入项目名称"
                                                   title="项目名称" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>医院:</td>
                                        <td><%--
                                            <select class="chosen-select form-control"  id="yiyuan" name="HOSPITALID" data-placeholder="医院" style="vertical-align:top;width: 68px; width: 98%">

                                            </select>--%>
                                            <input type="text"  name="HOSPITAL" id="HOSPITAL" value="${pd.HOSPITAL}"
                                                   maxlength="100" placeholder="这里输入医院" title="医院" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>投标限价(万元):</td>
                                        <td><input onkeydown="change(this.value)"  type="text" name="LIMITED_PRICE" id="LIMITED_PRICE"
                                                   value="${pd.LIMITED_PRICE}" maxlength="11" placeholder="这里输入投标限价(万元)"
                                                   title="投标限价(万元)" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">委托公司老板:</td>
                                        <td>
                                            <select class="chosen-select form-control"  id="selectCompany" data-placeholder="委托公司老板" style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <span style="color: red">注:需提前在代理商管理处填写(无需审批)才能选择</span>
                                            <input type="text" hidden readonly name="CORPORATE_BOSS" id="CORPORATE_BOSS"
                                                   value="${pd.CORPORATE_BOSS}" maxlength="50" placeholder="这里输入委托公司老板"
                                                   title="委托公司老板" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">委托公司:</td>

                                        <td>
                                            <input type="hidden" id="AGENCY_ID" name="AGENCY_ID"
                                                   value="${pd.AGENCY_ID}">

                                            <input type="text" readonly name="CORPORATE_COMPANY" id="CORPORATE_COMPANY"
                                                   value="${pd.CORPORATE_COMPANY}" maxlength="50" placeholder="这里输入委托公司"
                                                   title="委托公司" style="width:98%;"/>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">委托公司老板电话:</td>
                                        <td><input type="text" readonly name="BOSS_PHONE" id="BOSS_PHONE"
                                                   value="${pd.BOSS_PHONE}" maxlength="50" placeholder="这里输入委托公司老板电话"
                                                   title="委托公司老板电话" style="width:98%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">业务联系人:</td>
                                        <td><input type="text" readonly name="LINKMAN" id="LINKMAN"
                                                   value="${pd.LINKMAN}" maxlength="50" placeholder="这里输入联系人"
                                                   title="联系人" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">业务联系人电话:</td>
                                        <td><input type="text" readonly name="BUSINESS_PEOPLE" id="BUSINESS_PEOPLE"
                                                   value="${pd.BUSINESS_PEOPLE}" maxlength="50" placeholder="这里输入联系人"
                                                   title="联系人" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">客户分析:</td>
                                        <td>
                                            <input type="text" name="CUSTOMER" id="CUSTOMER" value="${pd.CUSTOMER}"
                                                   maxlength="100" placeholder="这里输入客户分析" title="客户分析"
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">招标预计时间:</td>
                                        <td>
                                            <input class="span10 date-picker" name="ZHAOBIAOYUJI"
                                                   id="ZHAOBIAOYUJI"
                                                   value="${pd.ZHAOBIAOYUJI}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="招标预计时间" title="招标预计时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">付款约定:</td>
                                        <td><input type="text" name="ACCESSORY" id="ACCESSORY" value="${pd.ACCESSORY}"
                                                   maxlength="255" placeholder="这里输入付款约定" title="付款约定"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="BZ" value="${pd.BZ}"
                                                   maxlength="255" placeholder="这里输入备注" title="备注"
                                                   style="width:98%;"/></td>
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
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>

<script type="text/javascript">



    function change(val){
        $("#LIMITED_PRICE").val(formatNum2(val))
    }

    function formatNum2(num) {
        return (num).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }



    $(top.hangge());

    //保存
    function save() {
        if ($("#xuanzeCompany").val() == "") {
            $("#xuanzeCompany").tips({
                side: 3,
                msg: '请选择公司',
                bg: '#AE81FF',
                time: 2
            });
            $("#xuanzeCompany").focus();
            return false;
        }
        if ($("#SYS_ID").val() == "") {
            $("#SYS_ID").tips({
                side: 3,
                msg: '请输入项目编号',
                bg: '#AE81FF',
                time: 2
            });
            $("#SYS_ID").focus();
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
        if ($("#HOSPITAL").val() == "") {
            $("#HOSPITAL").tips({
                side: 3,
                msg: '请输入医院名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#HOSPITAL").focus();
            return false;
        }
        if ($("#LIMITED_PRICE").val() == "") {
            $("#LIMITED_PRICE").tips({
                side: 3,
                msg: '请输入投标限价',
                bg: '#AE81FF',
                time: 2
            });
            $("#LIMITED_PRICE").focus();
            return false;
        }





        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }







    //截取字符串
    function jiequ(str){
        return str.substring(str.lastIndexOf('-')+1,str.length);
    }

    $(function () {

        //委托公司
        $("#selectCompany").change(function (){
            $("#CORPORATE_COMPANY").val('');
            $("#BOSS_PHONE").val('');
            $("#BUSINESS_PEOPLE").val('');
            $("#LINKMAN").val('');
            $("#CORPORATE_BOSS").val('');
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/project/getCompanyById.do?AGENCY_ID=' + $("#selectCompany").val(),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#CORPORATE_COMPANY").val(data.pd.COMPANY_NAME);
                        $("#BOSS_PHONE").val(data.pd.BOSS_PHONE);
                        $("#BUSINESS_PEOPLE").val(data.pd.BUSINESS_PEOPLE);
                        $("#LINKMAN").val(data.pd.LINKMAN);
                        $("#CORPORATE_BOSS").val(data.pd.COMPANY_BOSS);
                    }
                }
            });
        })

        //医院信息
        $("#yiyuan").change(function (){
            $("#HOSPITAL").val('');
            $("#HOSPITAL").val($("#yiyuan option:selected").text());

        })


        //产品信息
        $("#selectCompany").change(function (){
            $("#AGENCY_ID").val('');
            $("#CORPORATE_COMPANY").val('');
            var str= $("#selectCompany").val();
            $("#AGENCY_ID").val(str);
            $("#CORPORATE_COMPANY").val(jiequ($("#selectCompany option:selected").text()));

        })

        //产品信息
        $("#c_selectCompany").change(function (){
            $("#PRODUCT").val('');
            $("#PRODUCT").val(jiequ($("#c_selectCompany option:selected").text()));
        })


        //供应商信息
        $("#g_selectCompany").change(function (){
            $("#SUPPLIER").val('');
            $("#SUPPLIER").val(jiequ($("#g_selectCompany option:selected").text()));
        })

        //客户信息
        $("#k_selectCompany").change(function (){
            $("#CLIENT").val('');
            $("#CLIENT").val(jiequ($("#k_selectCompany option:selected").text()));
        })

        getInfo();


        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});

        $("#LICENCE").change(function () {
            if ($("#LICENCE").val() == "其他") {
                $("#xuanzeCompany").removeAttr("hidden");
                $("#xuanzeCompany").val('');
            } else {
                $("#xuanzeCompany").attr("hidden", "hidden");
                $("#xuanzeCompany").val($("#LICENCE").val());
            }
        })




    });


    //获取各个下拉列表数据
    function getInfo() {
      var weituo="${pd.AGENCY_ID}";

        //委托公司
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/getCompany.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                console.log(JSON.stringify())
                if (data.errInfo == "success") {
                    $("#selectCompany").append("<option value=''>请选择</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].AGENCY_ID  == weituo) {
                            $("#selectCompany").append("<option value=" +  data.list[i].AGENCY_ID + " selected='selected'>" + data.list[i].COMPANY_BOSS+ "</option>");
                        } else {
                            $("#selectCompany").append("<option value=" + data.list[i].AGENCY_ID + ">" + data.list[i].COMPANY_BOSS + "</option>");
                        }
                    }
                    downList('selectCompany');
                }
            }
        });

        var yiyuan="${pd.HOSPITALID}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>/hospital/getHospital.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#yiyuan").append("<option value=''>请选择医院</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID  == yiyuan) {
                            $("#yiyuan").append("<option value=" +  data.list[i].SYS_ID + " selected='selected'>" + data.list[i].HOSPITAL_NAME+ "</option>");
                        } else {
                            $("#yiyuan").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].HOSPITAL_NAME + "</option>");
                        }
                    }
                    downList('yiyuan');
                }
            }
        });

        var cp="${pd.PRODUCT_ID}";
        //产品管理
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/c_ProductAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#c_selectCompany").append("<option value=''>请选择产品编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID  == cp) {
                            $("#c_selectCompany").append("<option value=" +  data.list[i].SYS_ID+ " selected='selected'>" +data.list[i].SYS_ID+"-"+data.list[i].PRODUCT_NAME+ "</option>");
                        } else {
                            $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID+"-"+data.list[i].PRODUCT_NAME + "</option>");
                        }
                    }

                    downList('c_selectCompany');
                }
            }
        });

        var gy="${pd.SUPPLIER_ID}";
        //供应商管理
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/g_SupplierAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#g_selectCompany").append("<option value=''>请选择供应商编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID  == gy) {
                            $("#g_selectCompany").append("<option value=" +  data.list[i].SYS_ID+ " selected='selected'>" + data.list[i].SYS_ID+"-"+data.list[i].COMPANY_NAME+ "</option>");
                        } else {
                            $("#g_selectCompany").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID+"-"+data.list[i].COMPANY_NAME+"</option>");
                        }
                    }
                    downList('g_selectCompany');
                }
            }
        });
        var kh="${pd.CLIENT_ID}";

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
                            $("#k_selectCompany").append("<option value=" +  data.list[i].SYS_ID+ " selected='selected'>"  + data.list[i].SYS_ID+"-"+data.list[i].HOSPITAL_NAME+"</option>");
                        } else {
                            $("#k_selectCompany").append("<option value=" + data.list[i].SYS_ID + ">"  + data.list[i].SYS_ID+"-"+data.list[i].HOSPITAL_NAME+"</option>");
                        }
                    }
                    downList('k_selectCompany');
                }
            }
        });
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