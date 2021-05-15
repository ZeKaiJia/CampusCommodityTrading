package cn.ky.jzk.controller;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.CommodityService;
import cn.ky.jzk.service.RelationCommodityUserService;
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
public class CommodityController extends BaseController {

    @Autowired
    @Qualifier("commodityServiceImpl")
    private CommodityService commodityService;

    @Autowired
    @Qualifier("relationCommodityUserServiceImpl")
    private RelationCommodityUserService relationCommodityUserService;

    private Commodity temp;

    List<Commodity> temps;

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

    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Commodity> delete(@RequestParam String userName, @RequestParam String comId) {
        temp = commodityService.delete(comId);
        if (temp == null) {
            return getFailResult(404, "ID不存在");
        }
        relationCommodityUserService.deleteSingle(userName, comId);
        return getSuccessResult(temp);
    }

    @PostMapping(value = "/deleteAllZero")
    @ResponseBody
    public Response<String> deleteAllZero(@RequestParam String userName) {
        String str = commodityService.deleteAllZero(userName);
        if (!GlobalConstant.SQL_SUCCESS.equals(str)) {
            return getFailResult(404, "不存在销毁商品");
        }
        return getSuccessResult(str);
    }

    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Commodity> update(@RequestBody Commodity commodity) {
        temp = commodityService.update(commodity);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @PostMapping(value = "/updateRate")
    @ResponseBody
    public Response<Commodity> updateRate(@RequestParam String comId, @RequestParam Double rate) {
        temp = commodityService.updateRate(comId, rate);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Commodity>> select() {
        temps = commodityService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Commodity> selectById(@RequestParam String comId) {
        temp = commodityService.selectById(comId);
        return dataAnalyse(temp, 404, "未找到数据");
    }

    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<List<Commodity>> selectByName(@RequestParam String comName) {
        temps = commodityService.selectByName(comName);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectByPriceBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByPriceBetween(@RequestParam Double min, @RequestParam Double max) {
        temps =  commodityService.selectByPriceBetween(min, max);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectByQuantityNow")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityNow(@RequestParam Integer comQuantityNow) {
        temps =  commodityService.selectByQuantityNow(comQuantityNow);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectByQuantityBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityBetween(@RequestParam Integer min, @RequestParam Integer max) {
        temps =  commodityService.selectByQuantityBetween(min, max);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectUserCommodity")
    @ResponseBody
    public Response<List<Commodity>> selectUserCommodity(String userName) {
        temps = relationCommodityUserService.selectByName(userName);
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @GetMapping(value = "/selectCommodityUser")
    @ResponseBody
    public Response<User> selectCommodityUser(String comId) {
        User res = relationCommodityUserService.selectById(comId);
        if (res == null) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(res);
    }

    @GetMapping(value = "/selectByAnyParam")
    @ResponseBody
    public Response<List<Commodity>> selectByAnyParam(@RequestParam String comId, @RequestParam String comName,
                                                      @RequestParam Double minPrice, @RequestParam Double maxPrice,
                                                      @RequestParam Integer minQuantity, @RequestParam Integer maxQuantity,
                                                      @RequestParam String comDescription) {
        temps =  commodityService.selectByAnyParam(comId, comName.replace(" ", ""), minPrice, maxPrice, minQuantity, maxQuantity, comDescription);
        return dataAnalyse(temps, 404, "未找到数据");
    }
}
