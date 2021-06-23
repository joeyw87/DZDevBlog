package com.douzone.devblog.common.vo;

import java.io.Serializable;

public class ResultVO implements Serializable {

	private static final long serialVersionUID = -2464411616040056680L;
	
	private String rstCd;
	private String rstNm;
	private int boardSeq;
	private Object data;
	
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstNm() {
		return rstNm;
	}
	public void setRstNm(String rstNm) {
		this.rstNm = rstNm;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}

}
