package com.fh.controller.fhoa.time;

import com.fh.controller.activiti.AcStartController;
import com.fh.entity.Page;
import com.fh.service.fhoa.accessoryfile.AccessoryFileManager;
import com.fh.service.system.fhsms.FhsmsManager;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/time")
public class quartzBean extends AcStartController {
    String menuUrl = "time/list.do"; //菜单地址(权限用)

    @Resource(name = "fhsmsService")
    private FhsmsManager fhsmsService;
    @Resource(name = "oafileService")
    private AccessoryFileManager accessoryFileService;
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd hh:mm");

    @Resource
    private AccessoryFileManager accessoryFileManager;
    public void quartzJobTestMethod() throws Exception {
        sendSms();
    }
    /**
     * 列表
     *
     * @throws Exception
     */
    public  List<PageData> list() throws Exception {
        Map<String, Object> map = new HashMap<>();
        PageData pd = new PageData();

        List<PageData> varList = accessoryFileService.listAll(pd);        //列出Fhfile列表
        List<PageData> nvarList = new ArrayList<PageData>();
        for (int i = 0; i < varList.size(); i++) {
            if(varList.get(i).get("FILETYPE")!=null&&varList.get(i).getString("FILETYPE").equals("中标通知书")){
                PageData pd1 = new PageData();
                pd1.put("USERNAME",  varList.get(i).getString("USERNAME"));
                pd1.put("CTIME",  varList.get(i).getString("CTIME"));
                pd1.put("FILETYPE",  varList.get(i).getString("FILETYPE"));
                nvarList.add(pd1);
            }
            if(varList.get(i).get("FILETYPE")!=null&&varList.get(i).getString("FILETYPE").equals("合同模版")){
                PageData pd1 = new PageData();
                pd1.put("USERNAME",  varList.get(i).getString("USERNAME"));
                pd1.put("CTIME",  varList.get(i).getString("CTIME"));
                pd1.put("FILETYPE",  varList.get(i).getString("FILETYPE"));
                nvarList.add(pd1);
            }
            if(varList.get(i).get("FILETYPE")!=null&&varList.get(i).getString("FILETYPE").equals("合同初稿")){
                PageData pd1 = new PageData();
                pd1.put("USERNAME",  varList.get(i).getString("USERNAME"));
                pd1.put("CTIME",  varList.get(i).getString("CTIME"));
                pd1.put("FILETYPE",  varList.get(i).getString("FILETYPE"));
                nvarList.add(pd1);
            }
            if(varList.get(i).get("FILETYPE")!=null&&varList.get(i).getString("FILETYPE").equals("合同双签")){

                PageData pd1 = new PageData();
                pd1.put("USERNAME",  varList.get(i).getString("USERNAME"));
                pd1.put("CTIME",  varList.get(i).getString("CTIME"));
                pd1.put("FILETYPE",  varList.get(i).getString("FILETYPE"));
                nvarList.add(pd1);
            }

        }

        return nvarList;
    }





    public void sendSms() throws Exception {

        List<PageData> list = list();

        for (int i = 0; i <list.size(); i++) {
            PageData pd = new PageData();
            pd.put("SANME_ID", this.get32UUID());            //ID
            pd.put("SEND_TIME", DateUtil.getTime());        //发送时间
            pd.put("FHSMS_ID", this.get32UUID());            //主键

            pd.put("TYPE", "1");                            //类型1：收信
            pd.put("FROM_USERNAME", list.get(i).getString("USERNAME"));//收信人
            pd.put("TO_USERNAME", "系统消息");
            Date date=sd.parse(list.get(i).get("CTIME").toString());
            Date date1=new Date();

            long from1 = date.getTime();
            long to1 = date1.getTime();
            int days = (int) ((to1 - from1) / (1000 * 60 * 60 * 24));
            System.out.println(days);
            if(days>=1){
                pd.put("CONTENT", "请注意您的待办事件:"+list.get(i).getString("FILETYPE")+"  已超时");
            }else{
                pd.put("CONTENT", "请注意您的待办事件:"+list.get(i).getString("FILETYPE"));
            }


            pd.put("STATUS", "2");
            fhsmsService.save(pd);
        }



    }








}
