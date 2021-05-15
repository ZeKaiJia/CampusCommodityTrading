package cn.ky.jzk.controller;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.service.OrderService;
import cn.ky.jzk.swagger.api.OrderControllerApi;
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
@RequestMapping("/order/")
public class OrderController extends BaseController implements OrderControllerApi {

    @Autowired
    @Qualifier("orderServiceImpl")
    private OrderService orderService;

    private Order temp;

    List<Order> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<Order> insert(@RequestBody Order order) {
        temp = orderService.insert(order);
        return dataAnalyse(temp, 404, "ID已存在");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Order> delete(@RequestParam Integer id) {
        temp = orderService.delete(id);
        return dataAnalyse(temp, 404, "ID不存在");
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Order> update(@RequestBody Order order) {
        temp = orderService.update(order);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Order>> select() {
        temps = orderService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByAnyParam")
    @ResponseBody
    public Response<List<Order>> selectByAnyParam(@RequestParam Integer id, @RequestParam String orderComId,
                                                  @RequestParam String orderNewId, @RequestParam String orderSalerName,
                                                  @RequestParam String orderBuyerName, @RequestParam Integer orderStatus) {
        temps =  orderService.selectByAnyParam(id, orderComId, orderNewId, orderSalerName, orderBuyerName, orderStatus);
        return dataAnalyse(temps, 404, "未找到数据");
    }
}
