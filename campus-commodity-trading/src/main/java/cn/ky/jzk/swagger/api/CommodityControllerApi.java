package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.MimeTypeUtils;

import java.util.List;

@Api(value = "/commodity/", tags = "商品模块")
public interface CommodityControllerApi {
    @RequiresPermissions("saler:commodity:insert")
    @ApiOperation(value = "添加商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> insert(Commodity commodity, @ApiParam String userName);

    @RequiresPermissions("saler:commodity:delete")
    @ApiOperation(value = "删除商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> delete(@ApiParam String userName, @ApiParam String comId);

    @RequiresPermissions("saler:commodity:deleteAllZero")
    @ApiOperation(value = "删除用户无存货商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<String> deleteAllZero(@ApiParam String userName);

    @RequiresPermissions("user:commodity:update")
    @ApiOperation(value = "更新商品信息", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Commodity> update(Commodity commodity);

    @RequiresPermissions("buyer:commodity:updateRate")
    @ApiOperation(value = "更新商品评价", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "评价", example = "5", name = "rate", required = true, paramType = "query", dataType = "double")
    })
    Response<Commodity> updateRate(@ApiParam String comId, @ApiParam Double rate);

    @RequiresPermissions("buyer:commodity:select")
    @ApiOperation(value = "查询全体商品", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE, httpMethod = "GET")
    Response<List<Commodity>> select();

    @RequiresPermissions("user:commodity:selectById")
    @ApiOperation(value = "根据商品号查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> selectById(@ApiParam String comId);

    @RequiresPermissions("user:commodity:selectByName")
    @ApiOperation(value = "根据商品名称查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品名称", example = "扫把", name = "comName", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Commodity>> selectByName(@ApiParam String comName);

    @RequiresPermissions("buyer:commodity:selectByPriceBetween")
    @ApiOperation(value = "根据商品价格包含区间查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "最低价格", example = "0", name = "min", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最高价格", example = "100", name = "max", required = true, paramType = "query", dataType = "double")
    })
    Response<List<Commodity>> selectByPriceBetween(@ApiParam Double min, @ApiParam Double max);

    @RequiresPermissions("buyer:commodity:selectByQuantityNow")
    @ApiOperation(value = "根据商品存货查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "存货", example = "1", name = "comQuantityNow", required = true, paramType = "query", dataType = "integer")
    })
    Response<List<Commodity>> selectByQuantityNow(@ApiParam Integer comQuantityNow);

    @RequiresPermissions("buyer:commodity:selectByQuantityBetween")
    @ApiOperation(value = "根据商品存货区间查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "最小存货", example = "0", name = "min", required = true, paramType = "query", dataType = "integer"),
            @ApiImplicitParam(value = "最大存货", example = "0", name = "max", required = true, paramType = "query", dataType = "integer")
    })
    Response<List<Commodity>> selectByQuantityBetween(@ApiParam Integer min, @ApiParam Integer max);

    @RequiresPermissions("user:commodity:selectUserCommodity")
    @ApiOperation(value = "根据用户名查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Commodity>> selectUserCommodity(@ApiParam String userName);

    @RequiresPermissions("buyer:commodity:selectCommodityUser")
    @ApiOperation(value = "根据商品号查询用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<User> selectCommodityUser(@ApiParam String comId);

    @RequiresPermissions("user:commodity:selectByAnyParam")
    @ApiOperation(value = "根据指定字段查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "最小价格", example = "0", name = "minPrice", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最大价格", example = "100", name = "maxPrice", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最小存货", example = "0", name = "minQuantity", required = true, paramType = "query", dataType = "int"),
            @ApiImplicitParam(value = "最大存货", example = "1", name = "maxQuantity", required = true, paramType = "query", dataType = "int"),
    })
    Response<List<Commodity>> selectByAnyParam(Commodity commodity, @ApiParam Integer minQuantity,
                                               @ApiParam Integer maxQuantity, @ApiParam Double minPrice,
                                               @ApiParam Double maxPrice);
}
