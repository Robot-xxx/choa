package com.fh.controller.fhoa.informatization;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.controller.activiti.AcStartController;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
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
import com.fh.service.fhoa.informatization.InformatizationManager;

/** 
 * 说明：信息化资料管理
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value="/informatization")
public class InformatizationController extends AcStartController {
	
	String menuUrl = "informatization/list.do"; //菜单地址(权限用)
	@Resource(name="informatizationService")
	private InformatizationManager informatizationService;
	@Resource
	private AccessoryFileManager accessoryFileManager;
	@Resource(name="supplierService")
	private SupplierManager supplierService;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sd1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


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
			list = informatizationService.list(page);
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
		pd = informatizationService.findById(pd);	//根据ID读取

		try {

			/** 工作流的操作 **/
			Map<String,Object> map1 = new LinkedHashMap<String, Object>();
			map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
			map1.put("产品编号", pd.getString("SYS_ID"));
			map1.put("产品名称", pd.getString("PRODUCT_NAME"));
			map1.put("型号丶规格", pd.getString("MODEL"));
			map1.put("生产厂家", pd.getString("MANUFACTURERS"));
			map1.put("注册证号", pd.getString("REGISTRATION"));
			map1.put("纸质资料是否齐全", pd.getString("ISZILIAOQQ"));
			map1.put("上传者", pd.getString("FUZEREN"));
			if (pd.get("BUJIAOSHIJIAN")!=null&&!pd.get("BUJIAOSHIJIAN").toString().equals("")){
				map1.put("补交时间", pd.get("BUJIAOSHIJIAN").toString());
			}

			map1.put("备注", pd.getString("BUSINESS"));
			map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("INFORMATIZATION_ID")+"','55c792a602814c4ebecb1cc118cf6351')\" style=' cursor:pointer;'>查看附件</a>");

			map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
			String act_id=startProcessInstanceByKeyHasVariables("x_xinxihuaguanli",map1);	//启动流程实例(请假单流程)通过KEY


			pd.put("STATUS",3);
			pd.put("ACT_ID",act_id);
			pd.put("TABLENAME","oa_informatization");
			informatizationService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"新增Informatization");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String informatizationId = this.get32UUID();

		pd.put("INFORMATIZATION_ID", informatizationId);	//主键
		pd.put("FUZEREN",  Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("STATUS", 2);

		informatizationService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Informatization");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		informatizationService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Informatization");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FUZEREN",  Jurisdiction.getUsername());	//主键
		pd.put("UPDATETIME", sd1.format(new Date()));
		pd.put("STATUS",2);
		informatizationService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Informatization");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = informatizationService.list(page);

		//列出Informatization列表
		mv.setViewName("fhoa/informatization/informatization_list");
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
		mv.setViewName("fhoa/informatization/informatization_edit");
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
		pd = informatizationService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/informatization/informatization_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Informatization");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			informatizationService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Informatization到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("系统编序号");	//1
		titles.add("产品名称");	//2
		titles.add("型号丶规格");	//3
		titles.add("生产厂家");	//4
		titles.add("注册证号");	//5
		titles.add("纸质资料是否齐全");	//5
		titles.add("补交时间");	//5
		titles.add("上传者");	//5
		titles.add("备注");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = informatizationService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SYS_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("PRODUCT_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("MODEL"));	    //3
			vpd.put("var4", varOList.get(i).getString("MANUFACTURERS"));	    //4
			vpd.put("var5", varOList.get(i).getString("REGISTRATION"));	    //5
			vpd.put("var6", varOList.get(i).getString("ISZILIAOQQ"));	    //5
			if (varOList.get(i).get("BUJIAOSHIJIAN")!=null&&!varOList.get(i).get("BUJIAOSHIJIAN").toString().equals("")) {
				vpd.put("var7", sd.format(varOList.get(i).get("BUJIAOSHIJIAN")));	    //8
			}else {
				vpd.put("var7","");	    //8

			}  //5
			vpd.put("var8", varOList.get(i).getString("FUZEREN"));	    //5
			vpd.put("var9", varOList.get(i).getString("BUSINESS"));	    //6
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
