package com.douzone.devblog.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;

/**
 * Http 관련 Util 클래스
 * Singleton 패턴으로 만들어 짐
 *     HttpUtils httpUtils = HttpUtils.getInstance();
 *
 * @version 1.0
 */
public class HttpUtils {

	private volatile static HttpUtils singleton;
	private final Logger logger = LoggerFactory.getLogger(HttpUtils.class);

	private HttpUtils() {}

	public static HttpUtils getInstance() {
		if(singleton == null) {
			synchronized (HttpUtils.class) {
				if(singleton == null) {
					singleton = new HttpUtils();
				}
			}
		}
		return singleton;
	}

	/**
	 * POST 방식이며, JSON 형태로 데이터 전달하는 메소드
	 *
	 * @param url
	 * @param body
	 * @return String ( response 로 받은 데이터를 String 형태로 전환 )
	 * @exception Exception
	 */
	public String SendPostMethodByJson(String url, JSONObject body) {

		String result = "";
		HttpURLConnection connection = null;

		try
		{
			connection = openConnectionHttp(url);
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-Type", "application/json");
			connection.connect();

			final OutputStream out = connection.getOutputStream();
			out.write(body.toString().getBytes());
			out.flush();
			out.close();

			int statusCode = connection.getResponseCode();
			if(statusCode / 100 == 2) {
				result = readInputStream(connection.getInputStream());
			}
			logger.debug("statusCode :: " + statusCode);
		}
		catch(Exception e) {
			logger.error(Utils.makeStackTrace(e));
		}
		finally {
			if(connection != null) {
				connection.disconnect();
			}
		}

		return result;

	}

	/**
	 * POST 방식이며, application/x-www-form-urlencoded 형태로 데이터 전달하는 메소드
	 *
	 * @param url
	 * @param params
	 * @return String ( response 로 받은 데이터를 String 형태로 전환 )
	 * @exception Exception
	 */
	public String SendPostMethodByForm(String url, Map<String, String> params) {

		String result = "";
		HttpURLConnection connection = null;

		try
		{
			connection = openConnection(url);
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.connect();

			final OutputStream out = connection.getOutputStream();
			out.write(formEncode(params).getBytes());
			out.flush();
			out.close();

			int statusCode = connection.getResponseCode();
			result = readInputStream(connection.getInputStream());

//			if(statusCode / 100 == 2) {
//			}

			logger.debug("statusCode :: " + statusCode);
		}
		catch(Exception e) {
			logger.error(Utils.makeStackTrace(e));
		}
		finally {
			if(connection != null) {
				connection.disconnect();
			}
		}

		return result;

	}

	/**
	 * GET 방식
	 * 현재 미구현 ( ver 1.0 )
	 */
	private String SendGetMethod() {

		String result = "";

		//connection = openConnection(url.concat("?").concat(formEncode(parameters)));
		//connection.setRequestMethod("GET");
		//connection.connect();

		return result;

	}
	
	/**
	 * Not Auth
	 * @param url
	 * @return
	 * @throws IOException
	 */
	private static HttpsURLConnection openConnection(final String url) throws IOException {
		final HttpsURLConnection connection = (HttpsURLConnection) new URL(url).openConnection();
		connection.setInstanceFollowRedirects(true);
		connection.setRequestProperty("User-Agent", "Cust");
		connection.setRequestProperty("Accept", "application/xhtml+xml,application/xml,text/xml;q=0.9,*/*;q=0.8");
		connection.setRequestProperty("Accept-Language", "en-us,ko-kr;q=0.7,en;q=0.3");
		connection.setRequestProperty("Accept-Encoding", "deflate");
		connection.setRequestProperty("Accept-Charset", "utf-8");
		connection.setRequestProperty("Authorization", "No");
		return connection;
	}	
	
	private HttpURLConnection openConnectionHttp(final String url) throws IOException {

		final HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();

		connection.setInstanceFollowRedirects(true);
		connection.setRequestProperty("User-Agent", "Cust");
		connection.setRequestProperty("Accept", "application/xhtml+xml,application/xml,text/xml;q=0.9,*/*;q=0.8");
		connection.setRequestProperty("Accept-Language", "en-us,ko-kr;q=0.7,en;q=0.3");
		connection.setRequestProperty("Accept-Encoding", "deflate");
		connection.setRequestProperty("Accept-Charset", "utf-8");
		connection.setRequestProperty("Authorization", "No");

		return connection;
	}

	private static String readInputStream(InputStream is) throws IOException{
		StringBuilder sb = new StringBuilder();
		BufferedReader in = new BufferedReader(new InputStreamReader(is,"utf-8"));
		String inputLine;
		while ((inputLine = in.readLine()) != null){
			sb.append(inputLine);
		}
		return sb.toString();
	}

	/**
	 * for GET request url encoder
	 * @param parameters
	 * @return
	 */
	public static String formEncode(final Map<String, String> parameters) {
		final StringBuilder builder = new StringBuilder();
		boolean isFirst = true;
		for (final Map.Entry<String, String> parameter : parameters.entrySet()) {
			if (isFirst) isFirst = false;
			else builder.append("&");
			final String key = parameter.getKey();
			if (key == null) continue;
			builder.append(urlEncode(key));
			builder.append("=");
			builder.append(urlEncode(parameter.getValue()));
		}

		return builder.toString();
	}

	private static String urlEncode(final String s) {
		if (s == null) return "";
		try {
			return URLEncoder.encode(s.trim(), "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~");
		} catch (final UnsupportedEncodingException e) {
			// ignore.
		}
		return "";
	}
	
	
	
	/**
	 * request and response
	 * @param method : POST/GET
	 * @param url
	 * @param parameters
	 * @return
	 */
	public static String execute(String method, final String url, final Map<String, String> parameters) {
		HttpsURLConnection connection = null;
		String result ="";
		int methodCase = 0;
		if(method.toUpperCase().equals("POST")) methodCase = 1;
		try {
			switch (methodCase) {
				case 0:
					connection = openConnection(url.concat("?").concat(formEncode(parameters)));
					connection.setRequestMethod("GET");
					connection.connect();
					break;
				case 1:
					connection = openConnection(url);
					connection.setRequestMethod("POST");
					connection.setDoOutput(true);
					connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
					connection.connect();
					final OutputStream out = connection.getOutputStream();
					out.write(formEncode(parameters).getBytes());
					out.flush();
					out.close();
					break;
			}
			final int statusCode = connection.getResponseCode();
			if (statusCode / 100 != 2) {
				// 400, 401, 501
				result = "{\"error\":"+statusCode+"}";
			}else{
				result = readInputStream(connection.getInputStream());
			}
		} catch (IOException e) {
			return result;
		} finally {
			if (connection != null) connection.disconnect();
		}
		return result;
	}
	
	
	/**
	 * GET 방식
	 *
	 * @param url
	 * @return String ( response 로 받은 데이터를 String 형태로 전환 )
	 * @exception Exception
	 */
	public String SendGetMethodSession(String url, String sessionId) {

		String result = "";
		HttpURLConnection connection = null;

		try
		{
			connection = openConnectionHttp(url);
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Cookie", "JSESSIONID=" + sessionId + ", bizboxa=" + sessionId);
			connection.connect();

			int statusCode = connection.getResponseCode();
			if(statusCode / 100 == 2) {
				result = readInputStream(connection.getInputStream());
			}

			logger.debug("statusCode :: " + statusCode);

		}
		catch(Exception e) {
			logger.error(Utils.makeStackTrace(e));
		}
		finally {
			if(connection != null) {
				connection.disconnect();
			}
		}

		return result;

	}
	

}
