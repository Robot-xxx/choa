package com.fh.controller.app.appuser;

import java.net.URLDecoder;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.fh.controller.activiti.AcBusinessController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.service.activiti.hiprocdef.HiprocdefManager;
import com.fh.service.activiti.ruprocdef.RuprocdefManager;
import com.fh.service.fhoa.customer.CustomerManager;
import com.fh.service.fhoa.payrequest.PayRequestManager;
import com.fh.service.fhoa.project.ProjectManager;
import com.fh.service.fhoa.projectbid.ProjectBidManager;
import com.fh.service.fhoa.projectmarket.ProjectMarketManager;
import com.fh.service.fhoa.projectpurchase.ProjectPurchaseManager;
import com.fh.service.fhoa.supplier.SupplierManager;
import com.fh.service.fhoa.ticket.TicketManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.*;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.apache.http.HttpResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.service.system.appuser.AppuserManager;
import org.springframework.web.servlet.ModelAndView;


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
public class IntAppuserController extends AcBusinessController {
    
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
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="hiprocdefService")
	private HiprocdefManager hiprocdefService;



	/**办理任务
	 * @param
	 * @throws Exception
	 */
	@CrossOrigin
	@ResponseBody
	@RequestMapping(value="/handle")
	public Map<String,Object> handle() throws Exception{

		Session session = Jurisdiction.getSession();

		PageData pd = new PageData();
		pd = this.getPageData();
		String taskId = pd.getString("ID_");	//任务ID
		String sfrom = "";
		Object ofrom = getVariablesByTaskIdAsMap(taskId,"审批结果");
		if(null != ofrom){
			sfrom = ofrom.toString();
		}
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		String OPINION = sfrom + Jurisdiction.getU_name() + ",fh,"+pd.getString("OPINION");//审批人的姓名+审批意见
		String msg = pd.getString("msg");
		if("yes".equals(msg)){								//批准
			map.put("审批结果", "【批准】" + OPINION);		//审批结果
			setVariablesByTaskIdAsMap(taskId,map);			//设置流程变量
			setVariablesByTaskId(taskId,"RESULT","批准");
			completeMyPersonalTask(taskId);
		}else{												//驳回
			map.put("审批结果", "【驳回】" + OPINION);		//审批结果
			setVariablesByTaskIdAsMap(taskId,map);			//设置流程变量
			setVariablesByTaskId(taskId,"RESULT","驳回");
			completeMyPersonalTask(taskId);
		}
		try{
			removeVariablesByPROC_INST_ID_(pd.getString("PROC_INST_ID_"),"RESULT");			//移除流程变量(从正在运行中)
		}catch(Exception e){
			/*此流程变量在历史中**/
		}
		try{
			String ASSIGNEE_ = pd.getString("ASSIGNEE_");							//下一待办对象
			if(Tools.notEmpty(ASSIGNEE_)){
				setAssignee(session.getAttribute("TASKID").toString(),ASSIGNEE_);	//指定下一任务待办对象
			}else{
				Object os = session.getAttribute("YAssignee");
				if(null != os && !"".equals(os.toString())){
					ASSIGNEE_ = os.toString();										//没有指定就是默认流程的待办人
				}else{
					 //没有任务监听时，默认流程结束，发送站内信给任务发起人
				}
			}

		}catch(Exception e){
			/*手动指定下一待办人，才会触发此异常。
			 * 任务结束不需要指定下一步办理人了,发送站内信通知任务发起人**/

		}
		pd.put("ACT_ID",pd.getString("PROC_INST_ID_"));
		List<PageData> list = ruprocdefService.queryRenWu(pd);
		if(list.get(0).getString("END_ACT_ID_")!=null&&!list.get(0).getString("END_ACT_ID_").toString().equals("")){
			String tablename= list.get(0).getString("TABLENAME");
			PageData pd1 = new PageData();
			pd1.put("tablename",tablename);
			pd1.put("ACT_ID",pd.getString("PROC_INST_ID_"));
			ruprocdefService.updateParent(pd1);

		}

		return map;
	}




	/**通过角色ID数组获取角色列表拼接角色编码
	 * @return
	 * @throws Exception
	 */
	public String getRnumbers(String username) throws Exception{
		PageData userpd = new PageData();
		userpd.put(Const.SESSION_USERNAME, username);
		userpd = userService.findByUsername(userpd);		//通过用户名获取用户信息
		String ZROLE_ID = userpd.get("ROLE_ID").toString()+",fh,"+userpd.getString("ROLE_IDS");
		String arryROLE_ID[] = ZROLE_ID.split(",fh,");
		List<Role> rlist = roleService.getRoleByArryROLE_ID(arryROLE_ID);
		StringBuffer RNUMBERS = new StringBuffer();
		RNUMBERS.append("(");
		for(Role role:rlist){
			RNUMBERS.append("'"+role.getRNUMBER()+"'");
		}
		RNUMBERS.append(")");
		return RNUMBERS.toString();
	}
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



	/**查看流程信息页面
	 * @param
	 * @throws Exception
	 */
	@CrossOrigin
	@ResponseBody
	@RequestMapping(value="/DaiBanview")
	public Map<String,Object> DaiBanview()throws Exception{
		Map<String,Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		List<PageData>	varList = hiprocdefService.hivarList(pd);			//列出历史流程变量列表
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);		//历史任务节点列表
		if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法
		for(int i=0;i<hitaskList.size();i++){								//根据耗时的毫秒数计算天时分秒
			if(null != hitaskList.get(i).get("DURATION_")){
				Long ztime = Long.parseLong(hitaskList.get(i).get("DURATION_").toString());
				Long tian = ztime / (1000*60*60*24);
				Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
				Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
				Long miao = (ztime % (1000*60*60*24))%(1000*60*60)%(1000*60)/1000;
				hitaskList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分"+miao+"秒");
			}

		}

		map.put("varList",varList);
		map.put("hitaskList",hitaskList);
		result = (null == varList) ?  "02" :  "01";
		}else{
			result = "05";
		}
		map.put("result",result);

		return map;
	}



	/**
	 *
	 * 已办理任务
	 * @return
	 */
	@CrossOrigin
	@RequestMapping(value = "getYiBan")
	@ResponseBody
	public Map<String,Object> getYiBan(){
		Map<String,Object> map = new HashMap<String,Object>();

		Page page= new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";

		try {
			if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法
				String USERNAME = pd.getString("USERNAME");	//登录过来的用户名

				pd.put("USERNAME", USERNAME); 		//查询当前用户的任务(用户名查询)
				pd.put("RNUMBERS", getRnumbers(USERNAME)); 		//查询当前用户的任务(角色编码查询)
				page.setPd(pd);
				List<PageData>	varList = null;	//列出Rutask列表

				varList = ruprocdefService.hitasklist(page);

				for(int i=0;i<varList.size();i++){
					Long ztime = Long.parseLong(varList.get(i).get("DURATION_").toString());
					Long tian = ztime / (1000*60*60*24);
					Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
					Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
					Long miao = (ztime % (1000*60*60*24))%(1000*60*60)%(1000*60)/1000;
					varList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分"+miao+"秒");
					varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
				}
				map.put("varList",varList);
				map.put("varListsize",varList.size());


				result = (null == varList) ?  "02" :  "01";

			}else{
				result = "05";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("result",result);
		return map;
	}



	/**
	 *
	 * 待办理任务
	 * @return
	 */
	@CrossOrigin
	@RequestMapping(value = "getDaiBan")
	@ResponseBody
	public Map<String,Object> getDaiBan(){
		Map<String,Object> map = new HashMap<String,Object>();

		Page page= new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";

		try {
		if(Tools.checkKey("CHOA", pd.getString("FKEY"))){	//检验请求key值是否合法
				String USERNAME = pd.getString("USERNAME");	//登录过来的用户名

				pd.put("USERNAME", USERNAME); 		//查询当前用户的任务(用户名查询)
				pd.put("RNUMBERS", getRnumbers(USERNAME)); 		//查询当前用户的任务(角色编码查询)
				page.setPd(pd);
				List<PageData>	varList = null;	//列出Rutask列表

			    varList = ruprocdefService.list(page);

				for(int i=0;i<varList.size();i++){
					varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
				}
				map.put("varList",varList);
				map.put("varListsize",varList.size());

				result = (null == varList) ?  "02" :  "01";

		}else{
			result = "05";
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("result",result);
		return map;
	}




	/**根据用户名获取会员信息
	 * @return 
	 */
	@CrossOrigin
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
	@CrossOrigin
	@RequestMapping(value="/login")
	@ResponseBody
	public Object login(HttpServletResponse response){
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	@CrossOrigin
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
	
 