package com.fh.controller.fhoa.payrequest;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.controller.activiti.AcStartController;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
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
import com.fh.service.fhoa.payrequest.PayRequestManager;

/** 
 * 说明：付款申请
 * 创建时间：2018-10-12
 */
@Controller
@RequestMapping(value="/payrequest")
public class PayRequestController extends AcStartController {
	
	String menuUrl = "payrequest/list.do"; //菜单地址(权限用)
	@Resource(name="payrequestService")
	private PayRequestManager payrequestService;
	@Resource
	private AccessoryFileManager accessoryFileManager;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sd1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Resource(name="supplierService")
	private SupplierManager supplierService;



	@RequestMapping(value="/findByProject")
	@ResponseBody
	public Map<String, Object> findByProject()throws Exception{
 		Map<String, Object> map = new HashMap<>();
		List<PageData> list = new ArrayList<>();
		PageData pd = new PageData();
		String errInfo = "success";

		pd = this.getPageData();
		pd.put("PROJECT_ID",pd.getString("PROJECT_ID").trim());
		pd.put("REQUEST_TYPE",pd.getString("REQUEST_TYPE").trim());
		pd = payrequestService.findByProject(pd);	//根据ID读取
		if(Integer.valueOf(pd.get("num").toString())>0){
			map.put("isUniqueness", "no");
		}else{
			map.put("isUniqueness", "ok");
		}

		map.put("list", pd);
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

		pd = payrequestService.findById(pd);	//根据ID读取
		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("选择公司",  pd.getString("SELECTCOMPANY"));			//当前用户的姓名
			map1.put("付款申请编号", pd.getString("REQUEST_NO"));
			map1.put("申请日期",sd.format( pd.get("REQUEST_DATE")));
			map1.put("经办人", pd.getString("RESPONSIBLEPERSON"));
			map1.put("申请类型", pd.getString("REQUEST_TYPE"));
			map1.put("支付方式", pd.getString("PAY_METHOD"));
			if ( pd.getString("ISHEZUO").equals("否")) {
				map1.put("收款单位", pd.getString("COMPANY_NAME"));
			}else if(pd.getString("ISHEZUO").equals("是")) {
				map1.put("收款单位", pd.getString("PAYEE"));
			}

			map1.put("是否合作方", pd.getString("ISHEZUO"));
			map1.put("收款单位银行", pd.getString("PAYEEBANK"));
			map1.put("银行账号", pd.getString("BANKACCOUNT"));
			map1.put("附言", pd.getString("POSTSCRIPT"));
			map1.put("合同编号", pd.getString("CONTRACT_NO"));

			map1.put("项目编号", pd.getString("PROJECT_ID"));

			map1.put("项目名称", pd.getString("PROJECT_NAME"));
			map1.put("供应商名称", pd.getString("GONGYINGSHANG"));
			map1.put("合同总额", pd.getString("HETONGZONGE"));

			map1.put("实付金额(元)", pd.getString("MONEY"));
			map1.put("垫付金额(元)", pd.getString("PAY_ACCOUNT"));
			map1.put("来款单位", pd.getString("PAY_UNIT"));
			map1.put("付款约定", pd.getString("FUKUANYUEDING"));
			map1.put("备注", pd.getString("BZ"));
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("REQUEST_ID")+"','2edba70525574ebfacda36e4e7607034')\" style=' cursor:pointer;'>查看附件</a>");

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户



			String REQUEST_TYPE= pd.getString("REQUEST_TYPE");
			String type="oa_fukuanliucheng";
			if(REQUEST_TYPE.equals("投标保证金")){
				type="oa_baozhengjinfukuanliucheng";
			}

			String act_id=startProcessInstanceByKeyHasVariables(type,map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_payrequest");
			payrequestService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"新增PayRequest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERID",Jurisdiction.getUSERID());
		pd.put("REQUEST_ID", this.get32UUID());	//主键
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("STATUS", 2);

		payrequestService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除PayRequest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		payrequestService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改PayRequest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERID",Jurisdiction.getUSERID());
		pd.put("UPDATETIME", sd1.format(new Date()));

		payrequestService.edit(pd);

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
		logBefore(logger, Jurisdiction.getUsername()+"列表PayRequest");
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

		if(Jurisdiction.getRnumbers().equals("('R20181028135540')")) {
			pd.put("USERID",Jurisdiction.getUSERID());
		}
			if(Jurisdiction.getRnumbers().equals("('R20190513135539')")) {
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
		}
		page.setPd(pd);
		List<PageData>	varList = payrequestService.list(page);	//列出PayRequest列表


		for (int i = 0; i <varList.size() ; i++) {
			varList.get(i).put("REQUEST_DATE",sd.format(varList.get(i).get("REQUEST_DATE")));
		}

