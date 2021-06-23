<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");

	try {
		
		String accessUrl = request.getParameter("remoteUrl").trim();
		
		URL url = new URL(accessUrl);
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		int responseCode = con.getResponseCode();
		BufferedReader br;
		if(responseCode==200) {
			br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
		} else { 
			br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"utf-8"));
		}
		String inputLine;
		StringBuffer sb = new StringBuffer();
		while ((inputLine = br.readLine()) != null) {
			sb.append(inputLine);
		}
		br.close();
		
		String content = sb.toString();
		out.println(content);
		
	} catch (Exception e) {
		System.out.println(e);
	}
	
%>