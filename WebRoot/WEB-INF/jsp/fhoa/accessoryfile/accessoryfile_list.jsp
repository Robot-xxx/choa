<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

                        <!-- 检索  -->
                        <form action="oafile/allList.do" method="post" name="Form" id="Form">
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <input type="hidden" value="${pd.keywords}" name="keywords">
                                        <input type="hidden" value="${pd.FILETYPE}" name="FILETYPE" id="FILETYPE">
                                    </td>
                                    <td>
                                        <div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="请输入文件名" class="nav-search-input"
                                                   id="nav-search-input" autocomplete="off" name="fileName"
                                                   value="${pd.fileName}" placeholder="请输入文件名"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
                                        </div>
                                    </td>
                                    <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"  onclick="tosearch();" title="检索"><i
                                            id="nav-search-icon"
                                            class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>

                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:35px;">
                                        <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox"/><span
                                                class="lbl"></span></label>
                                    </th>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">文件名字</th>
                                    <%--<th class="center">文件路径</th>--%>
                                    <th class="center">创建时间</th>
                                    <th class="center">备注</th>
                                    <th class="center">文件类型</th>
                                    <th class="center">上传者</th>
                                  <%--  <th class="center">文件大小</th>--%>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <c:if test="${QX.cha == 1 }">
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr>
                                                    <td class='center'>
                                                        <label class="pos-rel"><input type='checkbox' name='ids'
                                                                                      value="${var.OAFILE_ID}"
                                                                                      class="ace"/><span
                                                                class="lbl"></span></label>
                                                    </td>
                                                    <td class='center'
                                                        style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
                                                    <td class='center'>
                                                        <img style="margin-top: -3px;" alt="${var.NAME}" src="static/images/extension/${var.fileType}.png">
                                                            ${var.NAME}${fn:substring(var.FILEPATH ,19,fn:length(var.FILEPATH))}
                                                        &nbsp;
                                                        <c:if test="${var.fileType == 'tupian' }"><a style="cursor:pointer;" onclick="showTU('uploadFiles/uploadFile/${var.FILEPATH}','yulantu${vs.index+1}');">[预览]</a></c:if>
                                                        <c:if test="${var.fileType == 'pdf' }"><a style="cursor:pointer;" onclick="goViewPdf('${var.NAME}${fn:substring(var.FILEPATH ,19,fn:length(var.FILEPATH))}','${var.OAFILE_ID}');">[预览]</a></c:if>
                                                        <c:if test="${var.fileType == 'wenben' }"><a style="cursor:pointer;" onclick="goViewTxt('${var.NAME}${fn:substring(var.FILEPATH ,19,fn:length(var.FILEPATH))}','${var.OAFILE_ID}','gbk');">[预览]</a></c:if>
                                                        <div class="yulantu" id="yulantu${vs.index+1}"></div>
                                                    </td>
                                                 <%--   <td class='center'>${var.FILEPATH}</td>--%>
                                                    <td class='center'>${var.CTIME}</td>
                                                    <td class='center'>${var.BZ}</td>
                                                    <td class='center'>${var.FILETYPE}</td>
                                                    <td class='center'>${var.USERNAME}</td>
                                                   <%-- <td class='center'>${var.FILESIZE}</td>--%>
                                                    <td class="center">

                                                        <div class="hidden-sm hidden-xs btn-group">
                                                            <a style="cursor:pointer;"
                                                               onclick="window.location.href='<%=basePath%>/oafile/download.do?OAFILE_ID=${var.OAFILE_ID}'"
                                                               class="tooltip-success" data-rel="tooltip" title="下载">
																	<span class="green">
																		<i class="ace-icon fa fa-cloud-download bigger-120"></i>
																	</span>
                                                            </a>


                                                        </div>
                                                        <div class="hidden-md hidden-lg">
                                                            <div class="inline pos-rel">
                                                                <button class="btn btn-minier btn-primary dropdown-toggle"
                                                                        data-toggle="dropdown" data-position="auto">
                                                                    <i class="ace-icon fa fa-cog icon-only bigger-110"></i>
                                                                </button>

                                                                <ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
                                                                    <li>
                                                                        <a style="cursor:pointer;"
                                                                           onclick="window.location.href='<%=basePath%>/oafile/download.do?ACCESSORYFILE_ID=${var.OAFILE_ID}'"
                                                                           class="tooltip-success" data-rel="tooltip"
                                                                           title="下载">
																	<span class="green">
																		<i class="ace-icon fa fa-cloud-download bigger-120"></i>
																	</span>
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <a style="cursor:pointer;"
                                                                           onclick="del('${var.OAFILE_ID}');"
                                                                           class="tooltip-error" data-rel="tooltip"
                                                                           title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                        </c:if>

                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center" >没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                            <a class="btn btn-mini btn-success" onclick="add('${pd.FILETYPE}');">上传</a>
                                            <a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');"
                                               title="批量删除"><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
                                        </td>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
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
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态


    //预览pdf
    function goViewPdf(fileName,Id){
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title =fileName;
        diag.URL = '<%=basePath%>oafile/goViewPdf.do?OAFILE_ID='+Id;
        diag.Width = 1000;
        diag.Height = 600;
        diag.Modal = false;				//有无遮罩窗口
        diag. ShowMaxButton = true;		//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function(){ 	//关闭事件
            diag.close();
        };
        diag.show();
    }

    //预览txt,java,php,等文本文件页面
    function goViewTxt(fileName,Id,encoding){
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title =fileName;
        diag.URL = '<%=basePath%>oafile/goViewTxt.do?OAFILE_ID='+Id+'&encoding='+encoding;
        diag.Width = 1000;
        diag.Height = 608;
        diag.Modal = false;				//有无遮罩窗口
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function(){ 	//关闭事件
            diag.close();
        };
        diag.show();
    }
    //现实图片
    function showTU(path,TPID){
        console.log(path)
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ='预览';
        diag.URL = '<%=basePath%>'+path;
        diag.Width = 1000;
        diag.Height = 608;
        diag.Modal = false;				//有无遮罩窗口
        diag.ShowMinButton = true;		//最小化按钮
        diag.ShowMaxButton = true;	//最大化按钮
        diag.CancelEvent = function(){ 	//关闭事件
            diag.close();
        };
        diag.show();
    }
    //显示图片
    /*function showTU(path,TPID){
        $("#"+TPID).html('<img width="300" src="'+path+'">');
        $("#"+TPID).show();
    }*/

    //隐藏图片
   /* function hideTU(TPID){
        $("#"+TPID).hide();
    }*/


    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }

    $(function () {

        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                .off('resize.chosen')
                .on('resize.chosen', function () {
                    $('.chosen-select').each(function () {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    });
                }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }


        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });
    });

    //新增
    function add(FILETYPE) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "新增";
        diag.URL = '<%=basePath%>oafile/goAdd.do?PARENT_ID=${pd.keywords}'+"&FILETYPE="+$("#FILETYPE").val();
        diag.Width = 450;
        diag.Height = 355;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                if ('${page.currentPage}' == '0') {
                    tosearch();
                } else {
                    tosearch();
                }
            }
            diag.close();
        };
        diag.show();
    }

    //删除
    function del(Id) {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "<%=basePath%>oafile/delete.do?OAFILE_ID=" + Id + "&tm=" + new Date().getTime();
                $.get(url, function (data) {
                    tosearch();
                });
            }
        });
    }

    //修改
    function edit(Id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "编辑";
        diag.URL = '<%=basePath%>oafile/goEdit.do?OAFILE_ID=' + Id;
        diag.Width = 450;
        diag.Height = 355;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                tosearch();
            }
            diag.close();
        };
        diag.show();
    }

    //批量操作
    function makeAll(msg) {
        bootbox.confirm(msg, function (result) {
            if (result) {
                var str = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (document.getElementsByName('ids')[i].checked) {
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if (str == '') {
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                        buttons:
                            {"button": {"label": "确定", "className": "btn-sm btn-success"}}
                    });
                    $("#zcheckbox").tips({
                        side: 1,
                        msg: '点这里全选',
                        bg: '#AE81FF',
                        time: 8
                    });
                    return;
                } else {
                    if (msg == '确定要删除选中的数据吗?') {
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>oafile/deleteAll.do?tm=' + new Date().getTime(),
                            data: {DATA_IDS: str},
                            dataType: 'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function (data) {
                                $.each(data.list, function (i, list) {
                                    tosearch();
                                });
                            }
                        });
                    }
                }
            }
        });
    };


</script>


</body>
</html>