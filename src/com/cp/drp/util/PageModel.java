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

}
