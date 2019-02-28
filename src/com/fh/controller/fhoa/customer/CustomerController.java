package com.fh.controller.fhoa.customer;

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
import com.fh.util.Tools;
import com.fh.service.fhoa.customer.CustomerManager;

/**
 * 说明：客户管理模块
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value = "/customer")
public class CustomerController extends AcStartController {

    String menuUrl = "customer/list.do"; //菜单地址(权限用)
    @Resource(name = "customerService")
    private CustomerManager customerService;
    @Resource
    private AccessoryFileManager accessoryFileManager;
    @Resource(name="supplierService")
    private SupplierManager supplierService;
    SimpleDateFormat sd =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat sd1 =new SimpleDateFormat("yyyy-MM-dd");

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
        pd = customerService.findById(pd);    //根据ID读取

        try {

            /** 工作流的操作 **/
            Map<String,Object> map1 = new LinkedHashMap<String, Object>();

            map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
            map1.put("客户编号", pd.getString("SYS_ID"));
            map1.put("公司全称", pd.getString("COMPANY_NAME"));
            map1.put("联系人", pd.getString("LINKMAN"));
            map1.put("联系电话", pd.getString("PHONE"));
            map1.put("税号", pd.getString("DUTY_PARAGRAPH"));
            map1.put("开户行", pd.getString("OPENING_BANK"));
            map1.put("开户账号", pd.getString("BANKACCOUNT"));
            map1.put("医疗许可证", pd.getString("DNAME8"));
            map1.put("纸质资料是否齐全", pd.getString("ISZILIAOQQ"));

          /*  if (pd.get("SHENGCHANXUKEZHENG")!=null&&!pd.get("SHENGCHANXUKEZHENG").toString().equals("")){
                map1.put("生产许可证", pd.get("SHENGCHANXUKEZHENG").toString());
            }*/
            if (pd.get("BUJIAOSHIJIAN")!=null&&!pd.get("BUJIAOSHIJIAN").toString().equals("")){
                map1.put("补交时间", pd.get("BUJIAOSHIJIAN").toString());
            }
            if (pd.get("SHENGCHANXUKEZHENG")!=null&&!pd.get("JINGYINGXUKEZHENG").toString().equals("")){
                map1.put("经营许可证", pd.get("JINGYINGXUKEZHENG").toString());
            }
            if (pd.get("SHENGCHANXUKEZHENG")!=null&&!pd.get("FARENSHOUQUAN").toString().equals("")){
                map1.put("法人授权书", pd.get("FARENSHOUQUAN").toString());
            }
            if (pd.get("SHENGCHANXUKEZHENG")!=null&&!pd.get("SHOUQUANWEITUO").toString().equals("")){
                map1.put("授权委托书", pd.get("SHOUQUANWEITUO").toString());
            }
            map1.put("上传者", pd.getString("FUZEREN"));
            map1.put("备注", pd.getString("BZ"));
            map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("CUSTOMER_ID")+"','cf29c9db335046c58071d5dfc84d3d21')\" style=' cursor:pointer;'>查看附件</a>");

            map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
            String act_id= startProcessInstanceByKeyHasVariables("k_kehuguanlishenpi",map1);	//启动流程实例(请假单流程)通过KEY


            pd.put("STATUS",3);
            pd.put("ACT_ID",act_id);
            pd.put("TABLENAME","oa_customer");
            customerService.edit(pd);
            supplierService.editTableName(pd);



            map.put("ASSIGNEE_",Jurisdiction.getUsername());
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","请联系管理员部署相应业务流程!");
            map.put("errer","errer");
        }

        return map;
    }








    /**获取客户信息
     * @return
     */
    @RequestMapping(value="/getAllCustomer")
    @ResponseBody
    public Map<String,Object> getAllCustomer(Page page){
        List<PageData> list = new ArrayList<>();
        Map<String,Object> map  = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try{
            pd = this.getPageData();

            pd.put("STATUS",1);
            page.setPd(pd);
            page.setShowCount(99999);
            list = customerService.list(page);
        } catch(Exception e){
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo",errInfo);
        map.put("list",list);
        return map;
    }


    /**
     * 保存
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    public ModelAndView save() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "新增Customer");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
     /*   if(pd.getString("SHENGCHANXUKEZHENG").equals("")){
            pd.put("SHENGCHANXUKEZHENG",null);
        }*/

        if(pd.getString("JINGYINGXUKEZHENG").equals("")){
            pd.put("JINGYINGXUKEZHENG",null);
        }

        if(pd.getString("FARENSHOUQUAN").equals("")){
            pd.put("FARENSHOUQUAN",null);
        }

        if(pd.getString("SHOUQUANWEITUO").equals("")){
            pd.put("SHOUQUANWEITUO",null);
        }
        String customerId = this.get32UUID();


        pd.put("CUSTOMER_ID", customerId);    //主键
        pd.put("UPDATETIME", sd.format(new Date()));

        pd.put("FUZEREN", Jurisdiction.getUsername());
        pd.put("STATUS", 2);

        customerService.save(pd);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除
     *
     * @param out
     * @throws Exception
     */
    @RequestMapping(value = "/delete")
    public void delete(PrintWriter out) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "删除Customer");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        } //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        customerService.delete(pd);
        out.write("success");
        out.close();
    }

    /**
     * 修改
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "修改Customer");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("FUZEREN", Jurisdiction.getUsername());
        if(pd.getString("SHENGCHANXUKEZHENG").equals("")){
            pd.put("SHENGCHANXUKEZHENG",null);
        }

        if(pd.getString("JINGYINGXUKEZHENG").equals("")){
            pd.put("JINGYINGXUKEZHENG",null);
        }

        if(pd.getString("FARENSHOUQUAN").equals("")){
            pd.put("FARENSHOUQUAN",null);
        }

        if(pd.getString("SHOUQUANWEITUO").equals("")){
            pd.put("SHOUQUANWEITUO",null);
        }
        pd.put("UPDATETIME", sd.format(new Date()));
        pd.put("STATUS",2);
        customerService.edit(pd);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "列表Customer");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        page.setPd(pd);
        List<PageData> varList = customerService.list(page);    //列出Customer列表
        mv.setViewName("fhoa/customer/customer_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 去新增页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/goAdd")
    public ModelAndView goAdd() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("fhoa/customer/customer_edit");
        mv.addObject("msg", "save");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 去修改页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/goEdit")
    public ModelAndView goEdit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = customerService.findById(pd);    //根据ID读取
        mv.setViewName("fhoa/customer/customer_edit");
        mv.addObject("msg", "edit");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 批量删除
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "批量删除Customer");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return null;
        } //校验权限
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        pd = this.getPageData();
        List<PageData> pdList = new ArrayList<PageData>();
        String DATA_IDS = pd.getString("DATA_IDS");
        if (null != DATA_IDS && !"".equals(DATA_IDS)) {
            String ArrayDATA_IDS[] = DATA_IDS.split(",");
            customerService.deleteAll(ArrayDATA_IDS);
            pd.put("msg", "ok");
        } else {
            pd.put("msg", "no");
        }
        pdList.add(pd);
        map.put("list", pdList);
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 导出到excel
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/excel")
    public ModelAndView exportExcel() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "导出Customer到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        //主键ID
        titles.add("客户序号");    //2
        titles.add("公司全称");    //3
        titles.add("联系人");    //4
        titles.add("联系电话");    //5
        titles.add("税号");    //6
        titles.add("开户行");    //7
        titles.add("开户行账号");    //7
        titles.add("医疗许可证");    //8
        titles.add("生产许可证期日");	//6
        titles.add("经营许可证期日");	//6
        titles.add("法人授权书期日");	//6
        titles.add("授权委托书期日");	//6
        titles.add("补交时间");	//6

        titles.add("纸质是否资料齐全");	//7
        titles.add("上传者");	//6
        titles.add("备注");    //10
        dataMap.put("titles", titles);
        List<PageData> varOList = customerService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            //主键ID
            vpd.put("var1", varOList.get(i).getString("SYS_ID"));        //2
            vpd.put("var2", varOList.get(i).getString("COMPANY_NAME"));        //3
            vpd.put("var3", varOList.get(i).getString("LINKMAN"));        //4
            vpd.put("var4", varOList.get(i).getString("PHONE"));        //5
            vpd.put("var5", varOList.get(i).getString("DUTY_PARAGRAPH"));        //6
            vpd.put("var6", varOList.get(i).getString("OPENING_BANK"));        //7
            vpd.put("var7", varOList.get(i).getString("BANKACCOUNT"));        //7
            vpd.put("var8", varOList.get(i).getString("DNAME8"));        //8
            if (varOList.get(i).get("SHENGCHANXUKEZHENG")!=null&&!varOList.get(i).get("SHENGCHANXUKEZHENG").toString().equals("")) {
                vpd.put("var9", sd1.format(varOList.get(i).get("SHENGCHANXUKEZHENG")));	    //8
            }else {
                vpd.put("var9","");	    //8

            }
            if (varOList.get(i).get("JINGYINGXUKEZHENG")!=null&&!varOList.get(i).get("JINGYINGXUKEZHENG").toString().equals("")) {
                vpd.put("var10", sd1.format(varOList.get(i).get("JINGYINGXUKEZHENG")));	    //8
            }else {
                vpd.put("var10","");	    //8

            }
            if (varOList.get(i).get("FARENSHOUQUAN")!=null&&!varOList.get(i).get("FARENSHOUQUAN").toString().equals("")) {
                vpd.put("var11", sd1.format(varOList.get(i).get("FARENSHOUQUAN")));	    //8
            }else {
                vpd.put("var11","");	    //8

            }
            if (varOList.get(i).get("SHOUQUANWEITUO")!=null&&!varOList.get(i).get("SHOUQUANWEITUO").toString().equals("")) {
                vpd.put("var12", sd1.format(varOList.get(i).get("SHOUQUANWEITUO")));	    //8
            }else {
                vpd.put("var12","");	    //8

            }
            if (varOList.get(i).get("BUJIAOSHIJIAN")!=null&&!varOList.get(i).get("BUJIAOSHIJIAN").toString().equals("")) {
                vpd.put("var13", sd.format(varOList.get(i).get("BUJIAOSHIJIAN")));	    //8
            }else {
                vpd.put("var13","");	    //8

            }
            vpd.put("var14", varOList.get(i).getString("ISZILIAOQQ"));	    //6
            vpd.put("var15", varOList.get(i).getString("FUZHEREN"));	    //6
            vpd.put("var16", varOList.get(i).getString("BZ"));        //10
            varList.add(vpd);
        }
        dataMap.put("varList", varList);
        ObjectExcelView erv = new ObjectExcelView();
        mv = new ModelAndView(erv, dataMap);
        return mv;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
}
