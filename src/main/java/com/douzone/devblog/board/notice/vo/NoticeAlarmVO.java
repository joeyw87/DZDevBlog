package com.douzone.devblog.board.notice.vo;

public class NoticeAlarmVO {
	private int boardSeq; 	// 게시판 번호
	private int Seq; 	// 키
	private String alarmCode; 	// 알림발송 코드
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public int getSeq() {
		return Seq;
	}
	public void setSeq(int Seq) {
		this.Seq = Seq;
	}
	public String getAlarmCode() {
		return alarmCode;
	}
	public void setAlarmCode(String alarmCode) {
		this.alarmCode = alarmCode;
	}
	
}
