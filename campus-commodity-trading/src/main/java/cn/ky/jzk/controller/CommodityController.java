package cn.ky.jzk.controller;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.CommodityService;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.RoleService;
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
    public Response<Commodity> delete(@RequestParam String comId) {
        temp = commodityService.delete(comId);
        if (temp == null) {
            return getFailResult(404, "ID不存在");
        }
        relationCommodityUserService.delete(comId);
        return getSuccessResult(temp);
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
        List<Commodity> commodities = commodityService.select();
        if (commodities.size() == 0) {
            return getFailResult(404, "未找到数据");
        }
        return getSuccessResult(commodities);
    }

    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Commodity> selectById(String comId) {
        temp =  commodityService.selectById(comId);
        if (temp == null) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(temp);
    }

    @GetMapping(value = "/selectUserCommodity")
    @ResponseBody
    public Response<List<Commodity>> selectUserCommodity(String userName) {
        List<Commodity> res = relationCommodityUserService.select(userName);
        if (res.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(res);
    }
}
