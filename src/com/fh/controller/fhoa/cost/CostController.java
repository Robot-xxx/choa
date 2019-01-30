package com.fh.controller.fhoa.cost;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.controller.activiti.AcStartController;
import com.fh.entity.system.Dictionaries;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
import com.fh.service.fhoa.claimexpense.impl.ClaimexpenseService;
import com.fh.service.fhoa.supplier.SupplierManager;
import com.fh.service.system.dictionaries.DictionariesManager;
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
import com.fh.service.fhoa.cost.CostManager;

/** 
 * 说明：报销成本管理
 * 创建人：FH Q313596790
 * 创建时间：2018-09-14
 */
@Controller
@RequestMapping(value="/cost")
public class CostController extends AcStartController {
	
	String menuUrl = "cost/list.do"; //菜单地址(权限用)
	@Resource(name="costService")
	private CostManager costService;
	@Resource
	private AccessoryFileManager accessoryFileManager;
	@Resource
	private ClaimexpenseService claimexpenseService;

	SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    @Resource(name="supplierService")
    private SupplierManager supplierService;
    @Resource(name="dictionariesService")
    private DictionariesManager dictionariesService;






	/**去打印页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goPrint")
	public ModelAndView goPrint(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();


		pd = costService.findById(pd);	//根据ID读取
        page.setPd(pd);

		pd.put("CREATE_DATE",sd.format( pd.get("CREATE_DATE")));
        List<PageData> list = claimexpenseService.list(page);


        List<Dictionaries> listDictionaries = dictionariesService.listSubDictByParentId("a68970fe3eea413fba61ce7064aa5a70");

        Map<String,Double> map =new HashMap<>();
        Double zong =0.0;
        for (int i = 0; i <listDictionaries.size() ; i++) {
            Double count = 0.0;
            for (int j = 0; j <list.size() ; j++) {
                if(listDictionaries.get(i).getNAME().equals(list.get(j).getString("TYPE"))){
                    count+=Double.valueOf(list.get(j).get("MONEY").toString());
                    map.put(listDictionaries.get(i).getNAME(),count);
                }
             }
             zong+=count;
        }

        mv.setViewName("fhoa/cost/baoxiao");
		mv.addObject("pd", pd);
		mv.addObject("list", list);
		mv.addObject("map", map);
		mv.addObject("zong", zong);
		return mv;
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
		pd = costService.findById(pd);	//根据ID读取

		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("是否代理商付款", pd.getString("IS_THEAGENT"));
			map1.put("项目编号", pd.getString("PROJECT_ID"));
			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("日期", sd.format(pd.get("CREATE_DATE")));
			map1.put("报销人", pd.getString("BXR"));
			map1.put("金额", pd.get("MONEY").toString());
			map1.put("备注", pd.getString("BZ"));
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("COST_ID")+"','e710e36af2124f4b8e61765297d4ae66')\" style=' cursor:pointer;'>查看附件</a>");

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
            String act_id=startProcessInstanceByKeyHasVariables("OA_baoxiaoliucheng",map1);	//启动流程实例(请假单流程)通过KEY


            pd.put("STATUS",3);
            pd.put("ACT_ID",act_id);
            pd.put("TABLENAME","oa_cost");
            costService.edit(pd);
            supplierService.editTableName(pd);


			map.put("ASSIGNEE_",Jurisdiction.getUsername());
			map.put("msg","success");
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
		logBefore(logger, Jurisdiction.getUsername()+"新增Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("USERID", Jurisdiction.getUSERID());

		String costId = this.get32UUID();
		Map<String, Object> map = new HashMap<>();
		String[] oafileList = pd.getString("oafileList").toString().split(",");
		map.put("oafileid", costId);
		map.put("ids", oafileList);
		accessoryFileManager.oaFileEdit(map);
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("KAISHIRIQI", sd.format(new Date()));
		pd.put("STATUS",2);
		pd.put("COST_ID", costId);	//主键
		costService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		costService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("KAISHIRIQI", sd.format(new Date()));

		costService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Cost");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		System.out.println(Jurisdiction.getRnumbers());
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
		List<PageData>	varList = costService.list(page);	//列出Cost列表
		for (int i = 0; i <varList.size() ; i++) {
			varList.get(i).put("CREATE_DATE",sd.format(varList.get(i).get("CREATE_DATE")));
		}
		mv.setViewName("fhoa/cost/cost_list");
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
		mv.setViewName("fhoa/cost/cost_edit");
		mv.addObject("msg", "save");



		pd.put("BXR",	Jurisdiction.getUsername());
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
		pd = costService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/cost/cost_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			costService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Cost到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("是否代理商付款");	//1
		titles.add("项目编号");	//2
		titles.add("日期");	//3
		titles.add("报销人");	//4
		titles.add("费用明细");	//5
		titles.add("金额");	//6
		titles.add("备注");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = costService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("IS_THEAGENT"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROJECT_ID"));	    //2
			vpd.put("var3", sd.format(varOList.get(i).get("CREATE_DATE")));	    //3
			vpd.put("var4", varOList.get(i).getString("BXR"));	    //4
			vpd.put("var5", varOList.get(i).getString("COST_DETAIL"));	    //5
			vpd.put("var6", varOList.get(i).get("MONEY").toString());	//6
			vpd.put("var7", varOList.get(i).getString("BZ"));	    //7
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
