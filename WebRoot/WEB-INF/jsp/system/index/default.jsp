<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">

    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <link rel="stylesheet" href="searchableSelect/jquery.searchableSelect.css"/>

    <link rel="stylesheet" href="tongji/bootstrap.min.css"/>
    <link rel="stylesheet" href="yetep/css/ystep.css">


    <!-- jsp文件头和头部 -->
    <%@ include file="../index/top.jsp" %>

    <!-- 百度echarts -->
    <script src="plugins/echarts/echarts.min.js"></script>
    <script type="text/javascript">
        setTimeout("top.hangge()", 500);
    </script>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="hr hr-18 dotted hr-double"></div>
                <div class="row">
                    <div class="col-xs-12">

                        <div class="alert alert-block alert-success">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="ace-icon fa fa-times"></i>
                            </button>
                            <i class="ace-icon fa fa-check green"></i>
                            欢迎使用 OA;
                        </div>


                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <div>
                    <div id="dynamic-table_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <div class="row">
                           <%-- <div class="col-xs-6">
                                <div class="dataTables_length" id="dynamic-table_length"><label>显示 <select
                                        name="dynamic-table_length" aria-controls="dynamic-table"
                                        class="form-control input-sm">
                                    <option value="10">10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select> 行</label></div>
                            </div>--%>
                           <%-- <div class="col-xs-6">
                                <div id="dynamic-table_filter" class="dataTables_filter"><label>Search:<input
                                        type="search" class="form-control input-sm" placeholder=""
                                        aria-controls="dynamic-table"></label></div>
                            </div>--%>

                        </div>

                        <table id="dynamic-table"
                               class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                               aria-describedby="dynamic-table_info">
                            <thead>
                            <tr role="row">
                                <td style="width:75px;text-align: right;padding-top: 13px;">项目编号:</td>
                                <td>

                                    <select class="chosen-select form-control" id="projectId"
                                            style="vertical-align:top;width: 68px; width: 98%">

                                    </select>

                                </td>
                            </tr>

                            <tr role="row">
                                <th style="text-align: center"  tabindex="0" aria-controls="dynamic-table"  colspan="11"
                                     >项目情况进度表
                                </th>
                            </tr>
                            <tr role="row">
                                <th style="text-align: center"    tabindex="0" aria-controls="dynamic-table"  colspan="2">
                                </th>

                                <th style="text-align: center"    tabindex="0" aria-controls="dynamic-table"  colspan="3"
                                     >项目投标情况
                                </th>
                                <th style="text-align: center"    tabindex="0" aria-controls="dynamic-table"  colspan="3"
                                     >项目销售情况
                                </th>
                                <th style="text-align: center"    tabindex="0" aria-controls="dynamic-table"  colspan="3"
                                     >项目采购情况
                                </th>
                            </tr>

                            <tr role="row">

                                <th   class="hidden-480"  tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                     >项目编号
                                </th>
                                <th    class="hidden-480" tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    >项目名称
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >中标公司
                                </th>
                                <th    tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1"

                                   >审批状态
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1"    >中标价格
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1"    >下游名称
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >审批状态
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >合同总价
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >供应商名称
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >审批状态
                                </th>
                                <th class="hidden-480 " tabindex="0" aria-controls="dynamic-table" rowspan="1"
                                    colspan="1" >合同总价
                                </th>
                            </tr>
                            </thead>

                            <tbody>

                            <tr role="row" id="trRow">

                            </tr>

                            </tbody>
                        </table>
                        <div class="row">
                            <%--<div class="col-xs-6">
                                <div class="dataTables_info" id="dynamic-table_info" role="status" aria-live="polite">
                                    Showing 1 to 10 of 23 entries<span class="select-info"><span class="select-item">1 row selected</span><span
                                        class="select-item"></span><span class="select-item"></span></span></div>
                            </div>--%>
                            <div class="col-xs-6">
                               <%-- <div class="dataTables_paginate paging_simple_numbers" id="dynamic-table_paginate">
                                    <ul class="pagination">
                                        <li class="paginate_button previous disabled" aria-controls="dynamic-table"
                                            tabindex="0" id="dynamic-table_previous"><a href="#">Previous</a></li>
                                        <li class="paginate_button active" aria-controls="dynamic-table" tabindex="0"><a
                                                href="#">1</a></li>
                                        <li class="paginate_button " aria-controls="dynamic-table" tabindex="0"><a
                                                href="#">2</a></li>
                                        <li class="paginate_button " aria-controls="dynamic-table" tabindex="0"><a
                                                href="#">3</a></li>
                                        <li class="paginate_button next" aria-controls="dynamic-table" tabindex="0"
                                            id="dynamic-table_next"><a href="#">Next</a></li>
                                    </ul>
                                </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.page-content -->

                <div class="ystep4" style="width: 100%"></div>
                <div class="ystep5" style="width: 100%"></div>


            </div>
        </div>
        <!-- /.main-content -->


        <!-- 返回顶部 -->
        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
            <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>

    </div>
    <!-- /.main-container -->

    <!-- basic scripts -->
    <!-- 页面底部js¨ -->
    <%@ include file="../index/foot.jsp" %>
    <!-- ace scripts -->
    <script src="static/ace/js/ace/ace.js"></script>
    <script src="tongji/bootstrap.min.js"></script>
    <script src="tongji/jquery.min.js"></script>
    <script src="yetep/js/ystep.js"></script>
    <!-- 下拉框 -->
    <script src="static/ace/js/chosen.jquery.js"></script>
    <!-- 下拉列表框 -->
    <script src="common/downList.js"></script>




    <!-- inline scripts related to this page -->
    <script type="text/javascript">
        $(top.hangge());
        //根据jQuery选择器找到需要加载ystep的容器
        //loadStep 方法可以初始化ystep

