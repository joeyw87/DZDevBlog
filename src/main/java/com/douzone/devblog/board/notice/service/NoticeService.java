package com.douzone.devblog.board.notice.service;

import java.util.Map;

import com.douzone.devblog.board.notice.vo.NoticeVO;
import com.douzone.devblog.common.vo.PageOfListVO;
import com.douzone.devblog.common.vo.ResultVO;

/**
 * 게시판 공지사항 인터페이스
 */
public interface NoticeService {

	/**
	 * retrieveNoticeList 공지사항 조회
	 * @param Map<String, Object> param
	 * @return PageOfListVO<Map<String, Object>>
	 */
	public PageOfListVO<Map<String, Object>> retrieveNoticeList(Map<String, Object> param) throws Exception;
	
	/**
	 * createNotice 공지사항 생성
	 * @param Map<String, Object> param
	 * @return ResultVO
	 */
	public ResultVO createNotice(Map<String, Object> param) throws Exception;
	
	/**
	 * updateNotice 공지사항 수정
	 * @param Map<String, Object> param
	 * @return ResultVO
	 */
	public ResultVO updateNotice(Map<String, Object> param) throws Exception;
	
	/**
	 * deleteNoticeList 공지사항 삭제
	 * @param Map<String, Object> param
	 * @return ResultVO
	 */
	public ResultVO deleteNoticeList(Map<String, Object> param) throws Exception;
	
	/**
	 * getNotice 공지사항 가져오기
	 * @param Map<String, Object> param
	 * @return NoticeVO
	 */
	public NoticeVO getNotice(Map<String, Object> param) throws Exception;
	
	public void updateViewCnt(String boardSeq) throws Exception;
	
	/* 공지사항 카운트 정보 조회 */
	public Map<String, Object> getNoticeCntInfo(Map<String, Object> param) throws Exception;
}
