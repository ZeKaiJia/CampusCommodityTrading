package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Role;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.MimeTypeUtils;
import io.swagger.annotations.ApiParam;

import java.util.List;

@Api(value = "/role/", tags = "角色模块")
public interface RoleControllerApi {
    @RequiresPermissions("admin:role:insert")
    @ApiOperation(value = "添加角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Role> insert(Role role);

    @RequiresPermissions("admin:role:delete")
    @ApiOperation(value = "删除角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> delete(@ApiParam String roleId);

    @RequiresPermissions("admin:role:update")
    @ApiOperation(value = "更新角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Role> update(Role role);

    @ApiOperation(value = "查询全体角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Role>> select();

    @ApiOperation(value = "根据用户名查询角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> selectUserRole(@ApiParam String userName);
    
    @ApiOperation(value = "根据角色号查询角色", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> selectById(@ApiParam String roleId);
}
