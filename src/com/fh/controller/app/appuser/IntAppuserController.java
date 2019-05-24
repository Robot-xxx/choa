package com.fh.controller.app.appuser;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.activiti.ruprocdef.RuprocdefManager;
import com.fh.service.fhoa.customer.CustomerManager;
import com.fh.service.fhoa.payrequest.PayRequestManager;
import com.fh.service.fhoa.project.ProjectManager;
import com.fh.service.fhoa.projectbid.ProjectBidManager;
import com.fh.service.fhoa.projectmarket.ProjectMarketManager;
import com.fh.service.fhoa.projectpurchase.ProjectPurchaseManager;
import com.fh.service.fhoa.supplier.SupplierManager;
import com.fh.service.fhoa.ticket.TicketManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.*;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.service.system.appuser.AppuserManager;


/**@author
  * 会员-接口类 
  * 相关参数协议：
  * 00	请求失败
  * 01	请求成功
  * 02	返回空值
  * 03	请求协议参数不完整    
  * 04  用户名或密码错误
  * 05  FKEY验证失败
 */
@Controller
@RequestMapping(value="/appuser")
public class IntAppuserController extends BaseController {
    
	@Resource(name="appuserService")
	private AppuserManager appuserService;
	@Resource(name="userService")
	private UserManager userService; //用户登陆
	@Resource(name="supplierService")
	private SupplierManager supplierService;//上游管理
	@Resource(name = "customerService")
	private CustomerManager customerService;//下游管理
	@Resource(name="projectService")
	private ProjectManager projectService;//项目立项
	@Resource(name = "projectbidService")
	private ProjectBidManager projectbidService;//项目投标
	@Resource(name="projectmarketService")
	private ProjectMarketManager projectmarketService;//项目销售
	@Resource(name = "projectpurchaseService")
	private ProjectPurchaseManager projectpurchaseService;//项目采购
	@Resource(name="payrequestService")
	private PayRequestManager payrequestService;//付款申请
	@Resource(name="ticketService")
	private TicketManager ticketService;//开票申请
	@Resource(name="ruprocdefService")
	private RuprocdefManager ruprocdefService;//流程
	@Autowired
	private RepositoryService repositoryService; //管理流程定义  与流程定义和部署对象相关的Service
	@Autowired
	private HistoryService historyService; 		//历史管理(执行完的数据的管理)
	/**获取发起人
	 * @param PROC_INST_ID_ //流程实例ID
	 * @return
	 */
	protected String getInitiator(String PROC_INST_ID_) {
		HistoricProcessInstance hip = historyService.createHistoricProcessInstanceQuery().processInstanceId(PROC_INST_ID_).singleResult(); 			//获取历史流程实例
		List<HistoricActivityInstance> hais = historyService.createHistoricActivityInstanceQuery().processInstanceId(PROC_INST_ID_)
				.orderByHistoricActivityInstanceId().asc().list();	//获取流程中已经执行的节点，按照执行先后顺序排序
		BpmnModel bpmnModel = repositoryService.getBpmnModel(hip.getProcessDefinitionId()); // 获取bpmnModel
		List<FlowNode> historicFlowNodeList = new LinkedList<FlowNode>();					//全部活动实例
		for(HistoricActivityInstance hai : hais) {
			historicFlowNodeList.add((FlowNode) bpmnModel.getMainProcess().getFlowElement(hai.getActivityId()));
			if(hai.getAssignee() != null) {
				return hai.getAssignee();	//不为空的第一个节点办理人就是发起人
			}
		}
		return null;
	}



	@RequestMapping(value = "getDaiBan")
	@ResponseBody
	public Map<String,Object> getDaiBan(){
		Page page= new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}

