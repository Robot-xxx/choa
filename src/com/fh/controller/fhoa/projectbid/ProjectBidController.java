package com.fh.controller.fhoa.projectbid;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.controller.activiti.AcStartController;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
import com.fh.service.fhoa.claimant.ClaimantManager;
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
import com.fh.service.fhoa.projectbid.ProjectBidManager;

/**
 * 说明：项目投标情况
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 */
@Controller
@RequestMapping(value = "/projectbid")
public class ProjectBidController extends AcStartController {

    String menuUrl = "projectbid/list.do"; //菜单地址(权限用)
    @Resource(name = "projectbidService")
    private ProjectBidManager projectbidService;
    @Resource
    private AccessoryFileManager accessoryFileManager;

    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");

    @Resource(name="supplierService")
    private SupplierManager supplierService;
    @Resource(name="claimantService")
    private ClaimantManager claimantService;

    /**
     * 获取投标合同数据
     *
     * @return
     */
    @RequestMapping(value = "/getBid")
    @ResponseBody
    public Map<String, Object> getCgAll(Page page) {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("STATUS",1);
            pd.put("PROJECT_ID",pd.getString("PROJECT_ID"));
            page.setPd(pd);
            list = projectbidService.list(page);

            map.put("list", list);
            list =  claimantService.list(page);
            Double count = 0.0;
            for (int i = 0; i <list.size() ; i++) {
                 count+= Double.valueOf( list.get(i).get("CLAIMANT_MONEY").toString());
            }
            map.put("count", count);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);

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
        pd = projectbidService.findById(pd);	//根据ID读取
        try {

            /** 工作流的操作 **/
            Map<String,Object> map1 = new LinkedHashMap<String, Object>();
            map1.put("公司",pd.getString("SELECTCOMPANY") );			//选择公司

            map1.put("申请人", Jurisdiction.getU_name());			//当前用户的姓名
            map1.put("项目编号", pd.getString("PROJECT_ID"));
            map1.put("项目名称", pd.getString("PROJECT_NAME"));
            map1.put("医院", pd.getString("HOSPITAL"));
            map1.put("中标单位", pd.getString("WINNING_UNIT"));
            map1.put("中标价格（万元）", pd.get("WINNING_PRICE").toString());
            map1.put("投标保证金垫资金额（万元）", pd.get("GUARANTEE_MONEY").toString());
            map1.put("备注", pd.getString("BZ"));
            if (pd.get("CHANPINDAOQIRI")!=null&&!pd.get("CHANPINDAOQIRI").toString().equals("")){
                map1.put("到期日", pd.get("CHANPINDAOQIRI").toString());
            }

            map1.put("附件", "<a onclick=\"allOaFile('"+pd.getString("PROJECT_BID_ID")+"','929f3699b3a14562afbc34ca20a07b07')\" style=' cursor:pointer;'>查看附件</a>");

            map1.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
            String act_id=startProcessInstanceByKeyHasVariables("oa_xiangmutoubiaoliucheng",map1);	//启动流程实例(请假单流程)通过KEY

            pd.put("STATUS",3);
            pd.put("ACT_ID",act_id);
            pd.put("TABLENAME","oa_project_bid");
            projectbidService.edit(pd);
            supplierService.editTableName(pd);

            map.put("ASSIGNEE_",Jurisdiction.getUsername());
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","请联系管理员部署相应业务流程!");
            map.put("errer","errer");
        }

