package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Address;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.*;
import org.springframework.util.MimeTypeUtils;

import java.util.List;

@Api(value = "/address/", tags = "地址模块")
public interface AddressControllerApi {
    @ApiOperation(value = "添加地址", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<String> insert(Address address);

    @ApiOperation(value = "删除地址", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "序号", example = "1", name = "id", required = true, paramType = "query", dataType = "integer")
    })
    Response<String> delete(@ApiParam Integer id);


    @ApiOperation(value = "更新地址", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<String> update(Address address);

    @ApiOperation(value = "查询全部地址", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Address>> select();

    @ApiOperation(value = "根据用户名查询地址", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Address>> selectByName(@ApiParam String userName);
}
