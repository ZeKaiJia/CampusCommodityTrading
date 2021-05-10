package cn.ky.jzk.controller;

import cn.hutool.core.codec.Base64;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.ky.jzk.util.GiteeImgBedConstant;
import cn.ky.jzk.vo.Response;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

/**
 * @author kevin
 */
@RestController
@RequestMapping("/gitee")
public class GiteeImgController extends BaseController {
    public final static String MESSAGE_COMMIT = "commit";

    public final static String MESSAGE_STATUS = "status";

    @RequestMapping("saveImg")
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

    @RequestMapping("refreshPage")
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

}
