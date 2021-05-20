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
        return dataAnalyse(orderService.insert(order), 404, "ID已存在");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Order> delete(@RequestParam Integer id) {
        return dataAnalyse(orderService.delete(id), 404, "ID不存在");
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Order> update(@RequestBody Order order) {
        return dataAnalyse(orderService.update(order), 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Order>> select() {
        return dataAnalyse(orderService.select(), 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Order> selectById(@RequestParam Integer id) {
        return dataAnalyse(orderService.selectById(id), 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByAnyParam")
    @ResponseBody
    public Response<List<Order>> selectByAnyParam(@RequestParam Integer id, @RequestParam String orderComId,
                                                  @RequestParam String orderNewId, @RequestParam String orderSalerName,
                                                  @RequestParam String orderBuyerName, @RequestParam String orderTransportCode,
                                                  @RequestParam Integer orderStatus) {
        return dataAnalyse(orderService.selectByAnyParam(id, orderComId, orderNewId, orderSalerName,
                orderBuyerName, orderTransportCode, orderStatus), 404, "未找到数据");
    }
}
