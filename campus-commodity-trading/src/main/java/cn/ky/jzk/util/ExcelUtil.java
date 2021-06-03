package cn.ky.jzk.util;

import cn.ky.jzk.model.User;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/6/4 00:08
 */
public class ExcelUtil {
    /**
     * 导出Excel
     *
     * @param sheetName sheet名称
     * @param title     标题
     * @param userList    内容
     * @param wb        HSSFWorkbook对象
     * @return
     */
    public static HSSFWorkbook getHSSFWorkbook(String sheetName, String[] title, List<User> userList, HSSFWorkbook wb) {
        if (wb == null) {
            wb = new HSSFWorkbook();
        }
        HSSFSheet sheet = wb.createSheet(sheetName);
        HSSFRow row = sheet.createRow(0);
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        //声明列对象
        HSSFCell cell = null;
        //创建标题
        for (int i = 0; i < title.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
            cell.setCellStyle(style);
        }
        int i = 1;
        for (User u : userList) {
            row = sheet.createRow(i++);
            row.createCell(0).setCellValue(u.getUserName());
            row.createCell(1).setCellValue(u.getUserPassword());
            row.createCell(2).setCellValue(u.getUserNick());
            row.createCell(3).setCellValue(u.getUserGender());
            row.createCell(4).setCellValue(u.getUserPhone());
            row.createCell(5).setCellValue(u.getUserEmail());
            row.createCell(6).setCellValue(u.getUserQuest());
            row.createCell(7).setCellValue(u.getUserAnswer());
            row.createCell(8).setCellValue(u.getUserAvatar());
        }
        return wb;
    }
}
