package cn.ky.jzk.controller;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.CommodityService;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.swagger.api.CommodityControllerApi;
import cn.ky.jzk.util.GlobalConstant;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin
@RestController()
@RequestMapping("/commodity/")
public class CommodityController extends BaseController implements CommodityControllerApi {

    @Autowired
    @Qualifier("commodityServiceImpl")
    private CommodityService commodityService;

    @Autowired
    @Qualifier("relationCommodityUserServiceImpl")
    private RelationCommodityUserService relationCommodityUserService;

    private Commodity temp;

    List<Commodity> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<Commodity> insert(@RequestBody Commodity commodity, @RequestParam String userName) {
        temp = commodityService.insert(commodity);
        if (temp == null) {
            return getFailResult(404, "ID已存在");
        }
        relationCommodityUserService.insert(userName, commodity.getComId());
        return getSuccessResult(temp);
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Commodity> delete(@RequestParam String userName, @RequestParam String comId) {
        temp = commodityService.delete(comId);
        if (temp == null) {
            return getFailResult(404, "ID不存在");
        }
        return getSuccessResult(temp);
    }

    @Override
    @PostMapping(value = "/deleteAllZero")
    @ResponseBody
    public Response<String> deleteAllZero(@RequestParam String userName) {
        String str = commodityService.deleteAllZero(userName);
        if (!GlobalConstant.SQL_SUCCESS.equals(str)) {
            return getFailResult(404, "不存在销毁商品");
        }
        return getSuccessResult(str);
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Commodity> update(@RequestBody Commodity commodity) {
        temp = commodityService.update(commodity);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @PostMapping(value = "/updateRate")
    @ResponseBody
    public Response<Commodity> updateRate(@RequestParam String comId, @RequestParam Double rate) {
        temp = commodityService.updateRate(comId, rate);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Commodity>> select() {
        temps = commodityService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Commodity> selectById(@RequestParam String comId) {
        temp = commodityService.selectById(comId);
        return dataAnalyse(temp, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<List<Commodity>> selectByName(@RequestParam String comName) {
        temps = commodityService.selectByName(comName);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByPriceBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByPriceBetween(@RequestParam Double min, @RequestParam Double max) {
        temps =  commodityService.selectByPriceBetween(min, max);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByQuantityNow")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityNow(@RequestParam Integer comQuantityNow) {
        temps =  commodityService.selectByQuantityNow(comQuantityNow);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByQuantityBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityBetween(@RequestParam Integer min, @RequestParam Integer max) {
        temps =  commodityService.selectByQuantityBetween(min, max);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectUserCommodity")
    @ResponseBody
    public Response<List<Commodity>> selectUserCommodity(String userName) {
        temps = relationCommodityUserService.selectByName(userName);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectCommodityUser")
    @ResponseBody
    public Response<User> selectCommodityUser(String comId) {
        User res = relationCommodityUserService.selectById(comId);
        if (res == null) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(res);
    }

    @Override
    @PostMapping(value = "/selectByAnyParam")
    @ResponseBody
    public Response<List<Commodity>> selectByAnyParam(@RequestBody Commodity commodity, @RequestParam Integer minQuantity,
                                                      @RequestParam Integer maxQuantity, @RequestParam Double minPrice,
                                                      @RequestParam Double maxPrice) {
        temps =  commodityService.selectByAnyParam(commodity, minQuantity, maxQuantity, minPrice, maxPrice);
        return dataAnalyse(temps, 404, "未找到数据");
    }
}
