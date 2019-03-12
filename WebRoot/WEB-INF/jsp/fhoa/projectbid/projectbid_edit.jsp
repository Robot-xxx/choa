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
    <link rel="stylesheet" href="searchableSelect/jquery.searchableSelect.css"/>
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

                        <form action="projectbid/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="PROJECT_BID_ID" id="PROJECT_BID_ID"
                                   value="${pd.PROJECT_BID_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
                            <input type="hidden" name="oafileList" id="oafileList">
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
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目编号:
                                        </td>

                                        <td>

                                            <select class="chosen-select form-control" id="projectId"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input type="hidden" name="FUZEREN" id="FUZEREN">
                                            <input type="text" hidden name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   maxlength="100" placeholder="这里输入系统编序号" title="系统编序号"
                                                   style="width:98%;"/>
                                            <span style="color:red;">注:需要完成项目立项流程并通过审批后才能选择</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目名称:
                                        </td>
                                        <td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME"
                                                   value="${pd.PROJECT_NAME}" maxlength="100" placeholder="这里输入项目名称"
                                                   title="项目名称" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>医院:
                                        </td>
                                        <td>
                                            <%--<select class="chosen-select form-control"  id="yiyuan" name="HOSPITALID" data-placeholder="医院" style="vertical-align:top;width: 68px; width: 98%">

                                            </select>--%>

                                            <input type="text" name="HOSPITAL" id="HOSPITAL" value="${pd.HOSPITAL}"
                                                   maxlength="100" placeholder="这里输入医院" title="医院" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">招标公司:</td>
                                        <td><input type="text" name="TEBDERING" id="TEBDERING" value="${pd.TEBDERING}"
                                                   maxlength="12" placeholder="招标公司" title="招标公司" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">招标代表:</td>
                                        <td><input type="text" name="REPRESENTATIVE" id="REPRESENTATIVE"
                                                   value="${pd.REPRESENTATIVE}" maxlength="100" placeholder="招标代表"
                                                   title="招标代表" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">中标单位:</td>
                                        <td><input type="text" name="WINNING_UNIT" id="WINNING_UNIT"
                                                   value="${pd.WINNING_UNIT}" maxlength="100" placeholder="这里输入中标单位"
                                                   title="中标单位" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">中标价格(元):</td>
                                        <td><input onchange="change(this.value)" type="text" name="WINNING_PRICE" id="WINNING_PRICE"
                                                   value="${pd.WINNING_PRICE}" maxlength="50" placeholder="这里输入中标价格(元)"
                                                   title="中标价格(元)" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">中标服务费垫资金额（元）:</td>
                                        <td><input onchange="change1(this.value)" type="text" name="SERVICE_PRICE" id="SERVICE_PRICE"
                                                   value="${pd.SERVICE_PRICE}" maxlength="50"
                                                   placeholder="这里输入中标服务费垫资金额（元）" title="中标服务费垫资金额（元）"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">投标保证金垫资金额(元):</td>
                                        <td><input onchange="change2(this.value)" type="text" name="GUARANTEE_MONEY" id="GUARANTEE_MONEY"
                                                   value="${pd.GUARANTEE_MONEY}" maxlength="50"
                                                   placeholder="这里输入投标保证金垫资金额(元)" title="投标保证金垫资金额(元)"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">投标保证金预计缴纳时间:</td>
                                        <td>
                                            <input class="span10 date-picker" name="SCHEDULED_TIME" id="SCHEDULED_TIME"
                                                   value="${pd.SCHEDULED_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="投标保证金预计缴纳时间" title="投标保证金预计缴纳时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">投标保证金实际缴纳时间:</td>
                                        <td><input class="span10 date-picker" name="PRACTICAL_TIME" id="PRACTICAL_TIME"
                                                   value="${pd.PRACTICAL_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="投标保证金实际缴纳时间" title="投标保证金实际缴纳时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">开标日期:</td>
                                        <td><input class="span10 date-picker" name="BID_OPEN_TIME" id="BID_OPEN_TIME"
                                                   value="${pd.BID_OPEN_TIME}" type="text" data-date-format="yyyy-mm-dd"
                                                   readonly="readonly" placeholder="开标日期" title="开标日期"
                                                   style="width:98%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">中标服务费预计缴纳时间:</td>
                                        <td><input class="span10 date-picker" name="SCHEDULED_SERVICE_PRICE_TIME"
                                                   id="SCHEDULED_SERVICE_PRICE_TIME"
                                                   value="${pd.SCHEDULED_SERVICE_PRICE_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="中标服务费预计缴纳时间" title="中标服务费预计缴纳时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">中标服务费实际缴纳时间:</td>
                                        <td><input class="span10 date-picker" name="PRACTICAL_SERVICE_PRICE_TIME"
                                                   id="PRACTICAL_SERVICE_PRICE_TIME"
                                                   value="${pd.PRACTICAL_SERVICE_PRICE_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="中标服务费实际缴纳时间" title="中标服务费实际缴纳时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">保证金退回时间:</td>
                                        <td><input class="span10 date-picker" name="BAOZHENGJINTUIHUISHIJIAN"
                                                   id="BAOZHENGJINTUIHUISHIJIAN"
                                                   value="${pd.BAOZHENGJINTUIHUISHIJIAN}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="保证金退回时间" title="保证金退回时间" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>标书制作人:</td>
                                        <td><input name="BIAOSHUZHIZUOREN" id="BIAOSHUZHIZUOREN"
                                                   value="${pd.BIAOSHUZHIZUOREN}" type="text" placeholder="标书制作人"
                                                   title="标书制作人" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>风险条款:</td>
                                        <td><input name="FENGXIANTIAOKUAN" id="FENGXIANTIAOKUAN"
                                                   value="${pd.FENGXIANTIAOKUAN}" type="text" placeholder="风险条款"
                                                   title="风险条款" style="width:98%;"/></td>
                                    </tr>
