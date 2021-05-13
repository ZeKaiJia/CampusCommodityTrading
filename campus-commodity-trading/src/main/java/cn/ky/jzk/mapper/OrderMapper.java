package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Order;
import cn.ky.jzk.model.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface OrderMapper {

    void insert(Order order);

    void delete(@Param("id") Integer id);

    void update(Order order);

    List<Order> select();

    List<Order> selectByAnyParam(@Param("id") Integer id, @Param("orderComId") String orderComId,
                                 @Param("orderSalerName") String orderSalerName,
                                 @Param("orderBuyerName") String orderBuyerName,
                                 @Param("orderStatus") Integer orderStatus);
}
