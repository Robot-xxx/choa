var oafileList = new Array();//全局变量文件id
var OverallPath;//请求路径
var parentid;//图片父类








//查看文件列表
function allOaFile(oafileid,FILETYPE){
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="查看文件";
    diag.URL = OverallPath+'/oafile/allList.do?keywords='+oafileid+"&FILETYPE="+FILETYPE;
    diag.Width = 1100;
    diag.Height = 600;
    diag.Modal = true;				//有无遮罩窗口
    diag. ShowMaxButton = true;	//最大化按钮
    diag.ShowMinButton = true;		//最小化按钮
    diag.CancelEvent = function(){ //关闭事件

        diag.close();
    };
    diag.show();
}


//图片上传页面
function add(PARENT_ID,FILETYPE) {

    top.jzts();
    var diag = new top.Dialog();
    diag.Drag = true;
    diag.Title = "新增";
    diag.URL = OverallPath+'oafile/goAdd.do?FILETYPE='+FILETYPE+'&PARENT_ID='+PARENT_ID;
    diag.Width = 460;
    diag.Height = 290;
    diag.Modal = true;				//有无遮罩窗口
    diag.ShowMaxButton = true;	//最大化按钮
    diag.ShowMinButton = true;		//最小化按钮
    diag.CancelEvent = function () { //关闭事件
        if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
            // if('${page.currentPage}' == '0'){
            top.jzts();
            setTimeout("self.location=self.location", 100);
            // }else{
            //  nextPage(${page.currentPage});
            //}
        }
        diag.close();
    };
    diag.show();
}

//删除未保存的图片
function clickCross() {
    var str = localStorage.getItem("Identification");
    if (str != 'null' && str != 'save') {
        $.ajax({
            type: "POST",
            url: OverallPath + '/oafile/deleteAll.do?tm=' + new Date().getTime(),
            data: {DATA_IDS: localStorage.getItem("oafileList").toString()},
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                top.hangge();//关闭遮罩
                top.Dialog.close();
            }
        });
    }
    localStorage.removeItem("oafileList");
    localStorage.removeItem("Identification");
}


//取得当前访问路径
function getPath(path) {
    OverallPath = path;
}

//获取图片信息
function getAllFile(PARENT_ID) {
    parentid = PARENT_ID;
    $("#append").children().remove();//移除节点
    $.ajax({
        url: "" + OverallPath + "oafile/list.do",
        data: {"PARENT_ID": PARENT_ID},
        success: function (data) {
            if (data.varList.length <= 0) {
                $("#append").append(
                    "<tr class='main_info'>" +
                    "<td colspan='100' class='center'>没有相关数据</td>" +
                    "</tr>"
                );
            }
            //拼接内容
            var context;
            for (var i = 0; i < data.varList.length; i++) {
                oafileList.push(data.varList[i].OAFILE_ID);
                context += "<tr id='cancel'>  " +
                    "<td class='center'>  " +
                    "<label class='pos-rel'><input type='checkbox' name='ids' value='" + data.varList[i].OAFILE_ID + "' class='ace'><span class='lbl'></span></label>  " +
                    "</td>  " +
                    "<td class='center' style='width: 30px;'>" + (i + 1) + "</td>  " +
                    "<td class='center'>  " +
                    "<img style='margin-top: -3px;' alt='" + data.varList[i].NAME + "' src='static/images/extension/" + data.varList[i].fileType + ".png'>  " +
                    "" + data.varList[i].NAME + "" +
                    "&nbsp;  " +
                    "<a style='  cursor:pointer;'  onclick=\"window.location.href='" + OverallPath + "/oafile/download.do?OAFILE_ID=" + data.varList[i].OAFILE_ID + "'\">[下载]</a>  " +
                    "</td>  " +
                    "<td class='center'>" + data.varList[i].USERNAME + "</td>  " +
                    "           <td class='center' style='width:150px;'>" + data.varList[i].CTIME + "</td>  " +
                    "           <td class='center' style='width:150px;'>" + data.varList[i].FILETYPE + "</td>  " +
                    "           <td class='center' style='width:100px;'>" + data.varList[i].BZ + "</td>  " +
                    "          </tr>";
            }
            $("#append").append(context);
            $("#oafileList").attr("value", oafileList);
            localStorage.setItem("oafileList", oafileList);

        }
    });


}

//复选框全选控制
function fuxuan() {

    var active_class = 'active';
    $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
        var th_checked = this.checked;//checkbox inside "TH" table header
        $(this).closest('table').find('tbody > tr').each(function () {
            var row = this;
            if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
            else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
        });
    });
}

//批量删除图片
function makeAll(msg) {
    bootbox.confirm(msg, function (result) {
        if (result) {
            var str = '';
            for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                if (document.getElementsByName('ids')[i].checked) {
                    if (str == '') str += document.getElementsByName('ids')[i].value;
                    else str += ',' + document.getElementsByName('ids')[i].value;
                }
                ;
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
                        url: OverallPath + '/oafile/deleteAll.do?tm=' + new Date().getTime(),
                        data: {DATA_IDS: str},
                        dataType: 'json',
                        //beforeSend: validateData,
                        cache: false,
                        success: function (data) {
                            top.hangge();//关闭遮罩
                            getAllFile(parentid);//刷新图片信息
                        }
                    });
                }
            }
            ;
        }
        ;
    });
};
