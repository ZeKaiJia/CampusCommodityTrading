package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "订单实体类", description = "订单实体类")
public class Order extends BaseEntity {
    /**
     * 序号
     * The Id.
     */
    @ApiModelProperty(value="序号", example = "1", required = true)
    private Integer id;
    /**
     * 交易商品
     * The Commodity Id.
     */
    @ApiModelProperty(value="交易商品", example = "SH001", required = true)
    private String orderComId;
    /**
     * 卖家账号
     * The Saler Name.
     */
    @ApiModelProperty(value="卖家账号", example = "Xb18620208", required = true)
    private String orderSalerName;
    /**
     * 买家账号
     * The Buyer Name.
     */
    @ApiModelProperty(value="买家账号", example = "Xb18620230", required = true)
    private String orderBuyerName;
    /**
     * 发货地址
     * The Saler Address.
     */
    @ApiModelProperty(value="发货地址", example = "浙江理工大学科技与艺术学院129", required = false)
    private String orderSalerAddress;
    /**
     * 收货地址
     * The Saler Address.
     */
    @ApiModelProperty(value="收货地址", example = "浙江理工大学科技与艺术学院快递站", required = true)
    private String orderBuyerAddress;
    /**
     * 运单号
     * The Transport Code.
     */
    @ApiModelProperty(value="运单号", example = "1324293892839", required = false)
    private String orderTransportCode;
    /**
     * 创建时间
     * The Create Time.
     */
    @ApiModelProperty(value="创建时间", example = "1621074167413", required = false)
    private long orderCreateTime;
    /**
     * 发货时间
     * The Transport TIme.
     */
    @ApiModelProperty(value="发货时间", example = "1621074167413", required = false)
    private long orderTransportTime;
    /**
     * 收货时间
     * The Receive Time.
     */
    @ApiModelProperty(value="收货时间", example = "1621074167413", required = false)
    private long orderReceiveTime;
    /**
     * 订单状态
     * The Status.
     */
    @ApiModelProperty(value="订单状态(1:已下单2:已发货3:已收货)", example = "1", required = true)
    private Integer orderStatus;
    /**
     * 订单支付状态
     * The Pay Status.
     */
    @ApiModelProperty(value="订单支付状态(1:已支付2:未支付)", example = "1", required = true)
    private Integer orderPayStatus;
    /**
     * 订单截止时间
     * The Time.
     */
    @ApiModelProperty(value="订单截止时间", example = "1621074167413", required = true)
    private long orderTime;
}
