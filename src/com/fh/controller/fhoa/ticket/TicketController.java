package com.fh.controller.fhoa.ticket;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.fh.controller.activiti.AcStartController;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
import com.fh.service.fhoa.supplier.SupplierManager;
import com.fh.util.*;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.fhoa.ticket.TicketManager;

/** 
 * 说明：开票情况
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value="/ticket")
public class TicketController extends AcStartController {
	
	String menuUrl = "ticket/list.do"; //菜单地址(权限用)
	@Resource(name="ticketService")
	private TicketManager ticketService;
	@Resource
	private AccessoryFileManager accessoryFileManager;

	SimpleDateFormat sd =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Resource(name="supplierService")
	private SupplierManager supplierService;

	/**提交流程
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/tijiaoFlow")
	@ResponseBody
	public  Map<String, Object> tijiaoFlow() throws Exception{
		Map<String, Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = ticketService.findById(pd);	//根据ID读取
		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("项目编号", pd.getString("SYS_ID"));
			map1.put("销售合同", pd.getString("SALES_CONTRACT_ID"));
			map1.put("进项票总额（万元）", pd.get("TICKET_PRICE").toString());
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("TICKET_ID")+"','9c3468e93719466ca4693babf2fa3908')\" style=' cursor:pointer;'>查看附件</a>");

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("oa_kaipiaoshenqing",map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_open_ticket");
			ticketService.edit(pd);
			supplierService.editTableName(pd);




			map.put("msg","success");
			map.put("ASSIGNEE_",Jurisdiction.getUsername());
		} catch (Exception e) {
			map.put("msg","请联系管理员部署相应业务流程!");
			map.put("errer","errer");
		}

		return map;
	}




	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Ticket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERID",Jurisdiction.getUSERID());
		String ticketid = this.get32UUID();
		Map<String, Object> map = new HashMap<>();
		String[] oafileList = pd.getString("oafileList").toString().split(",");
		map.put("oafileid", ticketid);
		map.put("ids", oafileList);
		accessoryFileManager.oaFileEdit(map);

		pd.put("STATUS",2);

		pd.put("TICKET_ID", ticketid);	//主键
		pd.put("UPDATETIME", sd.format(new Date()));

		ticketService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Ticket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		ticketService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Ticket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UPDATETIME", sd.format(new Date()));

		ticketService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Ticket");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028135540')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028180980')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028198917')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028334317')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028366864')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028393142')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028397702')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028424192')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028494663')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028494663')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028664118')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028805468')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181028850724')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		if(Jurisdiction.getRnumbers().equals("('R20181029191323')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
		page.setPd(pd);
		List<PageData>	varList = ticketService.list(page);	//列出Ticket列表
		mv.setViewName("fhoa/ticket/ticket_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("fhoa/ticket/ticket_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = ticketService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/ticket/ticket_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Ticket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			ticketService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Ticket到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("系统编序号");	//1
		titles.add("销售合同附件");	//2
		titles.add("进项票信息附件");	//3
		titles.add("进项票金额(万元)");	//4
		titles.add("开票金额");	//5
		titles.add("发票号码");	//6
		titles.add("发票附件");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = ticketService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SYS_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("SALES_CONTRACT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("TICKET_INFO"));	    //3
			vpd.put("var4", varOList.get(i).get("TICKET_PRICE").toString());	    //4
			vpd.put("var5", varOList.get(i).get("OPEN_TICKET_PRICE").toString());	    //5
			vpd.put("var6", varOList.get(i).getString("INVOICE_NUMBER"));	    //6
			vpd.put("var7", varOList.get(i).getString("INVOICE"));	    //7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "开发票联络单.xls", "开发票联络单.xls");
	}
}
