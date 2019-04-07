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
    SimpleDateFormat sd1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Resource(name = "supplierService")
    private SupplierManager supplierService;
    @Resource(name = "claimantService")
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
            pd.put("STATUS", 1);
            pd.put("PROJECT_ID", pd.getString("PROJECT_ID"));
            page.setPd(pd);
            list = projectbidService.list(page);

            map.put("list", list);
            list = claimantService.list(page);
            Double count = 0.0;
            for (int i = 0; i < list.size(); i++) {
                count += Double.valueOf(list.get(i).get("CLAIMANT_MONEY").toString());
            }
            map.put("count", count);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);

        return map;
    }


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
        pd = projectbidService.findById(pd);    //根据ID读取
        try {

            /** 工作流的操作 **/
            Map<String, Object> map1 = new LinkedHashMap<String, Object>();
            map1.put("公司", pd.getString("SELECTCOMPANY"));            //选择公司

            map1.put("申请人", Jurisdiction.getU_name());            //当前用户的姓名
            map1.put("项目编号", pd.getString("PROJECT_ID"));
            map1.put("项目名称", pd.getString("PROJECT_NAME"));
            map1.put("医院", pd.getString("HOSPITAL"));
            map1.put("招标公司", pd.getString("TEBDERING"));
            map1.put("招标代表", pd.getString("REPRESENTATIVE"));
            map1.put("中标单位", pd.getString("WINNING_UNIT"));
            map1.put("中标价格（元）", pd.getString("WINNING_PRICE"));

          //  map1.put("中标服务费垫资金额（元）", pd.getString("SERVICE_PRICE"));
          //  map1.put("投标保证金垫资金额（元）", pd.getString("GUARANTEE_MONEY"));
      //      map1.put("投标保证金预计缴纳时间", pd.getString("SCHEDULED_TIME"));
            map1.put("投标保证金实际缴纳时间", pd.getString("PRACTICAL_TIME"));
            map1.put("开标日期", pd.getString("BID_OPEN_TIME"));
            //map1.put("中标服务费预计缴纳时间", pd.getString("SCHEDULED_SERVICE_PRICE_TIME"));
            map1.put("中标服务费实际缴纳时间", pd.getString("PRACTICAL_SERVICE_PRICE_TIME"));

            map1.put("标书制作人", pd.getString("BIAOSHUZHIZUOREN"));
            map1.put("负责人", pd.getString("FUZEREN"));
            map1.put("备注", pd.getString("BZ"));
            map1.put("到期日", pd.getString("CHANPINDAOQIRI"));

            map1.put("附件", "<a onclick=\"allOaFile('" + pd.getString("PROJECT_BID_ID") + "','929f3699b3a14562afbc34ca20a07b07')\" style=' cursor:pointer;'>查看附件</a>");
            map1.put("查看产品", "<a onclick=\"selectProject2('" + pd.getString("PROJECT_BID_ID") + "')\" style=' cursor:pointer;'>查看产品</a>");

            map1.put("USERNAME", Jurisdiction.getUsername());        //指派代理人为当前用户
            String act_id = startProcessInstanceByKeyHasVariables("oa_xiangmutoubiaoliucheng", map1);    //启动流程实例(请假单流程)通过KEY

            pd.put("STATUS", 3);
            pd.put("ACT_ID", act_id);
            pd.put("TABLENAME", "oa_project_bid");
            projectbidService.edit(pd);
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
     * 获取项目数据
     *
     * @return
     */
    @RequestMapping(value = "/getProjectAll")
    @ResponseBody
    public Map<String, Object> getCompanyById() {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            list = projectbidService.projectAll(pd);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);
        map.put("list", list);
        return map;
    }

    /**
     * 获取委托公司数据
     *
     * @return
     */
    @RequestMapping(value = "/projectById")
    @ResponseBody
    public Map<String, Object> projectById() {
        List<PageData> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        String errInfo = "success";
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd = projectbidService.projectById(pd);
        } catch (Exception e) {
            errInfo = "error";
            logger.error(e.toString(), e);
        }
        map.put("errInfo", errInfo);
        map.put("pd", pd);
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

        if (pd.getString("SCHEDULED_TIME").equals("")) {
            pd.remove("SCHEDULED_TIME");
        }
        if (pd.getString("PRACTICAL_TIME").equals("")) {
            pd.remove("PRACTICAL_TIME");
        }
        if (pd.getString("BID_OPEN_TIME").equals("")) {
            pd.remove("BID_OPEN_TIME");
        }
        if (pd.getString("SCHEDULED_SERVICE_PRICE_TIME").equals("")) {
            pd.remove("SCHEDULED_SERVICE_PRICE_TIME");
        }
        if (pd.getString("PRACTICAL_SERVICE_PRICE_TIME").equals("")) {
            pd.remove("PRACTICAL_SERVICE_PRICE_TIME");
        }
        pd.put("UPDATETIME", sd1.format(new Date()));
        pd.put("STATUS", 2);

        projectbidService.save(pd);

        mv.addObject("msg", "success");
        pd.put("STATUS", 2);

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

        if (pd.getString("SCHEDULED_TIME").equals("")) {
            pd.remove("SCHEDULED_TIME");
        }
        if (pd.getString("PRACTICAL_TIME").equals("")) {
            pd.remove("PRACTICAL_TIME");
        }
        if (pd.getString("BID_OPEN_TIME").equals("")) {
            pd.remove("BID_OPEN_TIME");
        }
        if (pd.getString("SCHEDULED_SERVICE_PRICE_TIME").equals("")) {
            pd.remove("SCHEDULED_SERVICE_PRICE_TIME");
        }
        if (pd.getString("PRACTICAL_SERVICE_PRICE_TIME").equals("")) {
            pd.remove("PRACTICAL_SERVICE_PRICE_TIME");
        }
      /*  if(pd.getString("CHANPINDAOQIRI").equals("")){
            pd.remove("CHANPINDAOQIRI");
        }*/
        pd.put("UPDATETIME", sd1.format(new Date()));

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
        titles.add("选择公司");    //2
        titles.add("招标公司");    //2
        titles.add("招标代表");    //2
        titles.add("项目编号");    //2
        titles.add("项目名称");    //2
        titles.add("医院");    //3
        titles.add("中标单位");    //4
        titles.add("中标价格(元)");    //5
       // titles.add("中标服务费垫资金额（元）");    //6
        //titles.add("投标保证金垫资金额(元)");    //7
       // titles.add("投标保证金预计缴纳时间");    //8
        titles.add("投标保证金实际缴纳时间");    //9
        titles.add("开标日期");    //10
      //  titles.add("中标服务费预计缴纳时间");    //11
        titles.add("中标服务费实际缴纳时间");    //12
        titles.add("标书制作人");    //12
        titles.add("风险条款");    //12
        titles.add("负责人");    //12
        titles.add("更新时间");    //12
        titles.add("状态");    //12

        titles.add("备注");    //12

        dataMap.put("titles", titles);
        List<PageData> varOList = projectbidService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("SELECTCOMPANY"));        //2
            vpd.put("var2", varOList.get(i).getString("TEBDERING"));        //2
            vpd.put("var3", varOList.get(i).getString("REPRESENTATIVE"));        //2
            vpd.put("var4", varOList.get(i).getString("PROJECT_ID"));        //2
            vpd.put("var5", varOList.get(i).getString("PROJECT_NAME"));        //2

            vpd.put("var6", varOList.get(i).getString("HOSPITAL"));        //3
            vpd.put("var7", varOList.get(i).getString("WINNING_UNIT"));        //4
            vpd.put("var8", varOList.get(i).getString("WINNING_PRICE"));        //8


            vpd.put("var9", varOList.get(i).getString("SERVICE_PRICE"));        //8


            vpd.put("var10", varOList.get(i).getString("GUARANTEE_MONEY"));        //8

            vpd.put("var11", varOList.get(i).getString("SCHEDULED_TIME"));        //8

            vpd.put("var12", varOList.get(i).getString("PRACTICAL_TIME"));       //8


            vpd.put("var13", varOList.get(i).getString("BID_OPEN_TIME"));        //8

            vpd.put("var14", varOList.get(i).getString("SCHEDULED_SERVICE_PRICE_TIME"));        //8

            vpd.put("var15", varOList.get(i).getString("PRACTICAL_SERVICE_PRICE_TIME"));        //8


            vpd.put("var16", varOList.get(i).getString("BIAOSHUZHIZUOREN"));        //8


            vpd.put("var17", varOList.get(i).getString("FENGXIANTIAOKUAN"));        //8

            vpd.put("var18", varOList.get(i).getString("FUZEREN"));        //8

            vpd.put("var19", sd1.format(varOList.get(i).get("UPDATETIME")));        //12
            if(varOList.get(i).getString("STATUS").equals("1")){
                vpd.put("var20", varOList.get(i).getString("已审批"));	    //6
            }else if(varOList.get(i).getString("STATUS").equals("2")){
                vpd.put("var20", varOList.get(i).getString("未审批"));	    //6
            }else{
                vpd.put("var20", varOList.get(i).getString("审批中"));	    //6
            }
            vpd.put("var21", varOList.get(i).getString("BZ"));        //8


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
