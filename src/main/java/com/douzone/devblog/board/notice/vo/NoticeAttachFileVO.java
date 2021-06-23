package com.douzone.devblog.board.notice.vo;

public class NoticeAttachFileVO {
	private int attachSeq; 	// 첨부파일 시퀀스
	private int boardSeq; 	// 게시물 시퀀스
	private String originFileName; 	// 원본파일명
	private String saveFileName; 	// 서버저장파일명
	private String fileExt;			// 파일확장자
	private int fileSize;		// 파일사이즈
	private String deleteYn;	// 파일삭제여부 Y:삭제 N:미삭제
	
	public int getAttachSeq() {
		return attachSeq;
	}
	public void setAttachSeq(int attachSeq) {
		this.attachSeq = attachSeq;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getFileExt() {
		return fileExt;
	}
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}
	
}
