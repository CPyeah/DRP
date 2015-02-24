package com.cp.drp.util;

import java.util.List;

/**
 * 封装分页逻辑
 * @author john
 *
 */
public class PageModel {
	
	//保存结果集
	private List list;
	
	//保存记录数
	private int totalRecords;
	
	//每页多少条数据
	private int pageSize;
	
	//第几页
	private int pageNo; 
	
	
	/**
	 * 总页数
	 * @return
	 */
	public int getTotalPages() {
		return (totalRecords + pageSize -1) / pageSize;
	}
	
	/**
	 * 首页
	 * @return
	 */
	public int getTopPageNo() {
		return 1;
	}
	
	/**
	 * 尾页
	 * @return
	 */
	public int getBottomPageNo() {
		return getTotalPages();
	}
	
	/**
	 * 上一页
	 * @return
	 */
	public int getPreviousPageNo() {
		if(this.pageNo <= 1) {
			return 1;
		} else return this.pageNo - 1 ;
	}
	
	/**
	 * 下一页
	 * @return
	 */
	public int getNextPageNo() {
		if(this.pageNo >= getTotalPages()) {
			return getTotalPages();
		} else return this.pageNo + 1;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	
	public int getPageSize() {
		return pageSize;
	}

	public  void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getPageNo() {
		return pageNo;
	}


	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

}