		pd.put("USERNAME", Jurisdiction.getUsername()); 		//查询当前用户的任务(用户名查询)
		pd.put("RNUMBERS", Jurisdiction.getRnumbers()); 		//查询当前用户的任务(角色编码查询)
		page.setPd(pd);
		List<PageData>	varList = null;	//列出Rutask列表
		try {
			varList = ruprocdefService.list(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(int i=0;i<varList.size();i++){
			varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
		}
			return null;
	}




	/**根据用户名获取会员信息
	 * @return 
	 */
	@RequestMapping(value="/getAppuserByUm")
	@ResponseBody
	public Object getAppuserByUsernmae(){
		logBefore(logger, "根据用户名获取会员信息");
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法
				if(AppUtil.checkParam("getAppuserByUsernmae", pd)){	//检查参数
					pd = appuserService.findByUsername(pd);
					map.put("pd", pd);
					result = (null == pd) ?  "02" :  "01";
				}else {
					result = "03";
				}
			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	/**验证登陆信息
	 * @return
	 */
	@RequestMapping(value="/login")
	@ResponseBody
	public Object login(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法
					String USERNAME = pd.getString("USERNAME");	//登录过来的用户名
					String PASSWORD  =  pd.getString("PASSWORD");	//登录过来的密码

					pd.put("USERNAME", USERNAME);
					String passwd = new SimpleHash("SHA-1", USERNAME, PASSWORD).toString();	//密码加密

					pd.put("PASSWORD", passwd);
					pd = userService.getUserByNameAndPwd(pd);	//根据用户名和密码去读取用户信息

					if(pd != null){
						map.put("pd", pd);
						result = "01";
					}else{
						result= "04"; 				//用户名或密码有误
					}

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	/**获取上游信息
	 * @return
	 */
	@RequestMapping(value="/UpperReaches")
	@ResponseBody
	public Object UpperReaches(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

					String STATUS = pd.getString("STATUS");	//审批状态

					pd.put("STATUS",STATUS);
					List<PageData> varList = supplierService.getListAll(pd);

						map.put("list", varList);
						result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**查看上游信息详情
	 * @return
	 */
	@RequestMapping(value="/CheckUpperReaches")
	@ResponseBody
	public Object CheckUpperReaches(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String SYS_ID =pd.getString("SYS_ID");

				pd.put("SYS_ID",SYS_ID);

				pd = supplierService.getById(pd);	//根据上游ID查询

					map.put("pd", pd);
					result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	/**获取项目投标
	 * @return
	 */
	@RequestMapping(value="/ProjectBid")
	@ResponseBody
	public Object ProjectBid(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String STATUS = pd.getString("STATUS");	//审批状态

				pd.put("STATUS",STATUS);

				page.setPd(pd);

				List<PageData> varList = projectbidService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	/**获取项项目投标详情
	 * @return
	 */
	@RequestMapping(value="/CheckProjectBid")
	@ResponseBody
	public Object CheckProjectBid(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String PROJECT_BID_ID =pd.getString("PROJECT_BID_ID");

				pd.put("PROJECT_BID_ID",PROJECT_BID_ID);

				pd = projectbidService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	/**获取项目立项
	 * @return
	 */
	@RequestMapping(value="/Project")
	@ResponseBody
	public Object Project(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String STATUS = pd.getString("STATUS");	//审批状态

				pd.put("STATUS",STATUS);

				page.setPd(pd);

				List<PageData> varList = projectService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**获取项目立项详情
	 * @return
	 */
	@RequestMapping(value="/CheckProject")
	@ResponseBody
	public Object CheckProject(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String PROJECT_ID =pd.getString("PROJECT_ID");

				pd.put("PROJECT_ID",PROJECT_ID);

				pd = projectService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}



	/**获取项目销售
	 * @return
	 */
	@RequestMapping(value="/ProjectMarket")
	@ResponseBody
	public Object ProjectMarket(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String STATUS = pd.getString("STATUS");	//审批状态

				pd.put("STATUS",STATUS);

				page.setPd(pd);

				List<PageData> varList = projectmarketService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**获取项目立项详情
	 * @return
	 */
	@RequestMapping(value="/CheckProjectMarket")
	@ResponseBody
	public Object CheckProjectMarket(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String PROJECT_MARKET_ID =pd.getString("PROJECT_MARKET_ID");

				pd.put("PROJECT_MARKET_ID",PROJECT_MARKET_ID);

				pd = projectmarketService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	/**获取项目采购
	 * @return
	 */
	@RequestMapping(value="/ProjectPurchase")
	@ResponseBody
	public Object ProjectPurchase(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String STATUS = pd.getString("STATUS");	//审批状态

				pd.put("STATUS",STATUS);

				page.setPd(pd);

				List<PageData> varList = projectpurchaseService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	/**获取项目采购详情
	 * @return
	 */
	@RequestMapping(value="/CheckProjectPurchase")
	@ResponseBody
	public Object CheckProjectPurchase(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String PURCHASE_ID =pd.getString("PURCHASE_ID");

				pd.put("PURCHASE_ID",PURCHASE_ID);

				pd = projectpurchaseService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**付款申请
	 * @return
	 */
	@RequestMapping(value="/PayRequest")
	@ResponseBody
	public Object PayRequest(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String USER_ID = pd.getString("USER_ID");	//审批状态

				pd.put("USER_ID",USER_ID);

				page.setPd(pd);

				List<PageData> varList = payrequestService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	/**获取付款申请详情
	 * @return
	 */
	@RequestMapping(value="/CheckPayRequest")
	@ResponseBody
	public Object CheckPayRequest(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String REQUEST_ID =pd.getString("REQUEST_ID");

				pd.put("REQUEST_ID",REQUEST_ID);

				pd = payrequestService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}



	/**开票申请
	 * @return
	 */
	@RequestMapping(value="/OpenTicket")
	@ResponseBody
	public Object OpenTicket(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String USER_ID = pd.getString("USER_ID");	//审批状态

				pd.put("USER_ID",USER_ID);

				page.setPd(pd);

				List<PageData> varList = ticketService.list(page);

				map.put("list", varList);
				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	/**获取开票申请详情
	 * @return
	 */
	@RequestMapping(value="/CheckOpenTicket")
	@ResponseBody
	public Object CheckOpenTicket(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String TICKET_ID =pd.getString("TICKET_ID");

				pd.put("TICKET_ID",TICKET_ID);

				pd = ticketService.findById(pd);	//根据上游ID查询

				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**审批开票申请
	 * @return
	 */
	@RequestMapping(value="/UpdateOpenTicket")
	@ResponseBody
	public Object UpdateOpenTicket(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String TICKET_ID =pd.getString("TICKET_ID");
				String STATUS =pd.getString("STATUS");

				pd.put("TICKET_ID",TICKET_ID);
				pd=ticketService.findById(pd);
				pd.put("ACT_ID",pd.getString("ACT_ID"));
				pd.put("STATUS",STATUS);
				List<PageData>	varList = ruprocdefService.varList(pd);			//列出流程变量列表

				 ticketService.edit(pd);	//根据上游ID查询

				map.put("varList", varList);
				map.put("pd", pd);
				result = (null == pd) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}







	/**获取下游信息
	 * @return
	 */
	@RequestMapping(value="/DownStream")
	@ResponseBody
	public Object DownStream(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String result = "00";
		try{
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法

				String STATUS = pd.getString("STATUS");	//审批状态

				pd.put("STATUS",STATUS);

				page.setPd(pd);

				List<PageData> varList = customerService.list(page);

					map.put("list", varList);
					result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		}catch (Exception e){
			logger.error(e.toString(), e);
		}finally{
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
}
	
 