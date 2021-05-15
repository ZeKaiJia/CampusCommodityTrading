package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Commodity;
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

@Api(value = "/user/", tags = "用户模块")
public interface UserControllerApi {
    @ApiOperation(value = "添加用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色中文名", example = "管理员", name = "roleNameCn", required = true, paramType = "query", dataType = "string")
    })
    Response<User> insert(@RequestBody User user, @RequestParam String roleNameCn);

    @ApiOperation(value = "删除用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<User> delete(@RequestParam String userName);

    @ApiOperation(value = "更新用户信息", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<User> update(@RequestBody User user, @RequestParam String roleNameCn);

    @ApiOperation(value = "查询全体用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    public Response<List<User>> select();

    @ApiOperation(value = "根据用户名查询用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<User> selectByName(@RequestParam String userName);

    @ApiOperation(value = "用户登陆", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<User> login(@RequestBody User user);
}
