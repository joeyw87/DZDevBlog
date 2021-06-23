package com.douzone.devblog.common.vo;

import java.io.Serializable;
import java.util.List;

public class PageOfListVO<T> implements Serializable {
	private static final long serialVersionUID = -4999050243674531571L;
	
	private List<T> list;
	private int totalCnt;

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	
}