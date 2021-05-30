package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Permission;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.*;
import org.springframework.util.MimeTypeUtils;

import java.util.List;

@Api(value = "/permission/", tags = "权限模块")
public interface PermissionControllerApi {

    @ApiOperation(value = "添加权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Permission> insert(Permission permission);

    @ApiOperation(value = "删除权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Permission> delete(int perId);

    @ApiOperation(value = "更新权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Permission> update(Permission permission);

    @ApiOperation(value = "查询全体权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Permission>> select();

    @ApiOperation(value = "根据ID查询权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "序号", example = "1", name = "perId", required = true, paramType = "query", dataType = "string")
    })
    Response<Permission> selectById(@ApiParam int perId);
}
