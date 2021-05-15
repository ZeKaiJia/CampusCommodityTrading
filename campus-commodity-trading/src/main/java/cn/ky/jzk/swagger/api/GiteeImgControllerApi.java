package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Api(value = "/order/", tags = "订单模块")
public interface GiteeImgControllerApi {
    @ApiOperation(value = "上传文件", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "文件", example = "无示例", name = "fileImg", required = true, paramType = "query", dataType = "multipartFile")
    })
    Response<Map<String, Object>> saveImg(@RequestParam(value = "fileImg", required = true) MultipartFile fileImg) throws Exception;


    @ApiOperation(value = "刷新Gitee Page", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Map<String, Object>> refreshPage() throws Exception;
}