		mv.setViewName("fhoa/payrequest/payrequest_list");
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

		pd.put("RESPONSIBLEPERSON",Jurisdiction.getUsername());
		mv.setViewName("fhoa/payrequest/payrequest_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}


	/**去打印页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goPrint")
	public ModelAndView goPrint()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = payrequestService.findById(pd);	//根据ID读取

		pd.put("REQUEST_DATE",sd.format( pd.get("REQUEST_DATE")));



		mv.setViewName("fhoa/payrequest/biao");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/YanZheng")
	@ResponseBody
	public Map<String, Object> YanZheng()throws Exception{
		Map<String,Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = payrequestService.findById(pd);	//根据ID读取
		pd.put("id",pd.getString("ACT_ID"));

		List<PageData> list= payrequestService.taskAll(pd);

		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).get("ASSIGNEE_")!=null&&!list.get(i).toString().equals("")){
				if(list.get(i).getString("ASSIGNEE_").toString().equals("R20181028660767")||list.get(i).getString("ASSIGNEE_").toString().equals("R20190325859065")){
					map.put("tag","1");
					return map;
				}
			}

		}
		map.put("tag","0");
		return map;
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
		pd = payrequestService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/payrequest/payrequest_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除PayRequest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			payrequestService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出PayRequest到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String userId= Jurisdiction.getUSERID();
		pd = this.getPageData();
		if(!userId.equals("1")||!userId.equals("R20181028683296")||!userId.equals("R20190123706606")){
			pd.put("USERID",userId);
		}
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("选择公司");	//1
		titles.add("付款申请编号");	//1
		titles.add("申请日期");	//2
		titles.add("经办人");	//3
		titles.add("申请类型");	//4
		titles.add("支付方式");	//5
		titles.add("收款单位");	//6
		titles.add("收款单位银行");	//8
		titles.add("银行账号");	//9
		titles.add("附言");	//10
		titles.add("项目编号");	//11
		titles.add("项目名称");	//12
		titles.add("供应商名称");	//12
		titles.add("合同总额");	//12
		titles.add("合同编号");	//13
		titles.add("实付金额");	//14
		titles.add("垫付金额");	//15
		titles.add("来款单位");	//16
		titles.add("来款情况");	//17
		titles.add("付款约定");	//18
		titles.add("付款时间");	//18
		titles.add("状态");	//18
		titles.add("备注");	//18
		dataMap.put("titles", titles);
		List<PageData> varOList = payrequestService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SELECTCOMPANY"));	    //1
			vpd.put("var2", varOList.get(i).getString("REQUEST_NO"));	    //1
			vpd.put("var3", sd.format(varOList.get(i).get("REQUEST_DATE")));	    //2
			vpd.put("var4", varOList.get(i).getString("RESPONSIBLEPERSON"));	    //3
			vpd.put("var5", varOList.get(i).getString("REQUEST_TYPE"));	    //4
			vpd.put("var6", varOList.get(i).getString("PAY_METHOD"));	    //5
			vpd.put("var7", varOList.get(i).getString("PAYEE"));	    //6
			vpd.put("var8", varOList.get(i).getString("PAYEEBANK"));	    //8
			vpd.put("var9", varOList.get(i).getString("BANKACCOUNT"));	    //9
			vpd.put("var10", varOList.get(i).getString("POSTSCRIPT"));	    //10
			vpd.put("var11", varOList.get(i).getString("PROJECT_ID"));	    //11
			vpd.put("var12", varOList.get(i).getString("PROJECT_NAME"));	    //12
			vpd.put("var13", varOList.get(i).getString("GONGYINGSHANG"));	    //12
			vpd.put("var14", varOList.get(i).getString("HETONGZONGE"));	    //12
			vpd.put("var15", varOList.get(i).getString("CONTRACT_NO"));	    //13
			vpd.put("var16", varOList.get(i).getString("MONEY"));	    //14
			vpd.put("var17", varOList.get(i).getString("PAY_ACCOUNT"));	    //15
			vpd.put("var18", varOList.get(i).getString("PAY_UNIT"));	    //16
			vpd.put("var19", varOList.get(i).getString("LAIKUAN"));	    //17
			vpd.put("var20", varOList.get(i).getString("FUKUANYUEDING"));	    //18
			vpd.put("var21", varOList.get(i).get("UPDATETIME").toString());	    //7
			if(varOList.get(i).getString("STATUS").equals("1")){
				vpd.put("var22", "已审批");	    //6
			}else if(varOList.get(i).getString("STATUS").equals("2")){
				vpd.put("var22", "未审批");	    //6
			}else{
				vpd.put("var22", "审批中");	    //6
			}
			vpd.put("var23", varOList.get(i).getString("BZ"));	    //18
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