<%--
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>是否资料齐全:</td>
                                        <td>
                                            是<input checked type="radio" name="ISZILIAOQQ" value="是"
                                                    <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                            否<input type="radio" name="ISZILIAOQQ" value="否"
                                                    <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
                                        </td>
                                    </tr>--%>



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
<!-- 上传附件 -->
<script src="upload/oaFile.js"></script>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>

<script type="text/javascript">
    var str = "<option value=''>请选择类型</option>";
    $(top.hangge());
    function change1(val){
        $("#SERVICE_PRICE").val(formatNum2(val))
    }
    function change2(val){
        $("#GUARANTEE_MONEY").val(formatNum2(val))
    }
    function change(val){
        $("#WINNING_PRICE").val(formatNum2(val))
    }

    function formatNum2(num) {
        return (num).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
    //保存
    function save() {

        if ($("#xuanzeCompany").val() == "") {
            $("#xuanzeCompany").tips({
                side: 3,
                msg: '请选择公司名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#xuanzeCompany").focus();
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
        if ($("#PRODUCT_ID").val() == "") {
            $("#PRODUCT_ID").tips({
                side: 3,
                msg: '请选择项目编号',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRODUCT_ID").focus();
            return false;
        }
        if ($("#HOSPITAL").val() == "") {
            $("#HOSPITAL").tips({
                side: 3,
                msg: '请输入医院',
                bg: '#AE81FF',
                time: 2
            });
            $("#HOSPITAL").focus();
            return false;
        }


        if ($("#BIAOSHUZHIZUOREN").val() == "") {
            $("#BIAOSHUZHIZUOREN").tips({
                side: 3,
                msg: '请输入标书制作人',
                bg: '#AE81FF',
                time: 2
            });
            $("#BIAOSHUZHIZUOREN").focus();
            return false;
        }
        if ($("#FENGXIANTIAOKUAN").val() == "") {
            $("#FENGXIANTIAOKUAN").tips({
                side: 3,
                msg: '请输入风险条款',
                bg: '#AE81FF',
                time: 2
            });
            $("#FENGXIANTIAOKUAN").focus();
            return false;
        }
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
        //   localStorage.setItem("Identification", "save");
    }

    //截取字符串
    function jiequ(str) {
        return str.substring(str.lastIndexOf('-') + 1, str.length);
    }

    function getInfo() {


        var project = "${pd.SYS_ID}";

        //项目编号
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/projectbid/getProjectAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#projectId").append("<option value=''>请选择项目编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].PROJECT_ID == project) {
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID + "=" + data.list[i].FUZEREN + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        } else {
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID + "=" + data.list[i].FUZEREN + ">" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        }
                    }
                    downList('projectId');
                }
            }
        });
    }

    function fmtDate(obj) {





        console.log(obj)
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
    }

    $(function () {

        var strOpthion='';
        for (var i = 1; i <=20 ; i++) {
            strOpthion+='<option value="'+i+'">' + i + '</option>';
        }
        $("#PRODUCT_NUMBER").append(strOpthion);


        $("#PRODUCT_NUMBER").change(function () {
            $(".removeTr").remove();
            var num = $("#PRODUCT_NUMBER").val();
            console.log(num)
            for (var i = 0; i < num-1; i++) {

                $("#tr1").after('<tr class="removeTr"> ' +
                    '<td style="width:75px;text-align: right;padding-top: 13px;">' +
                    '<font color="red">*</font>产品名称: ' +
                    '</td>' +
                    '<td>' +
                    '<select  name="PRODUCT_ID"  data-placeholder="器械编号" style="vertical-align:top;width: 50%;">' +
                        '<option value="">请选择器械名称</option>'+
                    '</select>' +
                    '<input type="text" readonly name="PRODUCT" id="PRODUCT"   value="" maxlength="100" placeholder="器械名称" title="器械名称"  style="width:48%;"/>  <input type="text" hidden name="PROJECT_ID" id="PROJECT_ID"   value="" maxlength="100" style="width:48%;"/>    <span style="color: red">注:需先在器械管理处填写资料并通过质控审批后才能选择</span>  </td></tr>')
            }

        })





        //产品信息
        $("#c_selectCompany").change(function () {

            var str = $("#c_selectCompany").val();

            $("#CHANPINDAOQIRI").val(fmtDate(parseFloat(str.substring(str.indexOf("=") + 1, str.length))));

            $("#PRODUCT").val('');

            $("#PRODUCT").val(jiequ($("#c_selectCompany option:selected").text()));
        })


        //供应商信息
        $("#g_selectCompany").change(function () {
            $("#SUPPLIER").val('');
            $("#SUPPLIER").val(jiequ($("#g_selectCompany option:selected").text()));
        })

        //客户信息
        $("#k_selectCompany").change(function () {
            $("#CLIENT").val('');
            $("#CLIENT").val(jiequ($("#k_selectCompany option:selected").text()));
        })
        var cp = "${pd.PRODUCT}";
        //产品管理
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/c_ProductAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#c_selectCompany").append("<option value=''>请选择器械名称</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == cp) {
                            $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PRODUCT_NAME + "</option>");
                        } else {
                            $("#c_selectCompany").append("<option value=" + data.list[i].SYS_ID + "=" + data.list[i].VALIDITY + ">" + data.list[i].SYS_ID + "-" + data.list[i].PRODUCT_NAME + "</option>");
                        }
                    }

                    downList('c_selectCompany');
                }
            }
        });

        var gy = "${pd.SUPPLIER}";
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
                        if (data.list[i].SYS_ID == gy) {
                            $("#g_selectCompany").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].COMPANY_NAME + "</option>");
                        } else {
                            $("#g_selectCompany").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID + "-" + data.list[i].COMPANY_NAME + "</option>");
                        }
                    }
                    downList('g_selectCompany');
                }
            }
        });
        var kh = "${pd.CLIENT}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/k_ClienteleAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#k_selectCompany").append("<option value=''>请选择医院编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == kh) {
                            $("#k_selectCompany").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].HOSPITAL_NAME + "</option>");
                        } else {
                            $("#k_selectCompany").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID + "-" + data.list[i].HOSPITAL_NAME + "</option>");
                        }
                    }
                    downList('k_selectCompany');
                }
            }
        });

        var yiyuan = "${pd.HOSPITALID}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>/hospital/getHospital.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#yiyuan").append("<option value=''>请选择医院</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == yiyuan) {
                            $("#yiyuan").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].HOSPITAL_NAME + "</option>");
                        } else {
                            $("#yiyuan").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].HOSPITAL_NAME + "</option>");
                        }
                    }
                    downList('yiyuan');
                }
            }
        });

        //医院信息
        $("#yiyuan").change(function () {
            $("#HOSPITAL").val('');
            $("#HOSPITAL").val($("#yiyuan option:selected").text());

        })

        //项目编号
        $("#projectId").change(function () {
            var str = $("#projectId").val();
            var str1 = $("#projectId option:selected").text();
            $("#PROJECT_NAME").val('');
            $("#HOSPITAL").val('');
            $("#SYS_ID").val('');
            $("#PROJECT_ID").val('');
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/projectbid/projectById.do?PROJECT_ID=' + str.substring(0, str.indexOf("=")),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#PROJECT_NAME").val(data.pd.PROJECT_NAME);
                        $("#HOSPITAL").val(data.pd.HOSPITAL);
                        $("#SYS_ID").val(str.substring(0, str.indexOf("=")));
                        $("#PROJECT_ID").val(str1.substring(0, str1.lastIndexOf("-")));
                        $("#FUZEREN").val(str.substring(str.indexOf("=") + 1, str.length));


                    }
                }
            });
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


        getPath('<%=basePath%>');

        getAllFile("${pd.PROJECT_BID_ID}");
        fuxuan();

        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});


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