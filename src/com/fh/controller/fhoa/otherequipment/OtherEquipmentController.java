package com.fh.controller.fhoa.otherequipment;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.controller.activiti.AcStartController;
import com.fh.service.fhoa.supplier.SupplierManager;
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
import com.fh.service.fhoa.otherequipment.OtherEquipmentManager;

/** 
 * 说明：其他设备管理
 *
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value="/otherequipment")
public class OtherEquipmentController extends AcStartController {
	
	String menuUrl = "otherequipment/list.do"; //菜单地址(权限用)
	@Resource(name="otherequipmentService")
	private OtherEquipmentManager otherequipmentService;

	SimpleDateFormat sd =new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sd1 =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Resource(name="supplierService")
	private SupplierManager supplierService;

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
			page.setShowCount(99999);
			list = otherequipmentService.list(page);
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("errInfo",errInfo);
		map.put("list",list);
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
		pd = otherequipmentService.findById(pd);	//根据ID读取

		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
/*
			map1.put("其他器械编号", pd.getString("SYS_ID"));
*/
			map1.put("产品名称", pd.getString("PRODUCT_NAME"));
			map1.put("型号、规格", pd.getString("MODEL"));
			map1.put("生产厂家", pd.getString("MANUFACTURERS"));
			map1.put("注册证类型", pd.getString("BUSINESS"));
			map1.put("生产批次", pd.getString("BATCH"));

			if (pd.get("VALIDITY")!=null&&!pd.get("VALIDITY").toString().equals("")){
				map1.put("有效期", pd.get("VALIDITY").toString());
			}
			map1.put("备注", pd.getString("ACCESSORY"));
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("EQUIPMENT_ID")+"','d5dac6150a934e69a15e5231fe4af3a7')\" style=' cursor:pointer;'>查看附件</a>");

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("q_qitashebeiguanli",map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_other_equipment");
			otherequipmentService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"新增OtherEquipment");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("EQUIPMENT_ID", this.get32UUID());	//主键
		pd.put("FUZEREN",Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("STATUS", 2);

		otherequipmentService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除OtherEquipment");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		otherequipmentService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OtherEquipment");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FUZEREN",Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("STATUS",2);
		otherequipmentService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表OtherEquipment");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = otherequipmentService.list(page);	//列出OtherEquipment列表

	/*	for (int i = 0; i <varList.size() ; i++) {
			varList.get(i).put("VALIDITY",sd.format(varList.get(i).get("VALIDITY")));
		}*/
		mv.setViewName("fhoa/otherequipment/otherequipment_list");
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
		mv.setViewName("fhoa/otherequipment/otherequipment_edit");
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
		pd = otherequipmentService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/otherequipment/otherequipment_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除OtherEquipment");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			otherequipmentService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出OtherEquipment到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		/*titles.add("系统编序号");	//1*/
		titles.add("产品名称");	//2
		titles.add("型号丶规格");	//3
		titles.add("生产厂家");	//4
		titles.add("注册证类别");	//6
		titles.add("生产批次");	//7
		titles.add("纸质资料是否齐全");	//7
		titles.add("补交时间");	//7
		titles.add("上传者");	//7
		titles.add("状态");	//7
		titles.add("备注");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = otherequipmentService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			/*vpd.put("var1", varOList.get(i).getString("SYS_ID"));	    //1*/
			vpd.put("var1", varOList.get(i).getString("PRODUCT_NAME"));	    //2
			vpd.put("var2", varOList.get(i).getString("MODEL"));	    //3
			vpd.put("var3", varOList.get(i).getString("MANUFACTURERS"));	    //4
			vpd.put("var4", varOList.get(i).getString("BUSINESS"));	    //6
			vpd.put("var5", varOList.get(i).getString("BATCH"));	    //7
			vpd.put("var6", varOList.get(i).getString("FUZEREN"));	    //8
			if(varOList.get(i).getString("STATUS").equals("1")){
				vpd.put("var7", "已审批");	    //6
			}else if(varOList.get(i).getString("STATUS").equals("2")){
				vpd.put("var7","未审批");	    //6
			}else{
				vpd.put("var7", "审批中");	    //6
			}
			vpd.put("var8", varOList.get(i).getString("ACCESSORY"));	    //9
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
