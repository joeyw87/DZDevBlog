<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (isMultipart) {
  File temporaryDir = new File("/tmp/");                                                 //업로드 된 파일의 임시 저장 폴더를 설정
  //String realDir = config.getServletContext().getRealPath("dzeditor_ori/upload/");                  //톰켓의 전체 경로를 가져오고 upload라는 폴더를 만들고 거기다
  //String realDir = "/home/neos/tomcat/webapps/dz_editor/dzeditor/server/upload";

  //String path = "/dzeditor1.0/server/upload/";
  String path = "d:/upload/";
  ServletContext context = getServletContext();
  String realDir = context.getRealPath(path);
  
                                                                                                                    //tmp의 폴더의 전송된 파일을 upload 폴더로 카피 한다.
  DiskFileItemFactory factory = new DiskFileItemFactory();                                   
  factory.setSizeThreshold(1 * 1024 * 1024);                                                      //1메가가 넘지 않으면 메모리에서 바로 사용
  factory.setRepository(temporaryDir);                                                               //1메가 이상이면 temporaryDir 경로 폴더로 이동

  ServletFileUpload upload = new ServletFileUpload(factory);                               
  upload.setSizeMax(10 * 1024 * 1024);                                                             //최대 파일 크기(10M)
  List<FileItem> items = upload.parseRequest(request);                                             //실제 업로드 부분(이부분에서 파일이 생성된다)
  
  Iterator iter=items.iterator();                                                                            //Iterator 사용
  ArrayList orgFileNames = new ArrayList();
  ArrayList urls = new ArrayList();
  while(iter.hasNext()){
   FileItem fileItem = (FileItem) iter.next();                                                     //파일을 가져온다
   
   if(fileItem.isFormField()){

   } else {
    if(fileItem.getSize()>0){


     String fieldName=fileItem.getFieldName();
     String fileName=fileItem.getName();
     String contentType=fileItem.getContentType();
     boolean isInMemory=fileItem.isInMemory();
     long sizeInBytes=fileItem.getSize();

     fileName = fileName.substring( fileName.lastIndexOf( "\\" ) + 1 );

     int pos = fileName.lastIndexOf( "." );
     String ext = fileName.substring( pos + 1 );

     String newFileName = System.currentTimeMillis() + "."+ext;


	try{
            File uploadedFile=new File(realDir,newFileName);                                                   			  //실제 디렉토리에 fileName으로 카피 된다.
            fileItem.write(uploadedFile);
            fileItem.delete();                                                                                            //카피 완료후 temp폴더의 temp파일을 제거
	}catch(IOException ex) {} 

     orgFileNames.add(fileName);
     urls.add(path+newFileName);

     //out.println(content);

	
	}
   }
  }

    JSONObject obj = new JSONObject();

    obj.put("result", "success");
    obj.put("type", "form_upload_image");
    obj.put("filename", orgFileNames);
    obj.put("url", urls);

    String content = obj.toJSONString();

    out.println(content);


 }
%>