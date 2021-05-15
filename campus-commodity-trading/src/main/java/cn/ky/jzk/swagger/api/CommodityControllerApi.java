package cn.ky.jzk.swagger.api;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import cn.ky.jzk.vo.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.MimeTypeUtils;
import io.swagger.annotations.ApiParam;

import java.util.List;

@Api(value = "/commodity/", tags = "商品模块")
public interface CommodityControllerApi {
    @ApiOperation(value = "添加商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> insert(Commodity commodity, @ApiParam String userName);

    @ApiOperation(value = "删除商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> delete(@ApiParam String userName, @ApiParam String comId);

    @ApiOperation(value = "删除用户无存货商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<String> deleteAllZero(@ApiParam String userName);

    @ApiOperation(value = "更新商品信息", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    Response<Commodity> update(Commodity commodity);

    @ApiOperation(value = "更新商品评价", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "POST")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "评价", example = "5", name = "rate", required = true, paramType = "query", dataType = "double")
    })
    Response<Commodity> updateRate(@ApiParam String comId, @ApiParam Double rate);

    @ApiOperation(value = "查询全体商品", notes = "", consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE, httpMethod = "GET")
    Response<List<Commodity>> select();

    @ApiOperation(value = "根据商品号查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<Commodity> selectById(@ApiParam String comId);

    @ApiOperation(value = "根据商品名称查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品名称", example = "扫把", name = "comName", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Commodity>> selectByName(@ApiParam String comName);

    @ApiOperation(value = "根据商品价格包含区间查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "最低价格", example = "0", name = "min", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最高价格", example = "100", name = "max", required = true, paramType = "query", dataType = "double")
    })
    Response<List<Commodity>> selectByPriceBetween(@ApiParam Double min, @ApiParam Double max);

    @ApiOperation(value = "根据商品存货查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "存货", example = "1", name = "comQuantityNow", required = true, paramType = "query", dataType = "integer")
    })
    Response<List<Commodity>> selectByQuantityNow(@ApiParam Integer comQuantityNow);

    @ApiOperation(value = "根据商品存货区间查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "最小存货", example = "0", name = "min", required = true, paramType = "query", dataType = "integer"),
            @ApiImplicitParam(value = "最大存货", example = "0", name = "max", required = true, paramType = "query", dataType = "integer")
    })
    Response<List<Commodity>> selectByQuantityBetween(@ApiParam Integer min, @ApiParam Integer max);

    @ApiOperation(value = "根据用户名查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "用户名", example = "Xb18620208", name = "userName", required = true, paramType = "query", dataType = "string")
    })
    Response<List<Commodity>> selectUserCommodity(String userName);

    @ApiOperation(value = "根据商铺号查询用户", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = true, paramType = "query", dataType = "string")
    })
    Response<User> selectCommodityUser(String comId);

    @ApiOperation(value = "根据指定字段查询商品", notes = "",  consumes = MimeTypeUtils.APPLICATION_JSON_VALUE, produces = MimeTypeUtils.APPLICATION_JSON_VALUE,  httpMethod = "GET")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "商品号", example = "SH001", name = "comId", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "商品名称", example = "扫把", name = "comName", required = false, paramType = "query", dataType = "string"),
            @ApiImplicitParam(value = "最小价格", example = "0", name = "minPrice", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最大价格", example = "100", name = "maxPrice", required = true, paramType = "query", dataType = "double"),
            @ApiImplicitParam(value = "最小存货", example = "0", name = "minQuantity", required = true, paramType = "query", dataType = "integer"),
            @ApiImplicitParam(value = "最大存货", example = "1", name = "maxQuantity", required = true, paramType = "query", dataType = "integer"),
            @ApiImplicitParam(value = "商品描述", example = "扫把", name = "comDescription", required = false, paramType = "query", dataType = "string")
    })
    Response<List<Commodity>> selectByAnyParam(@ApiParam String comId, @ApiParam String comName,
                                               @ApiParam Double minPrice, @ApiParam Double maxPrice,
                                               @ApiParam Integer minQuantity, @ApiParam Integer maxQuantity,
                                               @ApiParam String comDescription);
}
