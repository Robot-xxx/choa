package com.fh.controller.fhoa.settlement;

import java.io.PrintWriter;
import java.sql.Array;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.fhoa.cost.CostManager;
import com.fh.service.fhoa.projectbid.ProjectBidManager;
import com.fh.service.fhoa.projectpurchase.ProjectPurchaseManager;
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
import com.fh.service.fhoa.settlement.SettlementManager;

/** 
 * 说明：项目结算
 * 创建时间：2018-10-25
 */
@Controller
@RequestMapping(value="/settlement")
public class SettlementController extends BaseController {
	
	String menuUrl = "settlement/list.do"; //菜单地址(权限用)
	@Resource(name="settlementService")
	private SettlementManager settlementService;
	@Resource(name = "projectbidService")
	private ProjectBidManager projectbidService;
	@Resource(name = "projectpurchaseService")
	private ProjectPurchaseManager projectpurchaseService;
	@Resource(name="costService")
	private CostManager costService;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");

	/**去打印页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goPrint")
	public ModelAndView goPrint(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();


		pd = settlementService.findById(pd);	//根据ID读取
		page.setPd(pd);
		mv.addObject("pd", pd);
		pd.put("DATE",sd.format( pd.get("DATE")));


		Map<String,Object> map= new HashMap<>();

		pd.put("STATUS",1);
		//投标情况信息
		List<PageData> list1 = projectbidService.list(page);
		List<PageData> l=new ArrayList<>();
		List<PageData> l1=new ArrayList<>();
		List<PageData> l2=new ArrayList<>();
		List<PageData> l3=new ArrayList<>();
		Double count = 0.0;

		for (int i = 0; i <list1.size() ; i++) {
			pd.put("ACT_ID",list1.get(i).getString("ACT_ID"));
			pd=settlementService.endById(pd);
			PageData pd1 = new PageData();
			pd1.put("GUARANTEE_MONEY",list1.get(i).get("GUARANTEE_MONEY").toString());
			pd1.put("END_TIME_",sd.format(pd.get("END_TIME_")));
			PageData pd2 = new PageData();
			pd2.put("SERVICE_PRICE",list1.get(i).get("SERVICE_PRICE").toString());
			pd2.put("END_TIME_",sd.format(pd.get("END_TIME_")));


			count+=Double.valueOf( list1.get(i).get("GUARANTEE_MONEY").toString());
			count+=Double.valueOf( list1.get(i).get("SERVICE_PRICE").toString());

			l.add(pd1);
			l1.add(pd2);
		}

		map.put("l",l);
		map.put("l1",l1);

		//采购合同
		List<PageData> list2 = projectpurchaseService.list(page);
		for (int i = 0; i <list2.size() ; i++) {
			pd.put("ACT_ID",list2.get(i).getString("ACT_ID"));
			pd=settlementService.endById(pd);
			PageData pd1 = new PageData();
			pd1.put("CONTRACT_PRICE",list2.get(i).get("CONTRACT_PRICE").toString());
			count+=Double.valueOf( list2.get(i).get("CONTRACT_PRICE").toString());

			pd1.put("END_TIME_",sd.format(pd.get("END_TIME_")));
			l2.add(pd1);
		}
		map.put("l2",l2);
		//报销成本
		List<PageData> list3 = costService.list(page);
		for (int i = 0; i <list3.size() ; i++) {
			pd.put("ACT_ID",list3.get(i).getString("ACT_ID"));
			pd=settlementService.endById(pd);
			PageData pd1 = new PageData();
			pd1.put("MONEY",list3.get(i).get("MONEY").toString());
			pd1.put("END_TIME_",sd.format(pd.get("END_TIME_")));
			count+=Double.valueOf( list3.get(i).get("MONEY").toString());
			l3.add(pd1);
		}
		map.put("l3",l3);
		map.put("count", count);
		mv.setViewName("fhoa/settlement/JieSuan");

		mv.addObject("map", map);
		return mv;
	}

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Settlement");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SETTLEMENT_ID", this.get32UUID());	//主键
		settlementService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Settlement");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		settlementService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Settlement");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		settlementService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Settlement");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = settlementService.list(page);	//列出Settlement列表
		mv.setViewName("fhoa/settlement/settlement_list");
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
		mv.setViewName("fhoa/settlement/settlement_edit");
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
		pd = settlementService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/settlement/settlement_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Settlement");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			settlementService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Settlement到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("项目编号");	//1
		titles.add("项目名称");	//2
		titles.add("项目负责人");	//3
		titles.add("中标金额");	//4
		titles.add("项目回款金额");	//5
		titles.add("尾款时间");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = settlementService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PROJECT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROJECT_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("PROJECT_MAN"));	    //3
			vpd.put("var4", varOList.get(i).getString("BID_PRICE"));	    //4
			vpd.put("var5", varOList.get(i).getString("PROJECT_MONEY"));	    //5
			vpd.put("var6", varOList.get(i).getString("DATE"));	    //6
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
