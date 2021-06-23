package com.douzone.devblog.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.douzone.devblog.common.dao.CodeManageDAO;
import com.douzone.devblog.common.service.CodeManageService;

@Service("CodeManageService")
public class CodeManageServiceImpl implements CodeManageService {
	
    private final static Logger logger = LoggerFactory.getLogger(CodeManageServiceImpl.class);
    
	@Resource(name = "CodeManageDAO")
	private CodeManageDAO codeManageDAO;

	/**
	 * CodeManageServiceImpl 코드관리 서비스 로직
	 * @param Map<String, Object> params
	 */
	
	@Override
	public List<Map<String, Object>> getProdCodeTreeList(Map<String, Object> params) throws Exception {
		Map tree = new HashMap<String, Map<String, Object>>();
		Map burffer = new HashMap<String, Map<String, Object>>();
		
		List<Map<String, Object>> returnList = new ArrayList<>();
		List<Map<String, Object>> list = codeManageDAO.getCnsltCodeList(params);
		
		for (Map<String, Object> item : list) {

			Map<String, Object> node = new HashMap<String, Object>();
			Map<String, Object> nodeState = new HashMap<String, Object>();
			
			//노드 상태값 selected,opened
			//nodeState.put("selected", item.get("STATE").equals("OPEN") ? true : false);
			nodeState.put("selected", false);
			nodeState.put("opened", false);
			//자식노드 없을때 disabled 처리
			//nodeState.put("disabled", "N".equals(item.get("CHILD_YN").toString()) ? true : false);
			
			Map<String, Object> fIcon = new HashMap<String, Object>();
			
			//양식 아이콘 적용
			String fColor = "";
			if (item.get("SPRITECSSCLASS").toString().equals("FILE")) {
				fColor = "col_file";
			}
			
			fIcon.put("class", fColor);
			node.put("tIcon", fColor);
			node.put("li_attr", fIcon);
			
			
			node.put("id", item.get("CODE_SEQ").toString());
			node.put("text", item.get("CODE_NAME").toString());
			node.put("prod_seq", item.get("PROD_SEQ"));
			node.put("upper_id", item.get("PARENT_CODE_SEQ"));
			node.put("use_yn", item.get("USE_YN"));
			node.put("code_desc", item.get("CODE_DESC"));
			node.put("form_seq", item.get("FORM_SEQ"));
			node.put("level", item.get("LEVEL"));
			node.put("order_num", item.get("ORDER_NUM"));
			node.put("state", nodeState);
			node.put("SPRITECSSCLASS", item.get("SPRITECSSCLASS"));
			node.put("children", new ArrayList<Map<String, Object>>());

			burffer.put(item.get("path"), node);
			
		}

		ArrayList<String> comp_seqList = new ArrayList<>();

		for (int i = list.size() - 1; i > -1; i--) {
			
			Map<String, Object> item = list.get(i);
			Map<String, Object> node = new HashMap<String, Object>();
			String id = item.get("path").toString();
			Map<String, Object> bNode = (Map<String, Object>) burffer.get(id);
			//System.out.println("bNode===:"+bNode);
			Map<String, Object> fIcon = new HashMap<String, Object>();
			String fColor = "";
			if (bNode.get("SPRITECSSCLASS").toString().equals("FILE")) {
				fColor = "col_file";
			}
			
			fIcon.put("class", fColor);
			fIcon.put("css", fColor);
			node.put("tIcon", fColor);
			node.put("li_attr", fIcon);
			
			node.put("id", bNode.get("id"));
			node.put("text", bNode.get("text"));
			node.put("prod_seq", item.get("PROD_SEQ"));
			node.put("upper_id", item.get("PARENT_CODE_SEQ"));
			node.put("state", bNode.get("state"));
			node.put("use_yn", bNode.get("use_yn"));
			node.put("code_desc", bNode.get("code_desc"));
			node.put("form_seq", bNode.get("form_seq"));
			node.put("level", bNode.get("level"));
			node.put("order_num", bNode.get("order_num"));
			node.put("children", bNode.get("children"));

			if (item.get("CODE_SEQ").toString().equals("0")) {
				tree.put(node.get("id"), burffer.get(id));
				comp_seqList.add(0,item.get("CODE_SEQ").toString());		
			}else{
				try{
					//System.out.println("burffer.get===:"+burffer.get(item.get("parent_path")));
					((ArrayList<Map<String, Object>>) ((Map<String, Object>) burffer.get(item.get("parent_path"))).get("children")).add(0,node);
					
				}catch(Exception e){
					//System.out.println("****  Can't find id : " + item.get("parent_seq") + "  ***");
				}
			}
		}
		
		for (String item : comp_seqList) {
			//System.out.println("tree.get(item)"+tree.get(item));
			returnList.add((Map<String, Object>) tree.get(item));
		}
		return returnList;
	}

	@Override
	public Map<String, Object> insertCnsltCode(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String level = (String)paramMap.get("ulevel"); //부모 레벨
			if( "0".equals(level) ){
				paramMap.put("level", "1");
			}else if( "1".equals(level) ){
				paramMap.put("level", "2");
			}else if( "2".equals(level) ){
				paramMap.put("level", "3");
			}else{
				paramMap.put("level", "3"); //최대 3댑스
			}
			
			codeManageDAO.insertCnsltCode(paramMap);
			result.put("resultCode", "SUCCESS");
		}catch(Exception e){
			result.put("resultCode", "FAIL");
		}
		return result;
	}

	@Override
	public Map<String,Object> deleteCnsltCode(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			List<Map<String,Object>> childList = codeManageDAO.selectChildTreeList(paramMap);
			if(childList.size() > 0){	//자식이 있으면 삭제 불가
				result.put("resultCode", "FAIL");
				result.put("resultMessage", "하위 분류값이 존재하므로 삭제할 수 없습니다.");
			}else{
				codeManageDAO.deleteCnsltCode(paramMap);
				result.put("resultCode", "SUCCESS");
			}
			
		}catch(Exception e){
			result.put("resultCode", "FAIL");
			result.put("resultMessage", "삭제를 실패하였습니다.");
		}
		return result;
	}

	@Override
	public Map<String, Object> selectCnsltCode(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Map<String,Object> codeData = codeManageDAO.selectCnsltCode(paramMap);
			if(codeData != null ){	//코드가 존재하면
				result.put("resultCode", "FAIL");
				result.put("resultMessage", "해당 코드가 이미 존재합니다.");
			}else{
				result.put("resultCode", "SUCCESS");
			}
			
		}catch(Exception e){
			result.put("resultCode", "FAIL");
			result.put("resultMessage", "코드 조회를 실패하였습니다.");
		}
		return result;
	}

}
