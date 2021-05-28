package cn.ky.jzk.service;

import cn.ky.jzk.model.Order;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface OrderService {

    Order insert(@NotNull Order order) throws IOException, SQLException, ClassCastException ;

    Order delete(Integer id);

    Order update(@NotNull Order order);

    List<Order> select();

    Order selectById(Integer id);

    List<Order> selectByAnyParam(Order order);
}
