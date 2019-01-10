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
 * 创建人：FH Q313596790
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
			map1.put("项目编号", pd.getString("SYS_ID"));
			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("销售合同", pd.getString("SALES_CONTRACT_ID"));
			map1.put("客户名称", pd.getString("CLIENT_NAME"));
			if (pd.get("SHENGCHANXUKEZHENG")!=null&&!pd.get("SHENGCHANXUKEZHENG").toString().equals("")){
				map1.put("生产许可证", pd.get("SHENGCHANXUKEZHENG").toString());
			}
			if (pd.get("JINGYINGXUKEZHENG")!=null&&!pd.get("JINGYINGXUKEZHENG").toString().equals("")){
				map1.put("经营许可证", pd.get("JINGYINGXUKEZHENG").toString());
			}
			if (pd.get("FARENSHOUQUAN")!=null&&!pd.get("FARENSHOUQUAN").toString().equals("")){
				map1.put("法人授权书", pd.get("FARENSHOUQUAN").toString());
			}
			if (pd.get("SHOUQUANWEITUO")!=null&&!pd.get("SHOUQUANWEITUO").toString().equals("")){
				map1.put("授权委托书", pd.get("SHOUQUANWEITUO").toString());
			}
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("PROJECT_MARKET_ID")+"','14b2e7231a604b9f9edfc230fea227d8')\" style=' cursor:pointer;'>查看附件</a>");
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
			page.setPd(pd);
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
		if(pd.getString("SHENGCHANXUKEZHENG").equals("")){
			pd.remove("SHENGCHANXUKEZHENG");
		}
		if(pd.getString("JINGYINGXUKEZHENG").equals("")){
			pd.remove("JINGYINGXUKEZHENG");
		}
		if(pd.getString("FARENSHOUQUAN").equals("")){
			pd.remove("FARENSHOUQUAN");
		}
		if(pd.getString("SHOUQUANWEITUO").equals("")){
			pd.remove("SHOUQUANWEITUO");
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
		if(pd.getString("SHENGCHANXUKEZHENG").equals("")){
			pd.remove("SHENGCHANXUKEZHENG");
		}
		if(pd.getString("JINGYINGXUKEZHENG").equals("")){
			pd.remove("JINGYINGXUKEZHENG");
		}
		if(pd.getString("FARENSHOUQUAN").equals("")){
			pd.remove("FARENSHOUQUAN");
		}
		if(pd.getString("SHOUQUANWEITUO").equals("")){
			pd.remove("SHOUQUANWEITUO");
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
		titles.add("系统编序号");	//1
		titles.add("销售合同编号");	//2
		titles.add("下游");	//3
		titles.add("生产许可证到期日");	//3
		titles.add("经营许可证到期日");	//3
		titles.add("法人授权书到期日");	//3
		titles.add("授权委托书到期日");	//3
		titles.add("产品信息");	//4
		titles.add("合同总价");	//5
		titles.add("回款条款");	//6
		titles.add("大设备预支款金额");	//7
		titles.add("预计到账时间");	//8
		titles.add("实际到账时间");	//9
		titles.add("累计开票总额");	//10
		titles.add("到货时间");	//11
		titles.add("验收时间");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = projectmarketService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SYS_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("SALES_CONTRACT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("CLIENT_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("SHENGCHANXUKEZHENG"));
			vpd.put("var5", varOList.get(i).getString("JINGYINGXUKEZHENG"));
			vpd.put("var6", varOList.get(i).getString("FARENSHOUQUAN"));
			vpd.put("var7", varOList.get(i).getString("SHOUQUANWEITUO"));

			vpd.put("var8", varOList.get(i).getString("PRODUCT_INFO"));	    //4
			vpd.put("var9", varOList.get(i).get("CONTRACT_PRICE").toString());	    //5
			vpd.put("var10", varOList.get(i).getString("CLAUSE"));	    //6
			vpd.put("var11", varOList.get(i).get("EQUIPMENT_ADVANCE").toString());	    //7
			vpd.put("var12", sd.format(varOList.get(i).get("PREDICT_ACCOUNT_TIME")));	    //8
			vpd.put("var13", sd.format(varOList.get(i).get("PRACTICAL_ACCOUT_TIME")));	    //9
			vpd.put("var14", varOList.get(i).getString("CUMULATIVE_BILLING"));	//10
			vpd.put("var15", sd.format(varOList.get(i).get("ARRIVAL_TIME")));	    //11
			vpd.put("var116", sd.format(varOList.get(i).get("RECEPTION_TIME")));	    //12
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
