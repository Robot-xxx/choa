package com.fh.service.fhoa.projectbid.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.fhoa.projectbid.ProjectBidManager;

/** 
 * 说明： 项目投标情况
 *
 * 创建时间：2018-08-30
 * @version
 */
@Service("projectbidService")
public class ProjectBidService implements ProjectBidManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProjectBidMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProjectBidMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProjectBidMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProjectBidMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectBidMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectBidMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProjectBidMapper.deleteAll", ArrayDATA_IDS);
	}



	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> projectAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectBidMapper.projectAll", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData projectById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectBidMapper.projectById", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findProjectBid(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectBidMapper.findProjectBid", pd);
	}
}

