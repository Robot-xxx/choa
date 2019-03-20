package com.fh.controller.fhoa.project;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;
import javax.xml.crypto.dsig.keyinfo.PGPData;

import com.fh.controller.activiti.AcStartController;
import com.fh.entity.system.Dictionaries;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
import com.fh.service.fhoa.projectbid.ProjectBidManager;
import com.fh.service.fhoa.projectmarket.ProjectMarketManager;
import com.fh.service.fhoa.projectpurchase.ProjectPurchaseManager;
import com.fh.service.fhoa.supplier.SupplierManager;
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
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.fhoa.project.ProjectManager;

/** 
 * 说明：项目立项
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value="/project")
public class ProjectController extends AcStartController {
	
	String menuUrl = "project/list.do"; //菜单地址(权限用)
	@Resource(name="projectService")
	private ProjectManager projectService;


	@Resource(name="supplierService")
	private SupplierManager supplierService;

	@Resource(name = "projectpurchaseService")
	private ProjectPurchaseManager projectpurchaseService;//项目采购

	@Resource(name="projectmarketService")
	private ProjectMarketManager projectmarketService;//项目销售

	@Resource(name = "projectbidService")
	private ProjectBidManager projectbidService;//项目投标


	SimpleDateFormat sd =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");



	/**查询综合数据统计
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/projectTongJi")
	@ResponseBody
	public  Map<String, Object> projectTongJi() throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<PageData> list1= new ArrayList<>();
		List<PageData> list2= new ArrayList<>();
		List<PageData> list3= new ArrayList<>();
		PageData pd = new PageData();

		pd = this.getPageData();
		try {
			list1 = projectbidService.findProjectBid(pd);
			list2 = projectmarketService.findProjectMarket(pd);
			list3 = projectpurchaseService.findProjectPurchase(pd);
			pd=projectService.findByProject(pd);
			map.put("list1", list1);
			map.put("list2", list2);
			map.put("list3", list3);
			map.put("pd", pd);
			map.put("errInfo","success");
			return map;

		}catch (Exception e){
			e.printStackTrace();
			map.put("errInfo","error");
		}

		return map;
	}






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
		pd = projectService.findById(pd);	//根据ID读取
		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("公司",pd.getString("SELECTCOMPANY") );			//选择公司

			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("选择公司", pd.getString("SELECTCOMPANY"));
			map1.put("项目编号", pd.getString("SYS_ID"));
			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("医院", pd.getString("HOSPITAL"));
			map1.put("投标限价（元）", pd.get("LIMITED_PRICE").toString());
			map1.put("委托公司", pd.getString("CORPORATE_COMPANY"));
			map1.put("委托公司老板", pd.getString("CORPORATE_BOSS"));
			map1.put("委托公司老板电话", pd.getString("BOSS_PHONE"));
			map1.put("业务联系人", pd.getString("LINKMAN"));
			map1.put("业务联系人电话", pd.getString("BUSINESS_PEOPLE"));
			map1.put("付款约定", pd.getString("ACCESSORY"));
			map1.put("备注", pd.getString("BZ"));
			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("oa_lixiangliucheng",map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_project");
			projectService.edit(pd);
			supplierService.editTableName(pd);


			map.put("ASSIGNEE_",Jurisdiction.getUsername());
			map.put("msg","success");
		} catch (Exception e) {
			map.put("msg","请联系管理员部署相应业务流程!");
			map.put("errer","errer");
		}

		return map;
	}










	/**
	 * 获取所有项目
	 *
	 * @return
	 */
	@RequestMapping(value = "/getAllProject")
	@ResponseBody
	public Map<String, Object> getMarketAll(Page page) {
		List<PageData> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			page.setShowCount(9999999);
			pd.put("STATUS",1);
			page.setPd(pd);
			list = projectService.list(page);
		} catch (Exception e) {
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo", errInfo);
		map.put("list", list);
		return map;
	}

	@RequestMapping(value="/findByProject")
	@ResponseBody
	public Map<String, Object> findByProject()throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<PageData> list = new ArrayList<>();
		PageData pd = new PageData();
		String errInfo = "success";

		pd = this.getPageData();
		pd = projectService.findByProject(pd);	//根据ID读取

		map.put("list", pd);
		return map;
	}





	/**获取委托公司数据
	 * @return
	 */
	@RequestMapping(value="/c_ProductById")
	@ResponseBody
	public Map<String,Object> c_ProductById(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = projectService.c_ProductById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}/**获取委托公司数据
	 * @return
	 */
	@RequestMapping(value="/g_SupplierById")
	@ResponseBody
	public Map<String,Object> g_SupplierById(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = projectService.g_SupplierById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}

	/**获取委托公司数据
	 * @return
	 */
	@RequestMapping(value="/k_ClienteleById")
	@ResponseBody
	public Map<String,Object> k_ClienteleById(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = projectService.k_ClienteleById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}






	/**获取产品数据
	 * @return
	 */
	@RequestMapping(value="/c_ProductAll")
	@ResponseBody
	public Map<String,Object> c_ProductAll(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			list = projectService.c_ProductAll(pd);
			map.put("list",list);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		return map;
	}
	/**获取供应商数据
	 * @return
	 */
	@RequestMapping(value="/g_SupplierAll")
	@ResponseBody
	public Map<String,Object> g_SupplierAll(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			list = projectService.g_SupplierAll(pd);
			map.put("list",list);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		return map;
	}
	/**获取客户数据
	 * @return
	 */
	@RequestMapping(value="/k_ClienteleAll")
	@ResponseBody
	public Map<String,Object> k_ClienteleAll(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			list = projectService.k_ClienteleAll(pd);
			map.put("list",list);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		return map;
	}







	/**获取委托公司数据
	 * @return
	 */
	@RequestMapping(value="/getCompanyById")
	@ResponseBody
	public Map<String,Object> getCompanyById(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = projectService.CompanyById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}




	/**获取委托公司数据
	 * @return
	 */
	@RequestMapping(value="/getCompany")
	@ResponseBody
	public Map<String,Object> getCompany(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			list = projectService.CompanyAll(pd);
			map.put("list",list);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		return map;
	}



	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String projectid = this.get32UUID();
		pd.put("PROJECT_ID", projectid);	//主键
		pd.put("FUZEREN", Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd.format(new Date()));
		pd.put("STATUS", 2);

		projectService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		projectService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FUZEREN", Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd.format(new Date()));

		projectService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Project");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = projectService.list(page);	//列出Project列表
		mv.setViewName("fhoa/project/project_list");
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
		mv.setViewName("fhoa/project/project_edit");
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
		pd = projectService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/project/project_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			projectService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Project到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("选择公司");	//1
		titles.add("项目编号");	//1
		titles.add("项目名称");	//2
		titles.add("医院");	//3
		titles.add("投标限价(元)");	//4
		titles.add("委托公司");	//5
		titles.add("委托公司老板");	//6
		titles.add("委托公司老板电话");	//6
		titles.add("联系人");	//7
		titles.add("联系人电话");	//7
		titles.add("预计开标时间");	//9

		titles.add("付款约定");	//12
		titles.add("负责人");	//12
		titles.add("备注");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = projectService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SELECTCOMPANY"));	    //1
			vpd.put("var2", varOList.get(i).getString("SYS_ID"));	    //1
			vpd.put("var3", varOList.get(i).getString("PROJECT_NAME"));	    //2
			vpd.put("var4", varOList.get(i).getString("HOSPITAL"));	    //3
			vpd.put("var5", varOList.get(i).get("LIMITED_PRICE").toString());	    //4
			vpd.put("var6", varOList.get(i).getString("CORPORATE_COMPANY"));	    //5
			vpd.put("var7", varOList.get(i).getString("CORPORATE_BOSS"));	    //6
			vpd.put("var8", varOList.get(i).getString("BOSS_PHONE"));	    //6
			vpd.put("var9", varOList.get(i).getString("LINKMAN"));	    //7
			vpd.put("var10", varOList.get(i).getString("BUSINESS_PEOPLE"));	    //7
			vpd.put("var11", varOList.get(i).getString("ZHAOBIAOYUJI"));	    //9

			vpd.put("var12", varOList.get(i).getString("ACCESSORY"));	    //12
			vpd.put("var13", varOList.get(i).getString("FUZEREN"));	    //12
			vpd.put("var14", varOList.get(i).getString("BZ"));	    //12
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
