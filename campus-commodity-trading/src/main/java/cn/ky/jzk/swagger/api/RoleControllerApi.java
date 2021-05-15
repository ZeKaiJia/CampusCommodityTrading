package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Api(value = "/role/", tags = "角色模块")
public interface RoleControllerApi {
    @ApiOperation(value = "添加角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Role> insert(@RequestBody Role role);

    @ApiOperation(value = "删除角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> delete(@RequestParam String roleId);


    @ApiOperation(value = "更新角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Role> update(@RequestBody Role role);

    @ApiOperation(value = "查询全体角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Role>> select();

    @ApiOperation(value = "根据用户名查询角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> selectUserRole(@RequestParam String userName);

    @ApiOperation(value = "根据角色号查询角色", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色号", example = "1", name = "roleId", required = true, paramType = "query", dataType = "string")
    })
    Response<Role> selectById(@RequestParam String roleId);
}
