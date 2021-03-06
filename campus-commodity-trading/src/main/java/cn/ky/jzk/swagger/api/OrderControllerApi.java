package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.MimeTypeUtils;
import io.swagger.annotations.ApiParam;

import java.util.List;

@Api(value = "/order/", tags = "订单模块")
public interface OrderControllerApi {
    @RequiresPermissions("buyer:order:insert")
    @ApiOperation(value = "添加订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Order> insert(Order order);

    @RequiresPermissions("inner:inner:order:delete")
    @ApiOperation(value = "删除订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "订单号", example = "1", name = "id", required = true, paramType = "query", dataType = "integer")
    })
    Response<Order> delete(@ApiParam Integer id);

    @RequiresPermissions("user:order:update")
    @ApiOperation(value = "更新订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Order> update(Order order);

    @RequiresPermissions("admin:order:select")
    @ApiOperation(value = "查询全体订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Order>> select();

    @RequiresPermissions("user:order:selectById")
    @ApiOperation(value = "根据ID号查询订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "订单号", example = "1", name = "id", required = true, paramType = "query", dataType = "integer")
    })
    Response<Order> selectById(@ApiParam Integer id);

    @RequiresPermissions("user:order:selectByAnyParam")
    @ApiOperation(value = "根据指定字段查询订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<List<Order>> selectByAnyParam(Order order);
}