        return map;
    }



    /**获取项目数据
     * @return
     */
    @RequestMapping(value="/getProjectAll")
    @ResponseBody
    public Map<String,Object> getCompanyById(){
        List<PageData> list = new ArrayList<>();
        Map<String,Object> map  = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try{
            pd = this.getPageData();
            list = projectbidService.projectAll(pd);
        } catch(Exception e){
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo",errInfo);
        map.put("list",list);
        return map;
    }

    /**获取委托公司数据
     * @return
     */
    @RequestMapping(value="/projectById")
    @ResponseBody
    public Map<String,Object> projectById(){
        List<PageData> list = new ArrayList<>();
        Map<String,Object> map  = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try{
            pd = this.getPageData();
            pd = projectbidService.projectById(pd);
        } catch(Exception e){
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo",errInfo);
        map.put("pd",pd);
        return map;
    }

    /**
     * 保存
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    public ModelAndView save() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "新增ProjectBid");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();




        String projectbidid = this.get32UUID();

        pd.put("PROJECT_BID_ID", projectbidid);    //主键
        //pd.put("FUZEREN", Jurisdiction.getUsername());    //主键

        if(pd.getString("SCHEDULED_TIME").equals("")){
            pd.remove("SCHEDULED_TIME");
        }
        if(pd.getString("PRACTICAL_TIME").equals("")){
            pd.remove("PRACTICAL_TIME");
        }
        if(pd.getString("BID_OPEN_TIME").equals("")){
            pd.remove("BID_OPEN_TIME");
        }
        if(pd.getString("SCHEDULED_SERVICE_PRICE_TIME").equals("")){
            pd.remove("SCHEDULED_SERVICE_PRICE_TIME");
        }
        if(pd.getString("PRACTICAL_SERVICE_PRICE_TIME").equals("")){
            pd.remove("PRACTICAL_SERVICE_PRICE_TIME");
        }
        if(pd.getString("CHANPINDAOQIRI").equals("")){
            pd.remove("CHANPINDAOQIRI");
        }
        projectbidService.save(pd);

        mv.addObject("msg","success");






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
        logBefore(logger, Jurisdiction.getUsername() + "删除ProjectBid");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        } //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        projectbidService.delete(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "修改ProjectBid");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        if(pd.getString("SCHEDULED_TIME").equals("")){
            pd.remove("SCHEDULED_TIME");
        }
        if(pd.getString("PRACTICAL_TIME").equals("")){
            pd.remove("PRACTICAL_TIME");
        }
        if(pd.getString("BID_OPEN_TIME").equals("")){
            pd.remove("BID_OPEN_TIME");
        }
        if(pd.getString("SCHEDULED_SERVICE_PRICE_TIME").equals("")){
            pd.remove("SCHEDULED_SERVICE_PRICE_TIME");
        }
        if(pd.getString("PRACTICAL_SERVICE_PRICE_TIME").equals("")){
            pd.remove("PRACTICAL_SERVICE_PRICE_TIME");
        }
        if(pd.getString("CHANPINDAOQIRI").equals("")){
            pd.remove("CHANPINDAOQIRI");
        }

        projectbidService.edit(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "列表ProjectBid");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        page.setPd(pd);
        List<PageData> varList = projectbidService.list(page);    //列出ProjectBid列表

        mv.setViewName("fhoa/projectbid/projectbid_list");
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
        mv.setViewName("fhoa/projectbid/projectbid_edit");
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
        pd = projectbidService.findById(pd);    //根据ID读取
        mv.setViewName("fhoa/projectbid/projectbid_edit");
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
        logBefore(logger, Jurisdiction.getUsername() + "批量删除ProjectBid");
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
            projectbidService.deleteAll(ArrayDATA_IDS);
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
        logBefore(logger, Jurisdiction.getUsername() + "导出ProjectBid到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("系统编序号");    //1
        titles.add("项目名称");    //2
        titles.add("医院");    //3
        titles.add("中标单位");    //4
        titles.add("中标价格(万元)");    //5
        titles.add("投标保证金垫资金额(万元)");    //6
        titles.add("投标保证金预计缴纳时间");    //7
        titles.add("投标保证金实际缴纳时间");    //8
        titles.add("开标日期");    //9
        titles.add("中标服务费 垫资金额（万元）");    //10
        titles.add("中标服务费预计缴纳时间");    //11
        titles.add("中标服务费实际缴纳时间");    //12
       /* titles.add("领取中标通知书时间及上传附件");    //13
        titles.add("合同模板时间（1天)");    //14
        titles.add("合同双签时间（一周）");    //15
        titles.add("退投标保证金时间");    //16*/
        dataMap.put("titles", titles);
        List<PageData> varOList = projectbidService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("SYS_ID"));        //1
           vpd.put("var2", varOList.get(i).getString("PROJECT_NAME"));        //2
            vpd.put("var3", varOList.get(i).getString("HOSPITAL"));        //3
            vpd.put("var4", varOList.get(i).getString("WINNING_UNIT"));        //4
            vpd.put("var5", varOList.get(i).get("WINNING_PRICE").toString());        //5
            vpd.put("var6", varOList.get(i).get("GUARANTEE_MONEY").toString());        //6
            vpd.put("var7",  varOList.get(i).get("SCHEDULED_TIME"));        //7
            vpd.put("var8",  varOList.get(i).get("PRACTICAL_TIME"));        //8
            vpd.put("var9",  varOList.get(i).get("BID_OPEN_TIME"));        //9
            vpd.put("var10", varOList.get(i).get("SERVICE_PRICE"));        //10
            vpd.put("var11", varOList.get(i).get("SCHEDULED_SERVICE_PRICE_TIME"));        //11
            vpd.put("var12", varOList.get(i).get("PRACTICAL_SERVICE_PRICE_TIME"));        //12
           /* vpd.put("var13", varOList.get(i).getString("ADVICE"));        //13*/
       /*     vpd.put("var14",  sd.format(varOList.get(i).get("CONTRACT_MODEL_TIME")));        //14
            vpd.put("var15",  sd.format(varOList.get(i).get("COUNTER_SIGN_TIME")));        //15
            vpd.put("var16", sd.format(varOList.get(i).get("WITHDRAWAL_SECURITY")));        //16*/
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
