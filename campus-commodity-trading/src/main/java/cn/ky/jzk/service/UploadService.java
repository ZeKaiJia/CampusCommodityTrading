package cn.ky.jzk.service;

import cn.ky.jzk.model.User;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface UploadService {

    String importExcel(MultipartFile excelFile);

    List<User> readXLS(MultipartFile file) throws IOException;

    public List<User> readXLSX(MultipartFile file) throws IOException;
}