$(function () {

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
                    $("#projectId").append("<option value=" + data.list[i].SYS_ID + ">" + data.list[i].SYS_ID + "=>" + data.list[i].PROJECT_NAME + "</option>");
                }

                downList('projectId');

            }
        }
    });

    $("#projectId").change(function (){
        $("#trRow").children().remove();
        var str= $("projectId option:selected").text();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>/project/projectTongJi.do?tm=' + new Date().getTime(),
            dataType: 'json',
            data:{PROJECT_ID:$("#projectId").val()},
            cache: false,
            success: function (data) {
                console.log(JSON.stringify(data))
                if (data.errInfo == "success") {
                    $("#trRow").append("" +
                        "<td>"+data.pd.SYS_ID+"</td>" +
                        "<td>"+data.pd.PROJECT_NAME+"</td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "" +
                        "");

                    var arrys = [data.list1.length,data.list2.length,data.list3.length];
                    console.log(arrys.sort()[2]);
                    console.log(arrys.sort());
                }

            }
        });


    })





})
        $(".ystep4").loadStep({
            size: "small",
            color: "blue",
            steps: [{
                title: "项目立项",
                content: "接到项目后立项"
            }, {
                title: "首营资料",
                content: "在合作方管理、产品管理处填写首营资料并通过质控审批后方可进行投标、销售、采购等流程"
            }, {
                title: "项目投标",
                content: "填写投标相关的基本信息，具体要求详见流程图"
            }, {
                title: "项目销售",
                content: "填写销售相关的基本信息，具体要求详见流程图"
            }, {
                title: "项目采购",
                content: "填写采购相关的基本信息，具体要求详见流程图"
            }]
        });
        $(".ystep5").loadStep({
            size: "small",
            color: "blue",
            steps: [{
                title: "付款申请",
                content: "填写上游管理并通过审批后方可进行（非合作方请在非合作方管理处填写，无需审批），需要部门经理（运营部）审批后方可打印付款申请单"
            }, {
                title: "认款管理",
                content: "需先完成项目立项。填写回款基本信息，点击认款认领对应款项，并上传银行底单"
            }, {
                title: "进项票",
                content: "需先完成立项流程与采购合同流程。填写进项票情况，下载模板并填写完成后，将其上传到附件处，等待审批流程完成"
            }, {
                title: "开票",
                content: "需先完成立项流程、采购合同流程和销售合同流程。填写开票情况，下载模板并填写完成后，将其上传到附件处，等待审批流程完成"
            }, {
                title: "报销流程",
                content: "若为项目相关报销则需先完成立项流程"
            }]
        });
        $(".ystep4").setStep(5);
        $(".ystep5").setStep(5);




    </script>


    <script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>