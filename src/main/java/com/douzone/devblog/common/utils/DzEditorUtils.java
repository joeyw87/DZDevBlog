package com.douzone.devblog.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DzEditorUtils {
	 /** Buffer size */
    public static final int BUFFER_SIZE = 8192;
    public static final String SEPERATOR = File.separator;
	private final static Logger logger = LoggerFactory.getLogger(DzEditorUtils.class);

	 /**
     * Stream으로부터 파일을 저장함.
     * @param is InputStream
     * @param file File
     * @throws IOException
     */
    public static long saveFile(InputStream is, File file) throws IOException {
    	// 디렉토리 생성
    	if (! file.getParentFile().exists()) {
    		file.getParentFile().mkdirs();
    	}

    	OutputStream os = null;
    	long size = 0L;

    	try {
    		os = new FileOutputStream(file);

    		int bytesRead = 0;
    		byte[] buffer = new byte[BUFFER_SIZE];

    		while ((bytesRead = is.read(buffer, 0, BUFFER_SIZE)) != -1) {
    			size += bytesRead;
    			os.write(buffer, 0, bytesRead);
    		}
    	} finally {
    		if (os != null) {
    			os.close();
    		}
    	}

    	return size;
    }
    
    /**
     * 문자 인코딩 체크
     * @param is charLength
     */
    public static boolean charLength(byte[] bytes) {
        int expectedLen;

        for (int i = 0; i < bytes.length; i++) {
            // Lead byte analysis
            if ((bytes[i] & Integer.parseInt("10000000", 2)) == Integer.parseInt("00000000", 2)) {
                continue;
            } else if ((bytes[i] & Integer.parseInt("11100000", 2)) == Integer.parseInt("11000000", 2)) {
                expectedLen = 2;
            } else if ((bytes[i] & Integer.parseInt("11110000", 2)) == Integer.parseInt("11100000", 2)) {
                expectedLen = 3;
            } else if ((bytes[i] & Integer.parseInt("11111000", 2)) == Integer.parseInt("11110000", 2)) {
                expectedLen = 4;
            } else if ((bytes[i] & Integer.parseInt("11111100", 2)) == Integer.parseInt("11111000", 2)) {
                expectedLen = 5;
            } else if ((bytes[i] & Integer.parseInt("11111110", 2)) == Integer.parseInt("11111100", 2)) {
                expectedLen = 6;
            } else {
                return false;
            }

            while (--expectedLen > 0) {
                if (++i >= bytes.length) {
                    return false;
                }
                if ((bytes[i] & Integer.parseInt("11000000", 2)) != Integer.parseInt("10000000", 2)) {
                    return false;
                }
            }
        }
        return true;
    }
    
    public static boolean isEmpty(String str) {
        return str == null || "null".equals(str) || "undefined".equals(str) || str.length() == 0;
    }
    
    public static String today(String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.KOREA);
		return sdf.format(new Date());
	}
    
    public static String getUrlParameter(Map<String,Object> params) {
		StringBuffer sb = new StringBuffer();
		
		if (params != null) {
			Iterator itr = params.entrySet().iterator();
			
			while(itr.hasNext()) {
				String key = String.valueOf(itr.next());
				sb.append(key);
				if(itr.hasNext()) {
					sb.append("&");
				}
			}
			
		}		
		return sb.toString();
		
	}
    
    public static byte[] toByteArray(InputStream stream) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        byte[] buffer = new byte[4096];
        int read = 0;
        while (read != -1) {
            read = stream.read(buffer);
            if (read > 0) {
                baos.write(buffer, 0, read);
            }
        }

        return baos.toByteArray();
    }

}
