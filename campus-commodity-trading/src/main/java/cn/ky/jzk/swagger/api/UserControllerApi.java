package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.User;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.*;
import org.springframework.util.MimeTypeUtils;

import java.util.List;

@Api(value = "/user/", tags = "用户模块")
public interface UserControllerApi {
    @ApiOperation(value = "添加用户", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "角色中文名", example = "管理员", name = "roleNameCn", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "状态", example = "1", name = "status", required = true, paramType = "query", dataType = "string")
    })
    Response<User> insert(User user, @ApiParam String roleNameCn, @ApiParam Integer status);

    @ApiOperation(value = "删除用户", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<User> delete(@ApiParam String userName);

    @ApiOperation(value = "更新用户信息", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "状态0:普通更新2:忘记密码更新", example = "1", name = "status", required = true, paramType = "query", dataType = "string")
    })
    Response<User> update(User user, @ApiParam String roleNameCn, @ApiParam Integer status);

    @ApiOperation(value = "查询全体用户", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    public Response<List<User>> select();

    @ApiOperation(value = "根据用户名查询用户", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<User> selectByName(@ApiParam String userName);

    @ApiOperation(value = "用户登陆", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<String> login(User user);

    @ApiOperation(value = "用户退出", notes = "退出系统", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<String> userLogout();

    @ApiOperation(value = "强制登录", notes = "后台未登录用户强制登录", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    String toLogin();
}
