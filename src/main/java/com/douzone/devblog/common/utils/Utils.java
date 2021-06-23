package com.douzone.devblog.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.lang.reflect.Method;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.Map;

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

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 공통으로 사용하는 메소드 집합 클래스
 *
 * @version 1.0
 */
public class Utils {

	private final static Logger logger = LoggerFactory.getLogger(Utils.class);

	/***
	 * String 문자열 ( key, value ) 형태를 Map으로 전환
	 *
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> convertStringToMap(String str) {

		Map<String, Object> returnVal = null;

		try
		{
			returnVal = new ObjectMapper().readValue(str, Map.class);
		}
		catch(Exception e) {

		}

		return returnVal;

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
	
	
	/* 로그인 암호화 디코딩 */
	public static String AESEX_ExpirDecode(String str, String key, int min){
		
		try{			
			str = AES128_Decode(str, key == null || key.equals("") ? "1023497555960596" : key);					
		}catch(Exception ex){
			return "";
		}		
		String authDate = "";	//생성일자 
		String authKey = "";	//인증정보(걔정)
		
		if(str.contains("▦")){			
			//구분자 포함
			String[] keyVal = str.split("▦", -1);			
			authDate = keyVal[0];
			authKey = keyVal[1];
			
		}else if(str.length() > 14) {
			
			authDate = str.substring(0, 14);
			authKey = str.substring(14);
			
		}
		return str;
		//return authKey;
	}	
	
		
	// 복호화
	public static String AES128_Decode(String str, String Key)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		byte[] keyData = Key.getBytes();
		SecretKey secureKey = new SecretKeySpec(keyData, "AES");
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, secureKey,
				new IvParameterSpec(Key.getBytes("UTF-8")));

		byte[] byteStr = Base64.decodeBase64(str.getBytes());

		return new String(c.doFinal(byteStr), "UTF-8");
	}	

}
