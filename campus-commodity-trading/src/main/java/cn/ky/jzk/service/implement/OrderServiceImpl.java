package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.OrderMapper;
import cn.ky.jzk.model.Order;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.OrderService;
import cn.ky.jzk.util.DateUtil;
import cn.ky.jzk.util.GlobalConstant;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
public class OrderServiceImpl extends AbstractService implements OrderService {
    @Autowired
    OrderMapper orderMapper;

    private Order temp;

    private List<Order> temps;

    @Override
    public Order insert(@NotNull Order order) {
        if (order.getOrderStatus().equals(GlobalConstant.CREATE_ORDER_STATUS)) {
            order.setOrderCreateTime(DateUtil.currentSecond());
        }
        orderMapper.insert(packageInfo(request, order, 1));
        return order;
    }

    @Override
    public Order delete(Integer id) {
        temp = orderMapper.selectById(id);
        if (temp == null) {
            return null;
        }
        orderMapper.delete(id);
        return temp;
    }

    @Override
    public Order update(@NotNull Order order) {
        temp = orderMapper.selectById(order.getId());
        if (temp == null) {
            return null;
        }
        if (order.getOrderStatus() == GlobalConstant.CREATE_ORDER_STATUS) {
            order.setOrderCreateTime(DateUtil.currentSecond());
        } else if (order.getOrderStatus() == GlobalConstant.TRANSPORT_ORDER_STATUS) {
            order.setOrderTransportTime(DateUtil.currentSecond());
        } else if (order.getOrderStatus() == GlobalConstant.RECIEVE_ORDER_STATUS) {
            order.setOrderReceiveTime(DateUtil.currentSecond());
        } else {
            return null;
        }
        orderMapper.update(packageInfo(request, order, 0));
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
    public Order selectById(Integer id) {
        return orderMapper.selectById(id);
    }

    @Override
    public List<Order> selectByAnyParam(Order order) {
        temps = orderMapper.selectByAnyParam(order);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }
}
