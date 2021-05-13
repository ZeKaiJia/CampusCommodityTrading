package cn.ky.jzk.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * 订单实体类
 * Order
 * 订单POJO类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    /**
     * 序号
     * The User nick.
     */
    private Integer id;
    /**
     * 卖家账号
     * The User name.
     */
    private String orderSalerName;
    /**
     * 买家账号
     * The User password.
     */
    private String orderBuyerName;
    /**
     * 创建时间
     * The User nick.
     */
    private long orderCreateTime;
    /**
     * 发货时间
     * The User gender.
     */
    private long orderTransportTime;
    /**
     * 收货时间
     * The User phone.
     */
    private long orderRecieveTime;
    /**
     * 订单状态
     * The User email.
     */
    private Integer orderStatus;
}
