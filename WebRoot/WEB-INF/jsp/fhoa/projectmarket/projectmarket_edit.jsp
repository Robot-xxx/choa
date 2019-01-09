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

                        <form action="projectmarket/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="PROJECT_MARKET_ID" id="PROJECT_MARKET_ID"
                                   value="${pd.PROJECT_MARKET_ID}"/>
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
                                            <input type="text" hidden name="SELECTCOMPANYID" id="SELECTCOMPANYID"
                                                   value="${pd.SELECTCOMPANYID}"
                                                   style="width:60%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目编号:</td>

                                        <td>
                                            <select class="chosen-select form-control" id="projectId"
                                                    style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input type="hidden" name="FUZEREN" id="FUZEREN">
                                            <input hidden type="text" name="SYS_ID" id="SYS_ID" value="${pd.SYS_ID}"
                                                   maxlength="100" placeholder="这里输入系统编序号" title="系统编序号"
                                                   style="width:98%;"/>

                                        <span style="color: red">注:完成立项流程后才能选择对应项目</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>项目名称:</td>
                                        <td><input type="text" readonly name="PROJECT_NAME" id="PROJECT_NAME"
                                                   value="${pd.PROJECT_NAME}" maxlength="100" placeholder="项目名称"
                                                   title="项目名称" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>销售合同编号:</td>
                                        <td><input type="text" readonly name="SALES_CONTRACT_ID" id="SALES_CONTRACT_ID"
                                                   value="${pd.SALES_CONTRACT_ID}" maxlength="100"
                                                   placeholder="这里输入销售合同编号" title="销售合同编号" style="width:98%;"/></td>
                                    </tr>


                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>下游:</td>
                                        <td>
                                            <select class="chosen-select form-control"  name="CLIENT_ID" id="client_id" style="vertical-align:top;width: 68px; width: 98%">

                                            </select>
                                            <input hidden type="text" name="CLIENT_NAME" id="CLIENT_NAME" value="${pd.CLIENT_NAME}"
                                                   maxlength="100" placeholder="这里输入客户序号" title="客户序号"
                                                   style="width:98%;"/>
                                        <span style="color: red">注:需提前在下游管理处填写并通过审批才能选择对应客户</span>
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

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>合同总价(万元):</td>
                                        <td><input type="number" name="CONTRACT_PRICE" id="CONTRACT_PRICE"
                                                   value="${pd.CONTRACT_PRICE}" maxlength="12" placeholder="这里输入合同总价"
                                                   title="合同总价" style="width:98%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>大设备预支款金额:</td>
                                        <td><input type="text" name="EQUIPMENT_ADVANCE" id="EQUIPMENT_ADVANCE"
                                                   value="${pd.EQUIPMENT_ADVANCE}" maxlength="12"
                                                   placeholder="这里输入大设备预支款金额" title="大设备预支款金额" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;"><font color="red">*</font>预计到账时间:</td>
                                        <td><input class="span10 date-picker" name="PREDICT_ACCOUNT_TIME"
                                                   id="PREDICT_ACCOUNT_TIME" value="${pd.PREDICT_ACCOUNT_TIME}"
                                                   type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="预计到账时间" title="预计到账时间" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">实际到账时间:</td>
                                        <td><input class="span10 date-picker" name="PRACTICAL_ACCOUT_TIME"
                                                   id="PRACTICAL_ACCOUT_TIME" value="${pd.PRACTICAL_ACCOUT_TIME}"
                                                   type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
                                                   placeholder="实际到账时间" title="实际到账时间" style="width:98%;"/></td>
                                    </tr>
                                 <%--   <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">累计开票总额:</td>
                                        <td><input type="number" name="CUMULATIVE_BILLING" id="CUMULATIVE_BILLING"
                                                   value="${pd.CUMULATIVE_BILLING}" maxlength="32"
                                                   placeholder="这里输入累计开票总额" title="累计开票总额" style="width:98%;"/></td>
                                    </tr>--%>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">到货时间:</td>
                                        <td><input class="span10 date-picker" name="ARRIVAL_TIME" id="ARRIVAL_TIME"
                                                   value="${pd.ARRIVAL_TIME}" type="text" data-date-format="yyyy-mm-dd"
                                                   readonly="readonly" placeholder="到货时间" title="到货时间"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">验收时间:</td>
                                        <td><input class="span10 date-picker" name="RECEPTION_TIME" id="RECEPTION_TIME"
                                                   value="${pd.RECEPTION_TIME}" type="text"
                                                   data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="验收时间"
                                                   title="验收时间" style="width:98%;"/></td>
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
                                    <%--<tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">验收附件:</td>
                                        &lt;%&ndash;
                                                                        <td><input type="text" name="RECEPTION" id="RECEPTION" value="${pd.RECEPTION}" maxlength="255" placeholder="这里输入验收附件" title="验收附件" style="width:98%;"/></td>
                                        &ndash;%&gt;
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
                                                                                           onclick="add('${pd.PROJECT_MARKET_ID}');">上传</a>
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
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- 上传附件 -->
<script src="upload/oaFile.js"></script>
<!-- 获取时间 -->
<script src="common/getSysId.js"></script>
<!-- 下拉列表框 -->
<script src="common/downList.js"></script>


