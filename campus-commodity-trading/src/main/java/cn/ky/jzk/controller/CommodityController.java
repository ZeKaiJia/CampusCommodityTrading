package cn.ky.jzk.controller;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.CommodityService;
import cn.ky.jzk.service.RelationCommodityUserService;
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

    List<Commodity> commodities;

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
        if (!"Success".equals(str)) {
            return getFailResult(404, "不存在销毁商品");
        }
        return getSuccessResult(str);
    }

    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Commodity> update(@RequestBody Commodity commodity) {
        temp = commodityService.update(commodity);
        if (temp == null) {
            return getFailResult(404, "数据错误");
        }
        return getSuccessResult(temp);
    }

    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Commodity>> select() {
        commodities = commodityService.select();
        if (commodities.size() == 0) {
            return getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Commodity> selectById(@RequestParam String comId) {
        temp = commodityService.selectById(comId);
        if (temp == null) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(temp);
    }

    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<List<Commodity>> selectByName(@RequestParam String comName) {
        commodities = commodityService.selectByName(comName);
        if (commodities.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectByPriceBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByPriceBetween(@RequestParam Double min, @RequestParam Double max) {
        commodities =  commodityService.selectByPriceBetween(min, max);
        if (commodities.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectByQuantityNow")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityNow(@RequestParam Integer comQuantityNow) {
        commodities =  commodityService.selectByQuantityNow(comQuantityNow);
        if (commodities.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectByQuantityBetween")
    @ResponseBody
    public Response<List<Commodity>> selectByQuantityBetween(@RequestParam Integer min, @RequestParam Integer max) {
        commodities =  commodityService.selectByQuantityBetween(min, max);
        if (commodities.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectUserCommodity")
    @ResponseBody
    public Response<List<Commodity>> selectUserCommodity(String userName) {
        List<Commodity> res = relationCommodityUserService.selectByName(userName);
        if (res.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(res);
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
        commodities =  commodityService.selectByAnyParam(comId, comName.replace(" ", ""), minPrice, maxPrice, minQuantity, maxQuantity, comDescription);
        if (commodities.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }
}
