package com.fh.controller.fhoa.projectpurchase;

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
import com.fh.service.fhoa.projectpurchase.ProjectPurchaseManager;

/**
 * 说明：项目采购情况
 *
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value = "/projectpurchase")
public class ProjectPurchaseController extends AcStartController {

    String menuUrl = "projectpurchase/list.do"; //菜单地址(权限用)
    @Resource(name = "projectpurchaseService")
    private ProjectPurchaseManager projectpurchaseService;
    @Resource
    private AccessoryFileManager accessoryFileManager;
    @Resource(name = "supplierService")
    private SupplierManager supplierService;

    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");

    /**
     * 提交流程
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/tijiaoFlow")
    @ResponseBody
    public Map<String, Object> tijiaoFlow() throws Exception {
        Map<String, Object> map = new HashMap<>();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = projectpurchaseService.findById(pd);    //根据ID读取
        try {

            /** 工作流的操作 **/
            Map<String, Object> map1 = new LinkedHashMap<String, Object>();
            map1.put("公司",pd.getString("SELECTCOMPANY") );			//选择公司

            map1.put("申请人", Jurisdiction.getU_name());            //当前用户的姓名
            map1.put("选择公司", pd.getString("SELECTCOMPANY"));
            map1.put("项目编号", pd.getString("SYS_ID"));
            map1.put("项目名称", pd.getString("PROJECTNAME"));
            map1.put("采购合同编号", pd.getString("PURCHASE_CONTRACT_ID"));
            map1.put("供应商序号", pd.getString("SUPPLIER_ID"));
            map1.put("供应商名称", pd.getString("SUPPLIERNAME"));


            map1.put("合同金额(元)", pd.get("CONTRACT_PRICE").toString());
            if (pd.get("CONTRACT_SIGN_TIME")!=null&&!pd.get("CONTRACT_SIGN_TIME").toString().equals("")){
                map1.put("实际合同签订时间", pd.get("CONTRACT_SIGN_TIME").toString());
            }
            map1.put("是否资料齐全", pd.getString("ISZILIAOQQ"));
            map1.put("附件", "<a onclick=\"allOaFile('" + pd.getString("PURCHASE_ID") + "','514b510ca4f0414492b2942fba27ee97')\" style=' cursor:pointer;'>查看附件</a>");
            map1.put("查看产品", "<a onclick=\"selectProduct('"+pd.getString("PURCHASE_ID")+"')\" style=' cursor:pointer;'>查看产品</a>");
            map1.put("风险条款", pd.getString("FENGXIANTIAOKUAN"));
            map1.put("付款约定", pd.getString("FUKUANYUEDING"));
            map1.put("负责人", pd.getString("FUZEREN"));
            map1.put("备注", pd.getString("BZ"));
            map1.put("USERNAME", Jurisdiction.getUsername());        //指派代理人为当前用户
            String act_id = startProcessInstanceByKeyHasVariables("caigouhetongliucheng", map1);    //启动流程实例(请假单流程)通过KEY


            pd.put("STATUS", 3);
            pd.put("ACT_ID", act_id);
            pd.put("TABLENAME", "oa_project_purchase");
            projectpurchaseService.edit(pd);
            supplierService.editTableName(pd);


            map.put("ASSIGNEE_", Jurisdiction.getUsername());
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "请联系管理员部署相应业务流程!");
            map.put("errer", "errer");
        }

        return map;
    }


    /**
     * 获取销售合同数据
     *
     * @return
     */
    @RequestMapping(value = "/getSalesContractAll")
    @ResponseBody
    public Map<String, Object> getSalesContractAll() {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            list = projectpurchaseService.getSalesContractAll(pd);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);
        map.put("list", list);
        return map;
    }


    /**
     * 获取供应商数据
     *
     * @return
     */
    @RequestMapping(value = "/getSupplierAll")
    @ResponseBody
    public Map<String, Object> getSupplierAll() {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            list = projectpurchaseService.getSupplierAll(pd);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);
        map.put("list", list);
        return map;
    }

    @RequestMapping(value = "/CgFindById")
    @ResponseBody
    public Map<String, Object> CgFindById() throws Exception {
        Map<String, Object> map = new HashMap<>();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = projectpurchaseService.findById(pd);    //根据ID读取
        map.put("pd",pd);
        return map;
    }


    /**
     * 获取采购合同数据
     *
     * @return
     */
    @RequestMapping(value = "/getCgAll")
    @ResponseBody
    public Map<String, Object> getCgAll(Page page) {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("STATUS", 1);
            if(pd.get("tag")!=null){
                if(pd.get("tag").toString().equals("inputticket")){
                    pd.remove("STATUS");

                }
            }
            page.setShowCount(9999999);
            page.setPd(pd);
            list = projectpurchaseService.list(page);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);
        map.put("list", list);
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
        logBefore(logger, Jurisdiction.getUsername() + "新增ProjectPurchase");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();


        String purchaseid = this.get32UUID();

        pd.put("PURCHASE_ID", purchaseid);
        //    pd.put("FUZEREN",Jurisdiction.getUsername());
        pd.put("UPDATETIME", sd1.format(new Date()));
        pd.put("STATUS", 2);

        projectpurchaseService.save(pd);

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
        logBefore(logger, Jurisdiction.getUsername() + "删除ProjectPurchase");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        } //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        projectpurchaseService.delete(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "修改ProjectPurchase");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        pd.put("UPDATETIME", sd1.format(new Date()));

        projectpurchaseService.edit(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "列表ProjectPurchase");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        page.setPd(pd);
        List<PageData> varList = projectpurchaseService.list(page);    //列出ProjectPurchase列表


        mv.setViewName("fhoa/projectpurchase/projectpurchase_list");
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
        mv.setViewName("fhoa/projectpurchase/projectpurchase_edit");
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
        pd = projectpurchaseService.findById(pd);    //根据ID读取
        mv.setViewName("fhoa/projectpurchase/projectpurchase_edit");
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
        logBefore(logger, Jurisdiction.getUsername() + "批量删除ProjectPurchase");
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
            projectpurchaseService.deleteAll(ArrayDATA_IDS);
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
        logBefore(logger, Jurisdiction.getUsername() + "导出ProjectPurchase到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("项目编号");    //1
        titles.add("项目名称");    //1
        titles.add("选择公司");    //1

        titles.add("采购合同编号");    //3
        titles.add("供应商");    //4

        titles.add("实际合同签订时间 ");    //9
/*        titles.add("到货期时间");    //10
        titles.add("验收时间");    //10*/
        titles.add("合同总价(元)");    //10
        titles.add("风险条款");    //10
        titles.add("付款约定");    //10
        titles.add("负责人");    //10
        titles.add("更新时间");    //10
        titles.add("状态");    //10
        titles.add("备注");    //10
        dataMap.put("titles", titles);
        List<PageData> varOList = projectpurchaseService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("SYS_ID"));        //1
            vpd.put("var2", varOList.get(i).getString("PROJECTNAME"));        //1
            vpd.put("var3", varOList.get(i).getString("SELECTCOMPANY"));        //1

            vpd.put("var4", varOList.get(i).getString("PURCHASE_CONTRACT_ID"));        //3
            vpd.put("var5", varOList.get(i).getString("SUPPLIERNAME"));


                vpd.put("var6", varOList.get(i).getString("CONTRACT_SIGN_TIME"));	    //8

                vpd.put("var7", varOList.get(i).getString("CONTRACT_PRICE"));	    //8

            //4
            vpd.put("var8", varOList.get(i).getString("FENGXIANTIAOKUAN"));        //5
            vpd.put("var9", varOList.get(i).getString("FUKUANYUEDING"));        //5
            vpd.put("var10", varOList.get(i).getString("FUZEREN"));        //5
            vpd.put("var11", varOList.get(i).get("UPDATETIME").toString());        //5
            if(varOList.get(i).getString("STATUS").equals("1")){
                vpd.put("var12", "已审批");	    //6
            }else if(varOList.get(i).getString("STATUS").equals("2")){
                vpd.put("var12", "未审批");	    //6
            }else{
                vpd.put("var12", "审批中");	    //6
            }
            vpd.put("var13", varOList.get(i).getString("BZ"));        //5
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
