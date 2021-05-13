package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.OrderMapper;
import cn.ky.jzk.model.Order;
import cn.ky.jzk.service.OrderService;
import cn.ky.jzk.util.DateUtil;
import cn.ky.jzk.util.GlobalConstant;
import org.aspectj.weaver.ast.Or;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.unit.DataUnit;

import java.util.List;

/**
 * OrderServiceImpl
 *
 * @author jiazekai 2021年05月13日
 * @version V1.0
 * @modify by user: jiazekai 2021年05月13日 15:17
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;

    private Order temp;

    private List<Order> temps;

    @Override
    public Order insert(@NotNull Order order) {
        if (order.getOrderStatus() == GlobalConstant.CREATE_ORDER_STATUS) {
            order.setOrderCreateTime(DateUtil.currentSecond());
        }
        orderMapper.insert(order);
        return order;
    }

    @Override
    public Order delete(Integer id) {
        temps = orderMapper.selectByAnyParam(id, "", "", "", null);
        if (temps.size() == 0) {
            return null;
        }
        orderMapper.delete(id);
        return temps.get(0);
    }

    @Override
    public Order update(@NotNull Order order) {
        temps = orderMapper.selectByAnyParam(order.getId(), "", "", "", null);
        if (temps.size() == 0) {
            return null;
        }
        if (order.getOrderStatus() == GlobalConstant.CREATE_ORDER_STATUS) {
            order.setOrderCreateTime(DateUtil.currentSecond());
        } else if (order.getOrderStatus() == GlobalConstant.TRANSPORT_ORDER_STATUS) {
            order.setOrderTransportTime(DateUtil.currentSecond());
        } else if (order.getOrderStatus() == GlobalConstant.RECIEVE_ORDER_STATUS) {
            order.setOrderRecieveTime(DateUtil.currentSecond());
        } else {
            return null;
        }
        orderMapper.update(order);
        return order;
    }

    @Override
    public List<Order> select() {
        temps = orderMapper.select();
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public List<Order> selectByAnyParam(Integer id, String orderComId, String orderSalerName, String orderBuyerName, Integer orderStatus) {
        temps = orderMapper.selectByAnyParam(id, orderComId, orderSalerName, orderBuyerName, orderStatus);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }
}
