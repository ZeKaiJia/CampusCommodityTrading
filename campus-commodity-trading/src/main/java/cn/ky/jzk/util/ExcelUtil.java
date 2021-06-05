package cn.ky.jzk.util;

import cn.ky.jzk.model.User;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;

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
        // 设置居中
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        // 设置字体
        HSSFFont font = wb.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 14);
        style.setFont(font);
        //声明列对象
        HSSFCell cell = null;
        /*sheet.setDefaultColumnWidth(256 * 256);*/
        sheet.setDefaultRowHeightInPoints(50);
        //创建标题
        for (int i = 0; i < title.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
            cell.setCellStyle(style);
        }
        int i = 1;
        for (User u : userList) {
            row = sheet.createRow(i++);
            Cell cell1 = row.createCell(0);
            cell1.setCellValue(u.getUserName());
            cell1.setCellStyle(style);
            Cell cell2 = row.createCell(1);
            cell2.setCellValue(u.getUserPassword());
            cell2.setCellStyle(style);
            Cell cell3 = row.createCell(2);
            cell3.setCellValue(u.getUserNick());
            cell3.setCellStyle(style);
            Cell cell4 = row.createCell(3);
            cell4.setCellValue(u.getUserGender());
            cell4.setCellStyle(style);
            Cell cell5 = row.createCell(4);
            cell5.setCellValue(u.getUserPhone());
            cell5.setCellStyle(style);
            Cell cell6 = row.createCell(5);
            cell6.setCellValue(u.getUserEmail());
            cell6.setCellStyle(style);
            Cell cell7 = row.createCell(6);
            cell7.setCellValue(u.getUserQuest());
            cell7.setCellStyle(style);
            Cell cell8 = row.createCell(7);
            cell8.setCellValue(u.getUserAnswer());
            cell8.setCellStyle(style);
            Cell cell9 = row.createCell(8);
            cell9.setCellValue(u.getUserAvatar());
            cell9.setCellStyle(style);
        }
        for (i = 0; i < title.length; i++) {
            sheet.autoSizeColumn((short)(i));
        }
        return wb;
    }
}
