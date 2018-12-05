package com.fh.controller.fhoa.claimexpense;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
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
import com.fh.service.fhoa.claimexpense.ClaimexpenseManager;

/** 
 * 说明：费用明细模块
 * 创建人：FH Q313596790
 * 创建时间：2018-10-14
 */
@Controller
@RequestMapping(value="/claimexpense")
public class ClaimexpenseController extends BaseController {
	
	String menuUrl = "claimexpense/list.do"; //菜单地址(权限用)
	@Resource(name="claimexpenseService")
	private ClaimexpenseManager claimexpenseService;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");



	/**获取明细列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/getList")
	@ResponseBody
	public Map<String,Object> getList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Claimexpense");
		Map<String,Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("COST_ID");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("COST_ID", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = claimexpenseService.list(page);	//列出Claimexpense列表
		Double count=0.0;
		if(varList!=null) {
			for (int i = 0; i < varList.size(); i++) {
				count += Double.valueOf(varList.get(i).get("MONEY").toString());
			}
		}
		pd.put("MONEY",count);
		claimexpenseService.editCost(pd);

		return map;
	}




	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Claimexpense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CLAIMEXPENSE_ID", this.get32UUID());	//主键
		claimexpenseService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Claimexpense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		claimexpenseService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Claimexpense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		claimexpenseService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Claimexpense");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("COST_ID");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("COST_ID", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = claimexpenseService.list(page);	//列出Claimexpense列表


		for (int i = 0; i <varList.size() ; i++) {
			varList.get(i).put("DATE",sd.format(varList.get(i).get("DATE")));
		}

		mv.setViewName("fhoa/claimexpense/claimexpense_list");
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
		mv.setViewName("fhoa/claimexpense/claimexpense_edit");
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
		pd = claimexpenseService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/claimexpense/claimexpense_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Claimexpense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			claimexpenseService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Claimexpense到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("日期");	//1
		titles.add("内容");	//2
		titles.add("交通费");	//3
		titles.add("高铁费");	//4
		titles.add("飞机费");	//5
		titles.add("路桥费");	//6
		titles.add("加油费");	//7
		titles.add("餐饮费");	//8
		titles.add("酒水费");	//9
		titles.add("住宿费");	//10
		titles.add("公关费");	//11
		titles.add("标书费");	//12
		titles.add("其他费");	//13
		titles.add("小计");	//14
		titles.add("备注");	//15
		dataMap.put("titles", titles);
		List<PageData> varOList = claimexpenseService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("DATE"));	    //1
			vpd.put("var2", varOList.get(i).getString("CONTEXT"));	    //2
			vpd.put("var3", varOList.get(i).getString("JIAOTONGFEI"));	    //3
			vpd.put("var4", varOList.get(i).getString("GAOTIEFEI"));	    //4
			vpd.put("var5", varOList.get(i).getString("FEIJIFEI"));	    //5
			vpd.put("var6", varOList.get(i).getString("LUQIAOFEI"));	    //6
			vpd.put("var7", varOList.get(i).getString("JIAYOUFEI"));	    //7
			vpd.put("var8", varOList.get(i).getString("CANYINFEI"));	    //8
			vpd.put("var9", varOList.get(i).getString("JIUSHUIFEI"));	    //9
			vpd.put("var10", varOList.get(i).getString("ZHUSUFEI"));	    //10
			vpd.put("var11", varOList.get(i).getString("GONGGUANFEI"));	    //11
			vpd.put("var12", varOList.get(i).getString("BIAOSHUFEI"));	    //12
			vpd.put("var13", varOList.get(i).getString("QITAFEI"));	    //13
			vpd.put("var14", varOList.get(i).getString("COUNT"));	    //14
			vpd.put("var15", varOList.get(i).getString("BZ"));	    //15
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
