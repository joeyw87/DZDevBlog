package com.douzone.devblog.common.utils;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 엑셀다운로드
 */
public class ExcelDownloadUtils extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Locale locale = (Locale) model.get("locale");
		String workbookName = (String) model.get("workbookName");
		
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", locale);
		SimpleDateFormat dhf = new SimpleDateFormat("hhmmss", locale);
		
		String day = df.format(date);
		String hour = dhf.format(date);
		String filename = workbookName + "_" + day + "_" + hour + ".xlsx";
		
		String browser = request.getHeader("User-Agent");
		
		if (browser.indexOf("MSIE") > -1) {
            filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Trident") > -1) {       // IE11
            filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Firefox") > -1) {
            filename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Opera") > -1) {
            filename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Chrome") > -1) {
            StringBuffer sb = new StringBuffer();
            
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);

				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}

                filename = sb.toString();
        } else if (browser.indexOf("Safari") > -1) {
            filename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1")+ "\"";
        } else {
             filename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1")+ "\"";
        }
		
		response.setContentType("application/download; charset=utf-8");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream os = null;
		SXSSFWorkbook workbook = null;
		
		try {
			workbook = (SXSSFWorkbook) model.get("workbook");
			os = response.getOutputStream();
			
			workbook.write(os);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (workbook != null) {
				workbook.close();
			}
			
			if (os != null) {
				os.close();
			}
		}
		
	}
	

}
