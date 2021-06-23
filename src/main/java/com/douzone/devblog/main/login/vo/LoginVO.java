package com.douzone.devblog.main.login.vo;

/**
 * 로그인  VO 클래스 (T_USER)
 */
public class LoginVO {

	private String userSeq;               // t_index에서 get                  
	private String compSeq;               // -- 회사id로 알아낸 seq번호             
	private String prodSeq;               // -- 그룹웨어에서 넘어올때 파라메터            
	private String loginId;               // -- 그룹웨어에서 넘어온 파라메터             
	private String loginPsswd;            // -- 패스워드                        
	private String psswdBefore;           // -- now()                       
	private String psswdDt;               // 이름                             
	private String psswdInputFailCount;   //	이메일                           
	private String userName;              // 전화                             
	private String compName;              // 폰번호                            
	private String emailAddr;             // 부서                             
	private String telNumbr;              // 직급                             
	private String mobilTelNumbr;         // 공지 이메일 알림 여부                  	
	private String deptName;              // 공지 문자 알림 여부                   	
	private String position;              // 이벤트 이메일 알림 여부                  
	private String notiEmailYn;           // 이벤트 문자 알림 여부                  	
	private String notiSmsYn;             // 권한                            	
	private String eventEmailYn;          // 탈퇴여부                          
	private String eventSmsYn;            // 생성자                           
	private String roleCode;              // 생성일자                           
	private String deleteYn;              // 수정자                            
	private String createSeq;             // 수정일                            
	private String createDt;                                              
	private String modifySeq;               
	private String modifyDt;                
	private String extensionAttr;
	
	

	public String getEventEmailYn() {
		return eventEmailYn;
	}
	public void setEventEmailYn(String eventEmailYn) {
		this.eventEmailYn = eventEmailYn;
	}
	public String getEventSmsYn() {
		return eventSmsYn;
	}
	public void setEventSmsYn(String eventSmsYn) {
		this.eventSmsYn = eventSmsYn;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getCompSeq() {
		return compSeq;
	}
	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginPsswd() {
		return loginPsswd;
	}
	public void setLoginPsswd(String loginPsswd) {
		this.loginPsswd = loginPsswd;
	}
	public String getPsswdBefore() {
		return psswdBefore;
	}
	public void setPsswdBefore(String psswdBefore) {
		this.psswdBefore = psswdBefore;
	}
	public String getPsswdDt() {
		return psswdDt;
	}
	public void setPsswdDt(String psswdDt) {
		this.psswdDt = psswdDt;
	}
	public String getPsswdInputFailCount() {
		return psswdInputFailCount;
	}
	public void setPsswdInputFailCount(String psswdInputFailCount) {
		this.psswdInputFailCount = psswdInputFailCount;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getTelNumbr() {
		return telNumbr;
	}
	public void setTelNumbr(String telNumbr) {
		this.telNumbr = telNumbr;
	}
	public String getMobilTelNumbr() {
		return mobilTelNumbr;
	}
	public void setMobilTelNumbr(String mobilTelNumbr) {
		this.mobilTelNumbr = mobilTelNumbr;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getNotiEmailYn() {
		return notiEmailYn;
	}
	public void setNotiEmailYn(String notiEmailYn) {
		this.notiEmailYn = notiEmailYn;
	}
	public String getNotiSmsYn() {
		return notiSmsYn;
	}
	public void setNotiSmsYn(String notiSmsYn) {
		this.notiSmsYn = notiSmsYn;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
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
	public String getModifySeq() {
		return modifySeq;
	}
	public void setModifySeq(String modifySeq) {
		this.modifySeq = modifySeq;
	}
	public String getModifyDt() {
		return modifyDt;
	}
	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}
	public String getExtensionAttr() {
		return extensionAttr;
	}
	public void setExtensionAttr(String extensionAttr) {
		this.extensionAttr = extensionAttr;
	}
    
}
