package cn.ky.jzk.controller;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.model.Order;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.OrderService;
import cn.ky.jzk.vo.Response;
import org.aspectj.weaver.ast.Or;
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
public class OrderController extends BaseController {

    @Autowired
    @Qualifier("orderServiceImpl")
    private OrderService orderService;

    private Order temp;

    List<Order> temps;

    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<Order> insert(@RequestBody Order order) {
        temp = orderService.insert(order);
        if (temp == null) {
            return getFailResult(404, "ID已存在");
        }
        return getSuccessResult(temp);
    }

    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Order> delete(@RequestParam Integer id) {
        temp = orderService.delete(id);
        if (temp == null) {
            return getFailResult(404, "ID不存在");
        }
        return getSuccessResult(temp);
    }


    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Order> update(@RequestBody Order order) {
        temp = orderService.update(order);
        if (temp == null) {
            return getFailResult(404, "数据错误");
        }
        return getSuccessResult(temp);
    }

    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Order>> select() {
        temps = orderService.select();
        if (temps.size() == 0) {
            return getFailResult(404, "未找到数据");
        }
        return getSuccessResult(temps);
    }

    @GetMapping(value = "/selectByAnyParam")
    @ResponseBody
    public Response<List<Order>> selectByAnyParam(@RequestParam Integer id, @RequestParam String orderComId,
                                                  @RequestParam String orderSalerName, @RequestParam String orderBuyerName,
                                                  @RequestParam Integer orderStatus) {
        temps =  orderService.selectByAnyParam(id, orderComId, orderSalerName, orderBuyerName, orderStatus);
        if (temps.size() == 0) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(temps);
    }
}
