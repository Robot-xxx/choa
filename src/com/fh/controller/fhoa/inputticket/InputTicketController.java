package com.fh.controller.fhoa.inputticket;

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
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.fhoa.inputticket.InputTicketManager;

/** 
 * 说明：进项票管理
 * 创建时间：2018-09-26
 */
@Controller
@RequestMapping(value="/inputticket")
public class InputTicketController extends AcStartController {
	
	String menuUrl = "inputticket/list.do"; //菜单地址(权限用)
	@Resource(name="inputticketService")
	private InputTicketManager inputticketService;
	@Resource(name="supplierService")
	private SupplierManager supplierService;
	@Resource
	private AccessoryFileManager accessoryFileManager;
	SimpleDateFormat sd1 =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");



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
		pd = inputticketService.findById(pd);	//根据ID读取
		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("项目编号", pd.getString("PROJECT_ID"));
			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("采购合同", pd.getString("PURCHASENUMBER"));
			map1.put("进项票总额(元)", pd.getString("JINPRICE"));
			map1.put("发票号", pd.getString("TICKET_NO"));
			map1.put("已回票金额(元)", pd.getString("YIHUIPIAOJINE"));
			map1.put("金额(元)", pd.getString("MONEY"));
			map1.put("备注", pd.getString("JINBZ"));

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("OA_JINXIANGPIAOLIUCHENG",map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_quality");
			inputticketService.edit(pd);
			supplierService.editTableName(pd);


			map.put("ASSIGNEE_",Jurisdiction.getUsername());
			map.put("msg","success");
		} catch (Exception e) {
			map.put("msg","请联系管理员部署相应业务流程!");
			map.put("errer","errer");
		}

		return map;
	}




	/**获取进项票信息byid
	 * @return
	 */
	@RequestMapping(value="/getJinxXiangById")
	@ResponseBody
	public Map<String,Object> getJinxXiangById(){
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = inputticketService.findById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}




	/**获取进项票信息
	 * @return
	 */
	@RequestMapping(value="/getAllJinXiang")
	@ResponseBody
	public Map<String,Object> getAllJinXiang(Page page){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			page.setShowCount(999999);
			list = inputticketService.list(page);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("list",list);
		return map;
	}
	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "收发票联络单（模板）.xls", "收发票联络单（模板）.xls");
	}

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增InputTicket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("USERID",Jurisdiction.getUSERID());

		String inputticketid = this.get32UUID();
		Map<String, Object> map = new HashMap<>();
		String[] oafileList = pd.getString("oafileList").toString().split(",");
		map.put("oafileid", inputticketid);
		map.put("ids", oafileList);
		accessoryFileManager.oaFileEdit(map);

		pd.put("UPDATETIME", sd1.format(new Date()));

		pd.put("SYS_ID",inputticketid);	//主键
		pd.put("STATUS",2);
		inputticketService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除InputTicket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		inputticketService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改InputTicket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UPDATETIME", sd1.format(new Date()));

		inputticketService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表InputTicket");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(
				!Jurisdiction.getRnumbers().equals("('R20181028683296')") ||
						!Jurisdiction.getRnumbers().equals("('R20181028664118')") ||
						!Jurisdiction.getRnumbers().equals("('R20190123706606')")
		) {
			if (Jurisdiction.getRnumbers().equals("('R20181028135540')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028180980')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028198917')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028334317')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028366864')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028393142')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028397702')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028424192')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028494663')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028494663')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028664118')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028805468')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181028850724')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
			if (Jurisdiction.getRnumbers().equals("('R20181029191323')")) {
				pd.put("USERID", Jurisdiction.getUSERID());
			}
		}
		page.setPd(pd);
		List<PageData>	varList = inputticketService.list(page);	//列出InputTicket列表
		mv.setViewName("fhoa/inputticket/inputticket_list");
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
		mv.setViewName("fhoa/inputticket/inputticket_edit");
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
		pd = inputticketService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/inputticket/inputticket_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除InputTicket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			inputticketService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出InputTicket到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("选择公司");	//1
		titles.add("项目编号");	//1
		titles.add("项目名称");	//1
		titles.add("采购合同编号");	//1
		titles.add("进项票总额(元)");	//1
		titles.add("发票号");	//1
		titles.add("已回票金额(元)");	//1
		titles.add("金额(元)");	//1
		titles.add("更新时间");	//1
		titles.add("备注");	//1

		dataMap.put("titles", titles);
		List<PageData> varOList = inputticketService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SELECTCOMPANY"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROJECT_ID"));	    //1
			vpd.put("var3", varOList.get(i).getString("PROJECT_NAME"));	    //1
			vpd.put("var4", varOList.get(i).getString("PURCHASENUMBER"));	    //1
			vpd.put("var5", varOList.get(i).getString("JINPRICE"));	    //1
			vpd.put("var6", varOList.get(i).getString("TICKET_NO"));	    //1
			vpd.put("var7", varOList.get(i).getString("YIHUIPIAOJINE"));	    //1
			vpd.put("var8", varOList.get(i).getString("MONEY"));	    //1
			vpd.put("var9", varOList.get(i).getString("UPDATETIME"));	    //1
			vpd.put("var10", varOList.get(i).getString("BZ"));	    //1

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
}
