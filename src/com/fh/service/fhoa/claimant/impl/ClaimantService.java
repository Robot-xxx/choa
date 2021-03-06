package com.fh.service.fhoa.claimant.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.fhoa.claimant.ClaimantManager;

/** 
 * 说明： 认款记录
 *
 * 创建时间：2018-09-16
 * @version
 */
@Service("claimantService")
public class ClaimantService implements ClaimantManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ClaimantMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ClaimantMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ClaimantMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ClaimantMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ClaimantMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ClaimantMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ClaimantMapper.deleteAll", ArrayDATA_IDS);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void updateMoney(PageData pd)throws Exception{
		dao.update("ClaimantMapper.updateMoney", pd);
	}

	@Override
	public PageData findProjectMarket(String projecr_id) throws Exception {
		return (PageData)dao.findForObject("ClaimantMapper.findProjectMarket", projecr_id);
	}

	@Override
	public PageData findOneClaimant(String project_id) throws Exception {
		return (PageData)dao.findForObject("ClaimantMapper.findOneClaimant",project_id);
	}

}

