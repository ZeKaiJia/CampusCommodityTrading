package cn.ky.jzk.swagger.api;

import cn.ky.jzk.vo.Response;
import io.swagger.annotations.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Api(value = "/upload/", tags = "外部模块")
public interface UploadControllerApi {
    @RequiresPermissions("admin:upload:saveImg")
    @ApiOperation(value = "上传文件", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "文件", example = "无示例", name = "fileImg", required = true, paramType = "query", dataType = "multipartFile")
    })
    Response<Map<String, Object>> saveImg(@ApiParam(value = "fileImg", required = true) MultipartFile fileImg) throws Exception;

    @RequiresPermissions("admin:upload:refreshPage")
    @ApiOperation(value = "刷新Gitee Page", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Map<String, Object>> refreshPage() throws Exception;

    @RequiresPermissions("user:upload:import")
    @ApiOperation(value = "导入表格", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "文件", example = "无示例", name = "fileImg", required = true, paramType = "query", dataType = "multipartFile")
    })
    Response<String> importExcel(@RequestParam("excelFile") MultipartFile multipartFile);

    @RequiresPermissions("user:upload:export")
    @ApiOperation(value = "导出表格", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    void exportExcel(HttpServletRequest request, HttpServletResponse response);
}
