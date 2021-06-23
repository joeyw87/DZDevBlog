package com.douzone.devblog.board.notice.vo;

import java.util.List;

/**
 * 게시판 관련 상세 VO 클래스(T_BOARD)
 */
public class NoticeVO {
	private int boardSeq; 		// 게시판 번호
	private String boardType;	// 게시판 타입 코드
	private String fromDt;			// 시작
	private String toDt;			// 종료
	private String subject;			// 제목
	private String content;			// 내용
	private String saveYn;	// 저장 여부
	private String status;	// 상태
	private String deleteYn;	// 삭제여부
	private String priorYn;	// 우선공지여부
	private String createSeq;	// 등록유저번호
	private String createDt;	// 등록시간
	private String tBoardProdSeq;	// 제품구분
	
	private List<NoticeProductVO> noticeProductList;
	private List<NoticeAlarmVO> noticeAlarmList;
	private List<NoticeAttachFileVO> noticeAttachFileList;
	
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getFromDt() {
		return fromDt;
	}
	public void setFromDt(String fromDt) {
		this.fromDt = fromDt;
	}
	public String getToDt() {
		return toDt;
	}
	public void setToDt(String toDt) {
		this.toDt = toDt;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSaveYn() {
		return saveYn;
	}
	public void setSaveYn(String saveYn) {
		this.saveYn = saveYn;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}
	public String getPriorYn() {
		return priorYn;
	}
	public void setPriorYn(String priorYn) {
		this.priorYn = priorYn;
	}
	public String getCreateSeq() {
		return createSeq;
	}
	public void setCreateSeq(String createSeq) {
		this.createSeq = createSeq;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String gettBoardProdSeq() {
		return tBoardProdSeq;
	}
	public void settBoardProdSeq(String tBoardProdSeq) {
		this.tBoardProdSeq = tBoardProdSeq;
	}
	
	public List<NoticeProductVO> getNoticeProductList() {
		return noticeProductList;
	}
	public void setNoticeProductList(List<NoticeProductVO> noticeProductList) {
		this.noticeProductList = noticeProductList;
	}
	public List<NoticeAlarmVO> getNoticeAlarmList() {
		return noticeAlarmList;
	}
	public void setNoticeAlarmList(List<NoticeAlarmVO> noticeAlarmList) {
		this.noticeAlarmList = noticeAlarmList;
	}
	public List<NoticeAttachFileVO> getNoticeAttachFileList() {
		return noticeAttachFileList;
	}
	public void setNoticeAttachFileList(List<NoticeAttachFileVO> noticeAttachFileList) {
		this.noticeAttachFileList = noticeAttachFileList;
	}
}
