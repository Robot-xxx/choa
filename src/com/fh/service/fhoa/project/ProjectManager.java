package com.fh.service.fhoa.project;

import java.util.List;
import java.util.Map;

import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 项目立项接口
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 * @version
 */
public interface ProjectManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  PageData findById(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  PageData CompanyById(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> CompanyAll(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;


	/**通过id获取产品数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> c_ProductAll(PageData pd)throws Exception;
	/**通过id获取供应商数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> g_SupplierAll(PageData pd)throws Exception;
	/**通过id获取客户数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> k_ClienteleAll(PageData pd)throws Exception;


	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  PageData c_ProductById(PageData pd)throws Exception;
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  PageData g_SupplierById(PageData pd)throws Exception;
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  PageData k_ClienteleById(PageData pd)throws Exception;










}

