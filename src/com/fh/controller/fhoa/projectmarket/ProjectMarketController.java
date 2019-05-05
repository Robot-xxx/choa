package com.fh.controller.fhoa.projectmarket;

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
import com.fh.service.fhoa.projectmarket.ProjectMarketManager;

/** 
 * 说明：项目销售情况
 *
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value="/projectmarket")
public class ProjectMarketController extends AcStartController {
	
	String menuUrl = "projectmarket/list.do"; //菜单地址(权限用)
	@Resource(name="projectmarketService")
	private ProjectMarketManager projectmarketService;
	@Resource
	private AccessoryFileManager accessoryFileManager;
	SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");

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
		pd = projectmarketService.findById(pd);	//根据ID读取
		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();

			map1.put("公司",pd.getString("SELECTCOMPANY") );			//选择公司

			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("选择公司", pd.getString("SELECTCOMPANY"));
			map1.put("项目编号", pd.getString("SYS_ID"));
			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("销售合同", pd.getString("SALES_CONTRACT_ID"));
			map1.put("下游名称", pd.getString("CLIENT_NAME"));

			if (pd.get("PREDICT_ACCOUNT_TIME")!=null&&!pd.get("PREDICT_ACCOUNT_TIME").toString().equals("")){
				map1.put("预计发货时间", pd.get("PREDICT_ACCOUNT_TIME").toString());
			}
			if (pd.get("PRACTICAL_ACCOUT_TIME")!=null&&!pd.get("PRACTICAL_ACCOUT_TIME").toString().equals("")){
				map1.put("实际双签合同签订时间", pd.get("PRACTICAL_ACCOUT_TIME").toString());
			}
			if (pd.get("ARRIVAL_TIME")!=null&&!pd.get("ARRIVAL_TIME").toString().equals("")){
				map1.put("实际到货时间", pd.get("ARRIVAL_TIME").toString());
			}
			if (pd.get("RECEPTION_TIME")!=null&&!pd.get("RECEPTION_TIME").toString().equals("")){
				map1.put("实际验收时间", pd.get("RECEPTION_TIME").toString());
			}
			if (pd.get("BAOZHENGJINTUIHUISHIJIAN")!=null&&!pd.get("BAOZHENGJINTUIHUISHIJIAN").toString().equals("")){
				map1.put("保证金退回时间", pd.get("BAOZHENGJINTUIHUISHIJIAN").toString());
			}
			map1.put("合同总价(元)", pd.get("CONTRACT_PRICE").toString());

			map1.put("是否资料齐全", pd.getString("ISZILIAOQQ"));

			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("PROJECT_MARKET_ID")+"','14b2e7231a604b9f9edfc230fea227d8')\" style=' cursor:pointer;'>查看附件</a>");
			map1.put("查看产品", "<a onclick=\"selectProject('"+pd.getString("PROJECT_MARKET_ID")+"')\" style=' cursor:pointer;'>查看产品</a>");
			map1.put("负责人", pd.getString("FUZEREN"));
			map1.put("风险条款", pd.getString("FENGXIANTIAOKUAN"));
			map1.put("备注", pd.getString("BZ"));
			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("oa_xiaoshouhetong",map1);	//启动流程实例(请假单流程)通过KEY

			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_project_market");
			projectmarketService.edit(pd);
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
	 * 获取销售
	 *
	 * @return
	 */
	@RequestMapping(value = "/getMarketAll")
	@ResponseBody
	public Map<String, Object> getMarketAll(Page page) {
		List<PageData> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("STATUS",1);
			if(pd.getString("tag").equals("ticket")){
				pd.remove("STATUS");
			}

			page.setPd(pd);
			page.setShowCount(999999);
			list = projectmarketService.list(page);
		} catch (Exception e) {
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo", errInfo);
		map.put("list", list);
		return map;
	}


	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ProjectMarket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String projectmarketid = this.get32UUID();


		if(pd.getString("PRACTICAL_ACCOUT_TIME").equals("")){
			pd.remove("PRACTICAL_ACCOUT_TIME");
		}
		if(pd.getString("ARRIVAL_TIME").equals("")){
			pd.remove("ARRIVAL_TIME");
		}
		if(pd.getString("RECEPTION_TIME").equals("")){
			pd.remove("RECEPTION_TIME");
		}

		pd.put("UPDATETIME", sd1.format(new Date()));

		pd.put("PROJECT_MARKET_ID",projectmarketid);	//主键
		//pd.put("FUZEREN",Jurisdiction.getUsername());	//主键
		pd.put("STATUS", 2);

		projectmarketService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ProjectMarket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		projectmarketService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ProjectMarket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		if(pd.getString("PRACTICAL_ACCOUT_TIME").equals("")){
			pd.remove("PRACTICAL_ACCOUT_TIME");
		}


		if(pd.getString("ARRIVAL_TIME").equals("")){
			pd.remove("ARRIVAL_TIME");
		}
		if(pd.getString("RECEPTION_TIME").equals("")){
			pd.remove("RECEPTION_TIME");
		}
		pd.put("UPDATETIME", sd1.format(new Date()));

		projectmarketService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表ProjectMarket");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = projectmarketService.list(page);	//列出ProjectMarket列表



		mv.setViewName("fhoa/projectmarket/projectmarket_list");
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
		mv.setViewName("fhoa/projectmarket/projectmarket_edit");
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
		pd = projectmarketService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/projectmarket/projectmarket_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProjectMarket");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			projectmarketService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ProjectMarket到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("项目编号");	//1
		titles.add("项目名称");	//1
		titles.add("选择公司");	//1

		titles.add("销售合同编号");	//2
		titles.add("下游");	//3
		titles.add("合同总价(元)");	//4
		titles.add("医院预付款(元)");	//5
		titles.add("预计发货时间");	//6

		titles.add("实际双签合同签订时间");	//9
		titles.add("实际到货时间");	//11
		titles.add("实际验收时间");	//12
		titles.add("负责人");	//12
		titles.add("风险条款");	//12
		titles.add("更新时间");	//12
		titles.add("状态");	//12
		titles.add("备注");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = projectmarketService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SYS_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROJECT_NAME"));	    //1
			vpd.put("var3", varOList.get(i).getString("SELECTCOMPANY"));	    //1

			vpd.put("var4", varOList.get(i).getString("SALES_CONTRACT_ID"));	    //2
			vpd.put("var5", varOList.get(i).getString("CLIENT_NAME"));	    //3


			if (varOList.get(i).get("CONTRACT_PRICE")!=null&&!varOList.get(i).get("CONTRACT_PRICE").toString().equals("")) {
				vpd.put("var6", varOList.get(i).get("CONTRACT_PRICE").toString());	    //8
			}else {
				vpd.put("var6","");	    //8

			}

			if (varOList.get(i).get("EQUIPMENT_ADVANCE")!=null&&!varOList.get(i).get("EQUIPMENT_ADVANCE").toString().equals("")) {
				vpd.put("var7", varOList.get(i).get("EQUIPMENT_ADVANCE").toString());	    //8
			}else {
				vpd.put("var7","");	    //8

			}



			if (varOList.get(i).get("PREDICT_ACCOUNT_TIME")!=null&&!varOList.get(i).get("PREDICT_ACCOUNT_TIME").toString().equals("")) {
				vpd.put("var8", varOList.get(i).get("PREDICT_ACCOUNT_TIME").toString());	    //8
			}else {
				vpd.put("var8","");	    //8

			}

			if (varOList.get(i).get("PRACTICAL_ACCOUT_TIME")!=null&&!varOList.get(i).get("PRACTICAL_ACCOUT_TIME").toString().equals("")) {
				vpd.put("var9", varOList.get(i).get("PRACTICAL_ACCOUT_TIME").toString());	    //8
			}else {
				vpd.put("var9","");	    //8

			}


			if (varOList.get(i).get("ARRIVAL_TIME")!=null&&!varOList.get(i).get("ARRIVAL_TIME").toString().equals("")) {
				vpd.put("var10", varOList.get(i).get("ARRIVAL_TIME").toString());	    //8
			}else {
				vpd.put("var10","");	    //8

			}
			if (varOList.get(i).get("RECEPTION_TIME")!=null&&!varOList.get(i).get("RECEPTION_TIME").toString().equals("")) {
				vpd.put("var11", varOList.get(i).get("RECEPTION_TIME").toString());	    //8
			}else {
				vpd.put("var11","");	    //8

			}

			vpd.put("var12",varOList.get(i).getString("FUZEREN"));
			vpd.put("var13",varOList.get(i).getString("FENGXIANTIAOKUAN"));
			vpd.put("var14", sd1.format(varOList.get(i).get("UPDATETIME")));	    //12
			if(varOList.get(i).getString("STATUS").equals("1")){
				vpd.put("var15", "已审批");	    //6
			}else if(varOList.get(i).getString("STATUS").equals("2")){
				vpd.put("var15", "未审批");	    //6
			}else{
				vpd.put("var15", "审批中");	    //6
			}
			vpd.put("var16",varOList.get(i).getString("BZ"));
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


	/**
	 * 获取项目数据
	 * @return
	 */
	@RequestMapping(value="/projectMarketAll")
	@ResponseBody
	public Map<String,Object> projectMarketAll(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			list = projectmarketService.projectMarketAll(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("list",list);
		return map;
	}

	/**
	 * 根据项目获取id
	 * @return
	 */
	@RequestMapping(value="/projectMarketById")
	@ResponseBody
	public Map<String,Object> projectMarketById(){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd = projectmarketService.projectMarketById(pd);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}

}
