<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
						<form action="projectbid/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入项目名称、医院、招标公司" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td>
									<select class="chosen-select form-control"  id="ISSHENPI" name="ISSHENPI" data-placeholder="请选择" style="vertical-align:top;width: 80px;">
										<option <c:if test="${pd.ISSHENPI==''}">selected</c:if> value="">请选择</option>
										<option <c:if test="${pd.ISSHENPI==1}">selected</c:if> value="1">已审批</option>
										<option <c:if test="${pd.ISSHENPI==2}">selected</c:if> value="2">未审批</option>
										<option <c:if test="${pd.ISSHENPI==3}">selected</c:if> value="3">审批中</option>
									</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">选择公司</th>
									<th class="center">项目名称</th>
									<th class="center">医院</th>
<%--
                                    <th class="center">产品</th>
--%>
<%--
                                    <th class="center">上游</th>
--%>
									<th class="center">招标公司</th>
									<th class="center">招标代表</th>
									<th class="center">中标单位</th>
									<th class="center">中标价格(元)</th>
									<th class="center">投标保证金垫资金额(元)</th>
									<th class="center">投标保证金预计缴纳时间</th>
									<th class="center">投标保证金实际缴纳时间</th>
									<th class="center">开标日期</th>
									<th class="center">中标服务费垫资金额（元）</th>
									<th class="center">中标服务费预计缴纳时间</th>
									<th class="center">中标服务费实际缴纳时间</th>
									<th class="center">负责人</th>
								<%--	<th class="center">是否资料齐全</th>--%>
									<th class="center">标书制作人</th>

									<th class="center">备注</th>
									<th class="center">产品</th>

									<th class="center">附件</th>
								<%--	<th class="center">合同模板时间（1天)</th>
									<th class="center">合同双签时间（一周）</th>
									<th class="center">退投标保证金时间</th>--%>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX .cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.PROJECT_BID_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class='center'>${var.SELECTCOMPANY}</td>
											<td class='center'>${var.PROJECT_NAME}</td>
											<td class='center'>${var.HOSPITAL}</td>
<%--
                                            <td class='center'>${var.PRODUCT}</td>
--%>
<%--
                                            <td class='center'>${var.SUPPLIER}</td>
--%>
											<td class='center'>${var.TEBDERING}</td>
											<td class='center'>${var.REPRESENTATIVE}</td>
											<td class='center'>${var.WINNING_UNIT}</td>
											<td class='center'>${var.WINNING_PRICE}</td>
											<td class='center'>${var.GUARANTEE_MONEY}</td>
											<td class='center'>${var.SCHEDULED_TIME}</td>
											<td class='center'>${var.PRACTICAL_TIME}</td>
											<td class='center'>${var.BID_OPEN_TIME}</td>
											<td class='center'>${var.SERVICE_PRICE}</td>
											<td class='center'>${var.SCHEDULED_SERVICE_PRICE_TIME}</td>
											<td class='center'>${var.PRACTICAL_SERVICE_PRICE_TIME}</td>
											<td class='center'>${var.FUZEREN}</td>
										<%--	<td class='center'>${var.ISZILIAOQQ}</td>--%>
											<td class='center'>${var.BIAOSHUZHIZUOREN}</td>
											<td class='center'>${var.BZ}</td>
											<td class='center'><a onclick="selectProject2('${var.PROJECT_BID_ID}')" style=" cursor:pointer;">查看产品</a></td>

											<td class='center'><a onclick="allOaFile('${var.PROJECT_BID_ID}','929f3699b3a14562afbc34ca20a07b07')" style=" cursor:pointer;">查看附件</a></td>
											<%--<td class='center'>${var.CONTRACT_MODEL_TIME}</td>
											<td class='center'>${var.COUNTER_SIGN_TIME}</td>
											<td class='center'>${var.WITHDRAWAL_SECURITY}</td>--%>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<a  <c:if test="${var.STATUS==3||var.STATUS==1}">disabled="disabled" </c:if> class="<c:if test="${var.STATUS==1}">btn btn-xs btn-success</c:if><c:if test="${var.STATUS==2}">btn btn-xs btn-success</c:if><c:if test="${var.STATUS==3}">btn btn-xs btn-yellow</c:if>" title="提交" onclick="tijiao('${var.PROJECT_BID_ID}',this)">
														<i class="ace-icon fa fa-check-circle-o bigger-120" title="提交"></i>
													</a>

													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.PROJECT_BID_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.PROJECT_BID_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a  <c:if test="${var.STATUS==3||var.STATUS==1}">disabled="disabled" </c:if> class="btn btn-xs btn-success" title="提交" onclick="tijiao('${var.PROJECT_BID_ID}',this)">
																	<i class="ace-icon fa fa-check-circle-o bigger-120" title="提交"></i>
																</a>
															</li>
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.PROJECT_BID_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.PROJECT_BID_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
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
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<%@ include file="../../system/index/foot.jsp"%>
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
	<!-- 文件上传-->
	<script src="upload/oaFile.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态


        //查看产品信息
        function selectProject2(PARENT_ID){
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="新增";
            diag.URL = '<%=basePath%>projectproduct/list.do?PARENT_ID='+PARENT_ID;
            diag.Width = 800;
            diag.Height = 600;
            diag.Modal = true;				//有无遮罩窗口
            diag. ShowMaxButton = true;	//最大化按钮
            diag.ShowMinButton = true;		//最小化按钮
            diag.CancelEvent = function(){ //关闭事件
                diag.close();
            };
            diag.show();
        }


        function tijiao(PROJECT_BID_ID,obj){
            $.ajax({
                url: "<%=basePath%>projectbid/tijiaoFlow.do",
                data:{'PROJECT_BID_ID':PROJECT_BID_ID},
                success: function(data){
                    if(data.msg=="success"){
                        top.fhtaskmsg(data.ASSIGNEE_);
                        top.topTask();//刷新顶部任务列表
                        obj.setAttribute("disabled","disabled");
                        top.alert("提交成功！")
                    }else {
                        top.alert("提交失败，请稍后再试")
                    }
                }
            });
        }
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
            getPath('<%=basePath%>');
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>projectbid/goAdd.do';
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
                 getPath("<%=basePath%>");
                 clickCross();//清除不保存的图片
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>projectbid/delete.do?PROJECT_BID_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>projectbid/goEdit.do?PROJECT_BID_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>projectbid/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>projectbid/excel.do';
		}
	</script>


</body>
</html>