<script type="text/javascript">
    var str = "<option value=''>请选择类型</option>";
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
        if ($("#CLIENT_ID").val() == "") {
            $("#CLIENT_ID").tips({
                side: 3,
                msg: '请输入客户序号',
                bg: '#AE81FF',
                time: 2
            });
            $("#CLIENT_ID").focus();
            return false;
        }

        if ($("#CONTRACT_PRICE").val() == "") {
            $("#CONTRACT_PRICE").tips({
                side: 3,
                msg: '请输入合同总价',
                bg: '#AE81FF',
                time: 2
            });
            $("#CONTRACT_PRICE").focus();
            return false;
        }

        if ($("#EQUIPMENT_ADVANCE").val() == "") {
            $("#EQUIPMENT_ADVANCE").tips({
                side: 3,
                msg: '请输入大设备预支款金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#EQUIPMENT_ADVANCE").focus();
            return false;
        }/*
        if ($("#PREDICT_ACCOUNT_TIME").val() == "") {
            $("#PREDICT_ACCOUNT_TIME").tips({
                side: 3,
                msg: '请输入预计到账时间',
                bg: '#AE81FF',
                time: 2
            });
            $("#PREDICT_ACCOUNT_TIME").focus();
            return false;
        }*/
  /*    if($("#PRACTICAL_ACCOUT_TIME").val()==""){
                $("#PRACTICAL_ACCOUT_TIME").tips({
                    side:3,
                    msg:'请输入实际到账时间',
                    bg:'#AE81FF',
                    time:2
                });
                $("#PRACTICAL_ACCOUT_TIME").focus();
            return false;
            }*/
   /*     if ($("#CUMULATIVE_BILLING").val() == "") {
            $("#CUMULATIVE_BILLING").tips({
                side: 3,
                msg: '请输入累计开票总额',
                bg: '#AE81FF',
                time: 2
            });
            $("#CUMULATIVE_BILLING").focus();
            return false;
        }*//*
        if ($("#ARRIVAL_TIME").val() == "") {
            $("#ARRIVAL_TIME").tips({
                side: 3,
                msg: '请输入到货时间',
                bg: '#AE81FF',
                time: 2
            });
            $("#ARRIVAL_TIME").focus();
            return false;
        }*//*
        if ($("#RECEPTION_TIME").val() == "") {
            $("#RECEPTION_TIME").tips({
                side: 3,
                msg: '请输入验收时间',
                bg: '#AE81FF',
                time: 2
            });
            $("#RECEPTION_TIME").focus();
            return false;
        }*/

        if ($("#RECEPTION").val() == "") {
            $("#RECEPTION").tips({
                side: 3,
                msg: '请输入验收附件',
                bg: '#AE81FF',
                time: 2
            });
            $("#RECEPTION").focus();
            return false;
        }
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
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID +"="+ data.list[i].FUZEREN+ " selected='selected'>" + data.list[i].SYS_ID + "=》" + data.list[i].PROJECT_NAME + "</option>");
                        } else {
                            $("#projectId").append("<option value=" + data.list[i].PROJECT_ID +"="+ data.list[i].FUZEREN+ ">" + data.list[i].SYS_ID + "=》" + data.list[i].PROJECT_NAME + "</option>");
                        }
                    }
                    downList('projectId');
                }
            }
        });


        var client_id = "${pd.CLIENT_ID}";

        //客户信息
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/customer/getAllCustomer.do?tm=' + new Date().getTime(),
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.errInfo == "success") {
                    $("#client_id").append("<option value=''>请选择客户</option>");
                    for (var i = 0; i < data.list.length; i++) {
                        if (data.list[i].SYS_ID == client_id) {
                            $("#client_id").append("<option value=" + data.list[i].SYS_ID + " selected='selected'>" + data.list[i].COMPANY_NAME + "</option>");
                        } else {
                            $("#client_id").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].COMPANY_NAME + "</option>");
                        }
                    }
                    downList('client_id');
                }
            }
        });


    }
    function fmtDate(obj){
        console.log(obj)
        var date =  new Date(obj);
        var y = 1900+date.getYear();
        var m = "0"+(date.getMonth()+1);
        var d = "0"+date.getDate();
        return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length);
    }
    $(function () {

        $("#client_id").change(function () {


            $("#CLIENT_ID").val( $("#client_id").val());
            $("#CLIENT_NAME").val( $("#client_id option:selected").text());
            $("#JINGYINGXUKEZHENG").val('');
            $("#FARENSHOUQUAN").val('');
            $("#SHOUQUANWEITUO").val('');
            $("#JINGYINGXUKEZHENG").val('');

            $.ajax({
                type: "POST",
                url: '<%=basePath%>/customer/getAllCustomer.do?tm=' + new Date().getTime(),
                data: {CUSTOMER_ID:  $("#client_id").val()},
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

        });





        //项目编号
        $("#projectId").change(function () {
            var str= $("#projectId option:selected").text();
            var str1= $("#projectId").val();
            $("#PROJECT_NAME").val('');
            $("#SYS_ID").val('');
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/projectmarket/projectMarketById.do?PROJECT_ID=' + str1.substring(0,str1.indexOf("=")),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.errInfo == "success") {
                        $("#PROJECT_NAME").val(data.pd.PROJECT_NAME);
                        $("#SYS_ID").val(str.substring(0,str.indexOf("=》")));
                        $("#FUZEREN").val(str1.substring(str1.indexOf("=")+1,str1.length));
                    }
                }
            });
        })
        getInfo();


        $("#LICENCE").change(function () {
            var str = $("#LICENCE").val();
            var dicID = str.substring(0, str.indexOf("-"));
            var name_en = str.substring(str.indexOf("-") + 1, str.length);
            if (dicID == "e84851e3b96c4cdda0937fd681c7a3e6") {
                $("#xuanzeCompany").removeAttr("hidden");
                $("#xuanzeCompany").val('');
                $("#SELECTCOMPANYID").val('e84851e3b96c4cdda0937fd681c7a3e6');
            } else {
                $("#xuanzeCompany").attr("hidden", "hidden");
                $("#SELECTCOMPANYID").val(dicID);
                console.log($("#SELECTCOMPANYID").val())
                $("#xuanzeCompany").val($("#LICENCE option:selected").text());
            }
            $("#SALES_CONTRACT_ID").val(getSysId('X' + name_en));

        })


        getPath('<%=basePath%>');
        getAllFile("${pd.PROJECT_MARKET_ID}");
        fuxuan();
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});


        var BUSINESS = "${pd.SELECTCOMPANYID}";
        var COMPAN = "${pd.SELECTCOMPANY}";

        $.ajax({
            type: "POST",
            url: '<%=basePath%>dictionaries/getLevels.do?tm=' + new Date().getTime(),
            data: {DICTIONARIES_ID: 'cb8c6f2673bc4358b170efc7e2c6e309'},
            dataType: 'json',
            cache: false,
            success: function (data) {
                //  console.log(JSON.stringify(data))

                $("#LICENCE").append("<option value=''>请选择类型</option>");
                $.each(data.list, function (i, dvar) {
                    if (BUSINESS == dvar.DICTIONARIES_ID) {

                        $("#LICENCE").append("<option value=" + dvar.DICTIONARIES_ID + "-" + dvar.NAME_EN + " selected='selected'>" + dvar.NAME + "</option>");
                    } else {
                        $("#LICENCE").append("<option value=" + dvar.DICTIONARIES_ID + "-" + dvar.NAME_EN + ">" + dvar.NAME + "</option>");
                    }
                });
                if ($('#msg').val() == "edit") {
                    $("#xuanzeCompany").val(COMPAN);
                }
            }
        });


    });
</script>
</body>
</html>