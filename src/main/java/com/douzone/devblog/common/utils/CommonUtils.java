package com.douzone.devblog.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;

public class CommonUtils {
	private final static Logger logger = LoggerFactory.getLogger(CommonUtils.class);

	public static Map<String, Object> convertObjectToMap(Object obj){
        Map<String, Object> map = new HashMap<String, Object>();
        Field[] fields = obj.getClass().getDeclaredFields();
        for(int i=0; i <fields.length; i++){
            fields[i].setAccessible(true);
            try{
                map.put(fields[i].getName(), fields[i].get(obj));
            }catch(Exception e){
            	logger.error("convertObjectToMap error : " + e);
            }
        }        
        return map;
    }
    
	
    /**
	 * UUID String을 만들어 리턴한다. 
	 * @return String으로 변환된 UUID
	 */
	public static String makeUUID2String() {
		return UUID.randomUUID().toString();
	}
	
	/**
	 * Null인 경우 공백을 리턴한다.
	 * @param str
	 * @return
	 */
	public static String checkNull(String str){
		if(str == null || "null".equals(str) || "Null".equals(str) || str.length( ) == 0){
			return "";
		}else{
			return str;
		}
	}	
	
	/**
	 * SimpleDateFormat을 맞춰서 리턴해주는 메서드
	 * @param optInt getNowTime 메서드에서 사용할 옵션 값 (1~6)
	 * @param sendFormatStr 6번 옵션 시 커스텀 값
	 * @return 변환된 SimpleDateFormat 객체
	 */
	public static SimpleDateFormat getCustomSimpleDateFormat(int optInt, String sendFormatStr) {
		SimpleDateFormat format = null;
		switch (optInt) {
		case 1: { format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EEE"); }break; //Full Date
		case 2: { format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); }break; //Full Date
		case 3: { format = new SimpleDateFormat("yyyy-MM-dd"); }break; //Y-M-D
		case 4: { format = new SimpleDateFormat("yyyy-MM-dd-EEE"); }break; //Y-M-D-E
		case 5: { format = new SimpleDateFormat("HH:mm:ss"); }break; //H:m:S
		case 6: { format = new SimpleDateFormat(sendFormatStr); }break; //Custom
		default: break;
		}
		return format;
	}
	
	/**
	 * 전달받은 Date 객체를 알맞는 Format으로 변환 후 String 으로 리턴
	 * @param date 변환할 Date 객체 
	 * @param optInt 사용할 옵션 값 (1~6)
	 * @param sendFormatStr 6번 옵션 시 커스텀 값
	 * @return 변환된 String 날짜 값
	 */
	public static String getDateObj2String(Date date, int optInt, String sendFormatStr) {
		SimpleDateFormat format = getCustomSimpleDateFormat(optInt, sendFormatStr);
		return format.format(date);
	}
	
	/**
	 * 에러시 printStackTrace 객체를 문자열로 변환
	 * 
	 * @param e
	 * @return
	 */
	public static String makeStackTrace(Throwable e){
		if(e == null) return "";
		try{
			ByteArrayOutputStream bout = new ByteArrayOutputStream();
			e.printStackTrace(new PrintStream(bout));
			bout.flush();
			String error = new String(bout.toByteArray());
			
			return error;
		}catch(Exception ex){
			return "";
		}
	}
	
	/**
	 * @param date : String으로 반환할  날짜
	 * @param format : String으로 변환할 format
	 * @code CommonUtil.date(sdate, "yyyyMMdd");
	 * @return String
	 * @see Date를 format 에 맞는 String으로 변환
	 * @author 조영욱
	 * 
	 */		
	public static String date(Date date, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	@SuppressWarnings("rawtypes")
	public static Object convertMapToObject(Map<String,Object> map, Object obj){
		String keyAttribute = null;
        String setMethodString = "set";
        String methodString = null;
		Iterator itr = map.keySet().iterator();

        while(itr.hasNext()){
            keyAttribute = (String) itr.next();
            methodString = setMethodString+keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
            Method[] methods = obj.getClass().getDeclaredMethods();
            for(int i=0;i<methods.length;i++){
                if(methodString.equals(methods[i].getName())){
                    try{
                        methods[i].invoke(obj, map.get(keyAttribute));
                    }catch(Exception e){
                        //e.printStackTrace();
                    }
                }
            }
        }
        return obj;
	}
	
	
	/**
	 * 개인정보 파라미터 암호화 - 외부시스템 전자결재 SSO API
	 * @param str: 문자열
	 * @return 변환된 String 날짜 값
	 */
	public static String AES128_Encode(String str)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		
		String Key = "1023497555960596"; //디폴트 암호화 키
		
		byte[] keyData = Key.getBytes();
		SecretKey secureKey = new SecretKeySpec(keyData, "AES");
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(Key.getBytes()));
		byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
		String enStr = new String(Base64.encodeBase64(encrypted));
		return enStr;
	}
	
	// SSOKEY 외부연동 SSO처리용 암호화 AES128
	public static String AES128EX_Encode(String str, String Key)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {

	  byte[] crypted = null;
	  try{
	    SecretKeySpec skey = new SecretKeySpec(Key.getBytes(), "AES");
	      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	      cipher.init(Cipher.ENCRYPT_MODE, skey);
	      crypted = cipher.doFinal(str.getBytes());
	    }catch(Exception e){
			System.out.println(e.toString());
	    }

	    return new String(Base64.encodeBase64(crypted));
	}
	
	/* Map to JSON */
	public static JSONObject convertMapToJson(Map<String, Object> map) throws Exception {
		JSONObject jsonObject = new JSONObject();
		for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
        }

		return jsonObject;
	}

}
