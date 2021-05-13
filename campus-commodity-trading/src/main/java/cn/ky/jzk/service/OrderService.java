package cn.ky.jzk.service;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.model.User;
import org.apache.ibatis.annotations.Param;
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

    List<Order> selectByAnyParam(Integer id, String orderComId, String orderSalerName,
                           String orderBuyerName, Integer orderStatus);
}
