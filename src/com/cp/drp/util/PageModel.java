package com.cp.drp.util;

import java.util.List;

/**
 * ��װ��ҳ�߼�
 * @author john
 *
 */
public class PageModel {
	
	//��������
	private List list;
	
	//�����¼��
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
