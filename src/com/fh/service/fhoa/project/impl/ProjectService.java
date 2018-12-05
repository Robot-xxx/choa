package com.fh.service.fhoa.project.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.fhoa.project.ProjectManager;

/** 
 * 说明： 项目立项
 * 创建人：FH Q313596790
 * 创建时间：2018-08-30
 * @version
 */
@Service("projectService")
public class ProjectService implements ProjectManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProjectMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProjectMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProjectMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.findById", pd);
	}


	public PageData CompanyById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.CompanyById", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> CompanyAll(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("ProjectMapper.CompanyAll", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProjectMapper.deleteAll", ArrayDATA_IDS);
	}



	/**通过id获取产品数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> c_ProductAll(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("ProjectMapper.c_ProductAll", pd);
	}
		/**通过id获取供应商数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> g_SupplierAll(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("ProjectMapper.g_SupplierAll", pd);
	}
		/**通过id获取客户数据
	 * @param pd
	 * @throws Exception
	 */
	public  List<PageData> k_ClienteleAll(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("ProjectMapper.k_ClienteleAll", pd);
	}




	public PageData c_ProductById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.c_ProductById", pd);
	}
	public PageData g_SupplierById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.g_SupplierById", pd);
	}
	public PageData k_ClienteleById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.k_ClienteleById", pd);
	}
}

