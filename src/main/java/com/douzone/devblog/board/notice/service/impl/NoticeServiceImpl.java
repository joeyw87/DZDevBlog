package com.douzone.devblog.board.notice.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.douzone.devblog.board.notice.dao.NoticeDAO;
import com.douzone.devblog.board.notice.service.NoticeService;
import com.douzone.devblog.board.notice.vo.NoticeAlarmVO;
import com.douzone.devblog.board.notice.vo.NoticeAttachFileVO;
import com.douzone.devblog.board.notice.vo.NoticeProductVO;
import com.douzone.devblog.board.notice.vo.NoticeVO;
import com.douzone.devblog.common.utils.CommonUtils;
import com.douzone.devblog.common.vo.PageOfListVO;
import com.douzone.devblog.common.vo.ResultVO;

/**
 * 게시판 인터페이스 구현 
 */
@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService {	
	
	@Resource(name = "NoticeDAO")
	private NoticeDAO noticeDAO;

	@Override
	public PageOfListVO<Map<String, Object>> retrieveNoticeList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO createNotice(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO updateNotice(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO deleteNoticeList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeVO getNotice(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateViewCnt(String boardSeq) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, Object> getNoticeCntInfo(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
