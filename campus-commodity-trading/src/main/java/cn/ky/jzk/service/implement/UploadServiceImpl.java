package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.mapper.RoleMapper;
import cn.ky.jzk.mapper.UserMapper;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.UploadService;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * AddressServiceImpl
 *
 * @author jiazekai 2021年05月19日
 * @version V1.0
 * @modify by user: jiazekai 2021年05月19日 16:05
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class UploadServiceImpl extends AbstractService implements UploadService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RelationRoleUserMapper relationRoleUserMapper;

    @Override
    public String importExcel(MultipartFile excelFile) {
        if (excelFile == null || excelFile.getSize() == 0) {
            return "文件上传错误，重新上传";
        }
        String filename = excelFile.getOriginalFilename();
        if (!(filename.endsWith(".xls") || filename.endsWith(".xlsx"))) {
            return "文件上传格式错误，请重新上传";
        }

        List<User> list = null;
        try {
            if (filename.endsWith(".xls")) {
                list = readXLS(excelFile);
            } else {
                list = readXLSX(excelFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "文件内容读取失败，请重试";
        }
        list.forEach(u -> packageInfo(request, u, 1));
        userMapper.importExcel(list);
        return "导入成功";
    }

    @Override
    public List<User> readXLS(MultipartFile file) throws IOException {
        List<User> list = new ArrayList<>();

        InputStream inputStream = file.getInputStream();
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);

        //读取第一张sheet
        HSSFSheet sheet = workbook.getSheetAt(0);
        String errorMsg = "";
        //遍历每一行Excel获取内容
        for (int rowNum = 1; rowNum <= sheet.getLastRowNum(); rowNum++) {
            HSSFRow row = sheet.getRow(rowNum);
            if (row != null) {
                User user = new User();
                Optional.ofNullable(row.getCell(0)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserName(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(1)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserPassword(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(2)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserNick(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(3)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserGender(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(4)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserPhone(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(5)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserEmail(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(6)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserQuest(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(7)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserAnswer(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(8)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserAvatar(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(9)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setCustoma(v.getStringCellValue());
                });
                list.add(user);
            }
        }
        return list;
    }

    @Override
    public List<User> readXLSX(MultipartFile file) throws IOException {
        ArrayList<User> list = new ArrayList<>();

        InputStream inputStream = file.getInputStream();
        XSSFWorkbook Workbook = new XSSFWorkbook(inputStream);

        XSSFSheet sheet = Workbook.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();
        for (int rowNum = 1; rowNum <= lastRowNum; rowNum++) {
            XSSFRow row = sheet.getRow(rowNum);
            if (row != null) {
                User user = new User();
                Optional.ofNullable(row.getCell(0)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserName(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(1)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserPassword(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(2)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserNick(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(3)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserGender(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(4)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserPhone(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(5)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserEmail(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(6)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserQuest(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(7)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserAnswer(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(8)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setUserAvatar(v.getStringCellValue());
                });
                Optional.ofNullable(row.getCell(9)).ifPresent(v -> {
                    v.setCellType(CellType.STRING);
                    user.setCustoma(v.getStringCellValue());
                });
                list.add(user);
            }
        }
        return list;
    }
}
