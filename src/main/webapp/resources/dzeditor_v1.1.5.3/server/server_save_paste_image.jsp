<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.IOException"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (isMultipart) {
  File temporaryDir = new File("/tmp/");
  String realDir = "/home/neos/tomcat/webapps/dz_editor/dzeditor/server/upload";
                                                                
  DiskFileItemFactory factory = new DiskFileItemFactory();      
  factory.setSizeThreshold(1 * 1024 * 1024);                    
  factory.setRepository(temporaryDir);                          

  ServletFileUpload upload = new ServletFileUpload(factory);                               
  upload.setSizeMax(10 * 1024 * 1024);                          
  List<FileItem> items = upload.parseRequest(request);          
  
  Iterator iter=items.iterator();                               
  while(iter.hasNext()){
   FileItem fileItem = (FileItem) iter.next();                  
   
   if(fileItem.isFormField()){

		String fieldName=fileItem.getFieldName();
	    String content = fileItem.getString("utf-8");

		if(fieldName.equals("dze_upimage_data")) {

			String encContent = content.replaceAll("^data:image/png;base64,","");

			String fileName = System.currentTimeMillis() + ".png";
			String filePath = realDir + "/" + fileName;

			byte[] imageByte;

			BASE64Decoder decoder = new BASE64Decoder();
			imageByte = decoder.decodeBuffer(encContent);

			File of = new File(filePath);
			FileOutputStream osf = new FileOutputStream(of);
			osf.write(imageByte);
			osf.flush();

			String res = "{\"result\":\"success\",\"type\":\"paste_image\",\"filename\":\""+fileName+"\",\"url\":\"/dz_editor/dzeditor/server/upload/"+fileName+"\"}";
			out.println(res);
			break;

		}

   }

  }

 }
%>