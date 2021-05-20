package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.MimeTypeUtils;
import io.swagger.annotations.ApiParam;

import java.util.List;

@Api(value = "/order/", tags = "订单模块")
public interface OrderControllerApi {
    @ApiOperation(value = "添加订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Order> insert(Order order);

    @ApiOperation(value = "删除订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "订单号", example = "1", name = "id", required = true, paramType = "query", dataType = "integer")
    })
    Response<Order> delete(@ApiParam Integer id);

    @ApiOperation(value = "更新订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Order> update(Order order);

    @ApiOperation(value = "查询全体订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    Response<List<Order>> select();

    @ApiOperation(value = "根据ID号查询订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "订单号", example = "1", name = "id", required = true, paramType = "query", dataType = "integer")
    })
    Response<Order> selectById(@ApiParam Integer id);

    @ApiOperation(value = "根据指定字段查询订单", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "订单号", example = "1", name = "id", required = false, paramType = "query", dataType = "integer"),
            @ApiImplicitParam(value = "交易商品", example = "SH001", name = "orderComId", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "新商品号", example = "SH100", name = "orderNewId", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "卖家账号", example = "Xb18620208", name = "orderSalerName", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "买家账号", example = "Xb18620230", name = "orderBuyerName", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "买家账号", example = "121224242323", name = "orderTransportCode", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "订单状态(1:已下单2:已发货3:已收货)", example = "1", name = "orderStatus", required = false, paramType = "query", dataType = "integer")
    })
    Response<List<Order>> selectByAnyParam(Order order);
}
