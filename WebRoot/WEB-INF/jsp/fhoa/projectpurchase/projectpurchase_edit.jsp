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

                        <form action="projectpurchase/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="PURCHASE_ID" id="PURCHASE_ID"
                                   value="${pd.PURCHASE_ID}"/>
                            <input type="hidden" name="msg" id="msg" value="${msg }"/>
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
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>项目编号:
                                        </td>

                                        <td>
                                            <select class="chosen-select form-control" id="projectId">

                                            </select>
                                            <input type="hidden" name="FUZEREN" id="FUZEREN">
                                            <input readonly type="text" name="PROJECTNAME" id="PROJECTNAME"
                                                   value="${pd.PROJECTNAME}" style="width:44%;"/>

                                            <input hidden type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>销售合同编号:
                                        </td>
                                        <td>
                                            <select id="xiaoshouID" style="width:54%;">

                                            </select>
                                            <input hidden type="text" name="SALES_CONTRACT_ID" id="SALES_CONTRACT_ID"
                                                   value="${pd.SALES_CONTRACT_ID}" maxlength="100"
                                                   placeholder="这里输入销售合同编号" title="销售合同编号"/>
                                            <span style="color:red;">注:完成立项丶销售流程后才能选择对应合同</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>采购合同编号:
                                        </td>
                                        <td>
                                            <input readonly type="text" name="PURCHASE_CONTRACT_ID"
                                                   id="PURCHASE_CONTRACT_ID"
                                                   value="${pd.PURCHASE_CONTRACT_ID}" maxlength="100"
                                                   placeholder="这里输入采购合同编号" title="采购合同编号" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font
                                                color="red">*</font>供应商序号:
                                        </td>
                                        <td>
                                            <select class="chosen-select form-control" id="gongyingshangID"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>

                                            <%--
                                                                                        供应商公司:<input readonly type="text" name="SUPPLIERCOMPANY" id="SUPPLIERCOMPANY" value="${pd.SUPPLIERCOMPANY}" style="width:44%;"/>
                                                                                --%>
                                            <input hidden type="text" name="SUPPLIER_ID" id="SUPPLIER_ID"
                                                   value="${pd.SUPPLIER_ID}" maxlength="100" placeholder="这里输入供应商序号"
                                                   title="供应商序号" style="width:98%;"/>

                                            <input hidden type="text" name="SUPPLIERNAME" id="SUPPLIERNAME"
                                                   value="${pd.SUPPLIERNAME}" maxlength="100" placeholder="这里输入供应商序号"
                                                   title="供应商名称" style="width:98%;"/>
                                            <span style="color: red">注:需提前在上游管理处填写并通过审批才能选择对应供应商</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">生产许可证到期日:</td>
                                        <td>
                                            <input placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly  type="text" name="SHENGCHANXUKEZHENG" id="SHENGCHANXUKEZHENG" value="${pd.SHENGCHANXUKEZHENG}" maxlength="100" style="width:98%;"/>
                                            <span style="color:red;">注:请认真对证件是否过期</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">经营许可证到期日:</td>
                                        <td>
                                            <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly  type="text" name="JINGYINGXUKEZHENG" id="JINGYINGXUKEZHENG" value="${pd.JINGYINGXUKEZHENG}" maxlength="100" style="width:98%;"/>
                                            <span style="color:red;">注:请认真对证件是否过期</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">法人授权书到期日:</td>
                                        <td>
                                            <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly type="text" name="FARENSHOUQUAN" id="FARENSHOUQUAN" value="${pd.FARENSHOUQUAN}" maxlength="100" style="width:98%;"/>
                                            <span style="color:red;">注:请认真对证件是否过期</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">授权委托书到期日:</td>
                                        <td>
                                            <input  placeholder="这里输入到期日" data-date-format="yyyy-mm-dd" readonly  type="text" name="SHOUQUANWEITUO" id="SHOUQUANWEITUO" value="${pd.SHOUQUANWEITUO}" maxlength="100" style="width:98%;"/>
                                            <span style="color:red;">注:请认真对证件是否过期</span>
                                        </td>
                                    </tr>
                                    <%--   <tr>
                                           <td style="width:75px;text-align: right;padding-top: 13px;">产品信息:</td>
                                           <td><input type="text" readonly name="PRODUCT_INFO" id="PRODUCT_INFO"
                                                      value="${pd.PRODUCT_INFO}" maxlength="255" placeholder="这里输入产品信息"
                                                      title="产品信息" style="width:98%;"/></td>
                                       </tr>--%>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">合同签订时间:</td>
                                        <td><input class="span10 date-picker" name="CONTRACT_SIGN_TIME"
                                                   id="CONTRACT_SIGN_TIME" value="${pd.CONTRACT_SIGN_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="合同签订时间" title="合同签订时间" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">合同金额(万元):</td>
                                        <td><input type="text" name="CONTRACT_PRICE" id="CONTRACT_PRICE"
                                                   value="${pd.CONTRACT_PRICE}" maxlength="12"
                                                   placeholder="这里输入合同金额(万元)" title="合同金额(万元)" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font style="color: red">*</font>是否资料齐全:</td>
                                        <td>
                                            是<input type="radio" name="ISZILIAOQQ"  value="是" <c:if test="${pd.ISZILIAOQQ=='是'}">checked</c:if>/>
                                            否<input type="radio" name="ISZILIAOQQ"  value="否" <c:if test="${pd.ISZILIAOQQ=='否'}">checked</c:if>/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="BZ" value="${pd.BZ}"
                                                   maxlength="255" placeholder="这里输入备注" title="备注"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <%--   <tr>
                                           <td style="width:75px;text-align: right;padding-top: 13px;">发票号码:</td>
                                           <td><input type="text" name="INVOICE_NUMBER" id="INVOICE_NUMBER"
                                                      value="${pd.INVOICE_NUMBER}" maxlength="100" placeholder="这里输入发票号码"
                                                      title="发票号码" style="width:98%;"/></td>
                                       </tr>--%>
                                    <%--<tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">授权书丶随货同行单:</td>
                                        &lt;%&ndash;<td><input type="text" name="INVOICE_ACCESSORY" id="INVOICE_ACCESSORY" value="${pd.INVOICE_ACCESSORY}" maxlength="255" placeholder="这里输入发票附件" title="发票附件" style="width:98%;"/></td>&ndash;%&gt;
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
                                                                                <th class="center">文件类型</th>
                                                                                <th class="center">备注</th>
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
                                                                                           onclick="add('${pd.PURCHASE_ID}');">上传</a>
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
                                    <%-- <tr>
                                         <td style="width:75px;text-align: right;padding-top: 13px;">授权书丶随货同行单:</td>
                                         <td><input type="text" name="AUTHORIZATION" id="AUTHORIZATION"
                                                    value="${pd.AUTHORIZATION}" maxlength="255"
                                                    placeholder="这里输入授权书丶随货同行单" title="授权书丶随货同行单" style="width:98%;"/>
                                         </td>

                                     </tr>--%>
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
    var str1 = "<option value=''>请选择类型</option>";
    var str2 = "<option value=''>请选择类型</option>";
    $(top.hangge());
    function fmtDate(obj){
        console.log(obj)
        var date =  new Date(obj);
        var y = 1900+date.getYear();
        var m = "0"+(date.getMonth()+1);
        var d = "0"+date.getDate();
        return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length);
    }
    //保存
    function save() {
        /* if ($("#SYS_ID").val() == "") {
             $("#SYS_ID").tips({
                 side: 3,
                 msg: '请输入系统编序号',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#SYS_ID").focus();
             return false;
         }
         if ($("#SALES_CONTRACT_ID").val() == "") {
             $("#SALES_CONTRACT_ID").tips({
                 side: 3,
                 msg: '请输入销售合同编号',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#SALES_CONTRACT_ID").focus();
             return false;
         }
         if ($("#PURCHASE_CONTRACT_ID").val() == "") {
             $("#PURCHASE_CONTRACT_ID").tips({
                 side: 3,
                 msg: '请输入采购合同编号',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#PURCHASE_CONTRACT_ID").focus();
             return false;
         }
         if ($("#SUPPLIER_ID").val() == "") {
             $("#SUPPLIER_ID").tips({
                 side: 3,
                 msg: '请输入供应商序号',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#SUPPLIER_ID").focus();
             return false;
         }
         if ($("#PRODUCT_INFO").val() == "") {
             $("#PRODUCT_INFO").tips({
                 side: 3,
                 msg: '请输入产品信息',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#PRODUCT_INFO").focus();
             return false;
         }
         if ($("#CONTRACT_SIGN_TIME").val() == "") {
             $("#CONTRACT_SIGN_TIME").tips({
                 side: 3,
                 msg: '请输入合同签订时间',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#CONTRACT_SIGN_TIME").focus();
             return false;
         }
         if ($("#CONTRACT_PRICE").val() == "") {
             $("#CONTRACT_PRICE").tips({
                 side: 3,
                 msg: '请输入合同金额(万元)',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#CONTRACT_PRICE").focus();
             return false;
         }
         if ($("#INVOICE_NUMBER").val() == "") {
             $("#INVOICE_NUMBER").tips({
                 side: 3,
                 msg: '请输入发票号码',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#INVOICE_NUMBER").focus();
             return false;
         }
         if ($("#INVOICE_ACCESSORY").val() == "") {
             $("#INVOICE_ACCESSORY").tips({
                 side: 3,
                 msg: '请输入发票附件',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#INVOICE_ACCESSORY").focus();
             return false;
         }
         if ($("#AUTHORIZATION").val() == "") {
             $("#AUTHORIZATION").tips({
                 side: 3,
                 msg: '请输入授权书丶随货同行单',
                 bg: '#AE81FF',
                 time: 2
             });
             $("#AUTHORIZATION").focus();
             return false;
         }*/
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
        localStorage.setItem("Identification", "save");
    }


    function getInfo() {
        var project = "${pd.SYS_ID}";

        //项目编号
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/projectmarket/projectMarketAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#projectId").append("<option value=''>请选择项目编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].PROJECT_ID == project) {
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID+"="+data.list[i].FUZEREN + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        } else {
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID +"="+data.list[i].FUZEREN+">" + data.list[i].SYS_ID + "-" + data.list[i].PROJECT_NAME + "</option>");
                        }
                    }
                    downList('projectId');
                }
            }
        });


        var xs = "${pd.SALES_CONTRACT_ID}";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/projectpurchase/getSalesContractAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#xiaoshouID").append("<option value=''>请选择销售合同编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SALES_CONTRACT_ID == xs) {
                            $("#xiaoshouID").append("<option value=" + data.list[i].SALES_CONTRACT_ID + " selected='selected'>" + data.list[i].SALES_CONTRACT_ID + "</option>");
                        } else {
                            $("#xiaoshouID").append("<option value=" + data.list[i].SALES_CONTRACT_ID + ">" + data.list[i].SALES_CONTRACT_ID + "</option>");
                        }
                    }
                    downList('xiaoshouID');

                }
            }
        });
        var gy = "${pd.SUPPLIER_ID}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>/projectpurchase/getSupplierAll.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#gongyingshangID").append("<option value=''>请选择供应商编号</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == gy) {
                            $("#gongyingshangID").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].SYS_ID + "-" + data.list[i].COMPANY_NAME + "</option>");
                        } else {
                            $("#gongyingshangID").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID + "-" + data.list[i].COMPANY_NAME + "</option>");
                        }
                    }
                    downList('gongyingshangID');
                }
            }
        });
    }

    //截取字符串
    function jiequ(str) {
        return str.substring(str.lastIndexOf('-') + 1, str.length);
    }

    $(function () {
        $("#xiaoshouID").change(function () {
            $("#SALES_CONTRACT_ID").val($("#xiaoshouID").val());
        })
        $("#gongyingshangID").change(function () {
            $("#SUPPLIER_ID").val($("#gongyingshangID").val());
            $("#SUPPLIERNAME").val(jiequ($("#gongyingshangID option:selected").text()));


            $.ajax({
                type: "POST",
                url: '<%=basePath%>/projectpurchase/getSupplierAll.do?tm=' + new Date().getTime(),
                data: {SUPPLIER_ID:  $("#gongyingshangID").val()},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#JINGYINGXUKEZHENG").val(fmtDate(parseFloat(data.list[0].JINGYINGXUKEZHENG)));
                        $("#FARENSHOUQUAN").val(fmtDate(parseFloat(data.list[0].FARENSHOUQUAN)));
                        $("#SHOUQUANWEITUO").val(fmtDate(parseFloat(data.list[0].SHOUQUANWEITUO)));
                        $("#SHENGCHANXUKEZHENG").val(fmtDate(parseFloat(data.list[0].SHENGCHANXUKEZHENG)));
                    }
                }
            });

        })
        $("#projectId").change(function () {
            var str = $("#projectId option:selected").text();
            var str1 = $("#projectId").val();
            $("#PROJECTNAME").val('');
            $("#SYS_ID").val('');
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/projectmarket/projectMarketById.do?PROJECT_ID=' +str1.substring(0,str1.indexOf("=")) ,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#PROJECTNAME").val(data.pd.PROJECT_NAME);
                        $("#SYS_ID").val(str.substring(0, str.indexOf("-")));
                        $("#FUZEREN").val(str1.substring( str1.indexOf("=")+1,str1.length));
                    }
                }
            });
        })


        $("#PURCHASE_CONTRACT_ID").val(getYmd("CC"));

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

        getAllFile("${pd.PURCHASE_ID}");
        fuxuan();
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});

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
    });
</script>
</body>
</html>