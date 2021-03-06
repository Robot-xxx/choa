package com.fh.controller.fhoa.claimant;

import java.io.PrintWriter;
import java.net.SocketImpl;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.fhoa.identifymanagement.IdentifyManagementManager;
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
import com.fh.service.fhoa.claimant.ClaimantManager;

/** 
 * 说明：认款记录
 *
 * 创建时间：2018-09-16
 */
@Controller
@RequestMapping(value="/claimant")
public class ClaimantController extends BaseController {
	
	String menuUrl = "claimant/list.do"; //菜单地址(权限用)
	@Resource(name="claimantService")
	private ClaimantManager claimantService;
	@Resource(name="identifymanagementService")
	private IdentifyManagementManager identifymanagementService;
	SimpleDateFormat sd =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@RequestMapping(value="/getAllInstrument")
	@ResponseBody
	public Map<String,Object> getAllInstrument(Page page){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			page.setShowCount(999999);
			list = claimantService.list(page);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("list",list);
		return map;
	}

	/**获取客户信息
	 * @return
	 */
	@RequestMapping(value="/yanZhengIsRenKuan")
	@ResponseBody
	public Map<String,Object> getAllCustomer(Page page){
		List<PageData> list = new ArrayList<>();
		Map<String,Object> map  = new HashMap<>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			pd=claimantService.findProjectMarket(pd.getString("PROJECT_MARKET_ID"));
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("pd",pd);
		return map;
	}


	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		Page page = new Page();
		logBefore(logger, Jurisdiction.getUsername()+"新增Claimant");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData pd2 = new PageData();

		pd = this.getPageData();
		pd.put("SYS_ID", this.get32UUID());	//主键

		page.setPd(pd);
		pd.put("IDENTIFYMANAGEMENT_ID",pd.getString("moneyId"));
		//获取回款时间和回款金额
		pd2= identifymanagementService.findById(pd);
		//认款类型
		pd.put("RENKUAILEIXING",pd.getString("RENKUAILEIXING"));

		Double money1 = 0.0;

		money1 = Double.valueOf(pd.get("money").toString()) - Double.valueOf(pd.getString("CLAIMANT_MONEY"));

		pd.put("WEILINGJINE",money1);
		//是否认款
		if(money1<=0){
			pd.put("SHIFOURENKUAN","是");
		}else if(money1>0){
			pd.put("SHIFOURENKUAN","否");
		}
		identifymanagementService.editFoProjectId(pd);


		pd.put("UPDATETIME", sd.format(new Date()));
		pd.put("HUIKUANRIQI",pd2.getString("CREATE_DATE"));
		pd.put("JINKUANJINE",pd2.get("INCOME_MONEY").toString());
		pd.put("HUIKUANDANWEI",pd2.get("RETURN_MONEY").toString());
		claimantService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Claimant");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		claimantService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Claimant");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UPDATETIME", sd.format(new Date()));
		pd.put("STATUS",2);
		claimantService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Claimant");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = claimantService.list(page);	//列出Claimant列表

		mv.setViewName("fhoa/claimant/claimant_list");
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
		pd.put("CLAIMANT_NAME",Jurisdiction.getUsername());
		mv.setViewName("fhoa/claimant/claimant_edit");
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
		pd = claimantService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/claimant/claimant_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Claimant");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			claimantService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Claimant到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("认款类型");	//1
		titles.add("项目编号");	//1
		titles.add("项目名称");	//2
		titles.add("回款时间");	//3
		titles.add("回款单位");	//4
		titles.add("认领时间");	//5
		titles.add("认领人名称");	//5
		titles.add("认领金额(元)");	//5
		titles.add("进款金额(元)");	//5
		titles.add("备注");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = claimantService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("RENKUAILEIXING"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROJECT_ID"));	    //1
			vpd.put("var3", varOList.get(i).getString("PROJECT_NAME"));	    //2
			vpd.put("var4", varOList.get(i).getString("HUIKUANRIQI"));	    //2
			vpd.put("var5", varOList.get(i).getString("HUIKUANDANWEI"));	    //2
			vpd.put("var6", varOList.get(i).getString("CREATE_TIME"));	    //2
			vpd.put("var7", varOList.get(i).getString("CLAIMANT_NAME"));	    //2
			vpd.put("var8", varOList.get(i).get("CLAIMANT_MONEY").toString());	    //2
			vpd.put("var9", varOList.get(i).get("JINKUANJINE").toString());	    //2
			vpd.put("var10", varOList.get(i).getString("BZ"));	    //6
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
