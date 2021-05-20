package cn.ky.jzk.service;

import cn.ky.jzk.model.Order;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface OrderService {

    Order insert(@NotNull Order order);

    Order delete(Integer id);

    Order update(@NotNull Order order);

    List<Order> select();

    Order selectById(Integer id);

    List<Order> selectByAnyParam(Integer id, String orderComId, String orderNewId, String orderSalerName,
                           String orderBuyerName, String orderTransportCode, Integer orderStatus);
}
