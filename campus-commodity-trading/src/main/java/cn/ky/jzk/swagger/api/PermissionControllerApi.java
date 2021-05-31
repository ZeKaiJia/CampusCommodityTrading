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

    @ApiOperation(value = "根据角色号查询权限", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Permission>> findPermissionByRoleId(@ApiParam String roleId);

    @ApiOperation(value = "创建角色权限链接", notes = "创建多条新的角色与权限链接记录", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "权限代码集合", example = "[\"anon:user:insert\",\"anon:user:update\"]", name = "permissionCodes", required = true, paramType = "query", dataType = "list")
    })
    Response<String> managePermission(@ApiParam String roleId, @ApiParam List<String> permissionCodes);
}
