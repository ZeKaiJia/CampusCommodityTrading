package cn.ky.jzk.controller;

import cn.hutool.core.codec.Base64;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.UploadService;
import cn.ky.jzk.service.UserService;
import cn.ky.jzk.swagger.api.UploadControllerApi;
import cn.ky.jzk.util.ExcelUtil;
import cn.ky.jzk.util.GiteeImgBedConstant;
import cn.ky.jzk.vo.Response;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author kevin
 */
@RestController
@RequestMapping("/upload")
public class UploadController extends BaseController implements UploadControllerApi {
    @Autowired
    @Qualifier(value = "uploadServiceImpl")
    private UploadService uploadService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public final static String MESSAGE_COMMIT = "commit";

    public final static String MESSAGE_STATUS = "status";

    @GetMapping("/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
        List<User> users = userService.select();
        String[] title = {"用户名", "密码", "昵称", "性别", "联系电话", "电子邮箱",
                "密保问题", "密保答案", "头像链接"};
        HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook("用户导出表", title, users, null);

        //将文件存到指定位置
        try {
            this.setResponseHeader(response, "用户导出表");
            OutputStream os = response.getOutputStream();
            wb.write(os);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @PostMapping("/importExcel")
    @ResponseBody
    public Response<String> importExcel(@RequestParam("excelFile") MultipartFile multipartFile) {
        String info = uploadService.importExcel(multipartFile);
        return dataAnalyse(info.equals("导入成功") ? info : null, 408, info);
    }

    @Override
    @PostMapping("/saveImg")
    @ResponseBody
    public Response<Map<String, Object>> saveImg(@RequestParam(value = "fileImg", required = true) MultipartFile fileImg) throws Exception {

        Map<String, Object> resultMap = new HashMap<String, Object>();

        String trueFileName = fileImg.getOriginalFilename();

        assert trueFileName != null;
        String suffix = trueFileName.substring(trueFileName.lastIndexOf("."));

        String fileName = System.currentTimeMillis() + suffix;


        String paramImgFile = Base64.encode(fileImg.getBytes());

        //转存到gitee
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("access_token", GiteeImgBedConstant.ACCESS_TOKEN);
        paramMap.put("message", GiteeImgBedConstant.CREATE_REPOS_MESSAGE);
        paramMap.put("content", paramImgFile);

        String targetDir = GiteeImgBedConstant.IMG_FILE_DEST_PATH + fileName;
        String requestUrl = String.format(GiteeImgBedConstant.CREATE_REPOS_URL, GiteeImgBedConstant.OWNER,
                GiteeImgBedConstant.REPO_NAME, targetDir);

        String resultJson = HttpUtil.post(requestUrl, paramMap);

        JSONObject jsonObject = JSONUtil.parseObj(resultJson);
        if (jsonObject.getObj(MESSAGE_COMMIT) != null) {
            String resultImgUrl = GiteeImgBedConstant.GITPAGE_REQUEST_URL + targetDir;
            resultMap.put("resultImgUrl", resultImgUrl);
            return getSuccessResult(resultMap);
        } else {
            return getFailResult(400, resultMap.toString());
        }
    }

    @Override
    @PostMapping("/refreshPage")
    @ResponseBody
    public Response<Map<String, Object>> refreshPage() throws Exception {

        Map<String, Object> paramMap = new HashMap<>(16);
        paramMap.put("access_token", GiteeImgBedConstant.ACCESS_TOKEN);

        String requestUrl = String.format(GiteeImgBedConstant.BUILD_PAGE_URL,
                GiteeImgBedConstant.OWNER, GiteeImgBedConstant.REPO_NAME);

        Map<String, Object> resultMap = new HashMap<>();
        String resultJson = HttpUtil.post(requestUrl, paramMap);

        JSONObject jsonObject = JSONUtil.parseObj(resultJson);
        if (jsonObject.getStr("status") != null) {
            String notice = jsonObject.getStr("notice");
            if (notice != null) {
                if ("Deployed frequently".equalsIgnoreCase(notice)) {
                    resultMap.put("message", "部署频繁");
                } else {
                    resultMap.put("message", "其他错误");
                }
                return getFailResult(400, resultMap.get("message").toString());
            }
        } else {
            return getSuccessResult(resultMap);
        }
        return getSuccessResult(resultMap);
    }

    //发送响应流方法
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
