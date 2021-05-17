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
     * The User nick.
     */
    @ApiModelProperty(value="序号", example = "1", required = true)
    private Integer id;
    /**
     * 交易商品
     * The User name.
     */
    @ApiModelProperty(value="交易商品", example = "SH001", required = true)
    private String orderComId;
    /**
     * 新商品号
     * The User name.
     */
    @ApiModelProperty(value="新商品号", example = "SH100", required = true)
    private String orderNewId;
    /**
     * 卖家账号
     * The User name.
     */
    @ApiModelProperty(value="卖家账号", example = "Xb18620208", required = true)
    private String orderSalerName;
    /**
     * 买家账号
     * The User password.
     */
    @ApiModelProperty(value="买家账号", example = "Xb18620230", required = true)
    private String orderBuyerName;
    /**
     * 创建时间
     * The User nick.
     */
    @ApiModelProperty(value="创建时间", example = "1621074167413", required = false)
    private long orderCreateTime;
    /**
     * 发货时间
     * The User gender.
     */
    @ApiModelProperty(value="发货时间", example = "1621074167413", required = false)
    private long orderTransportTime;
    /**
     * 收货时间
     * The User phone.
     */
    @ApiModelProperty(value="收货时间", example = "1621074167413", required = false)
    private long orderRecieveTime;
    /**
     * 订单状态
     * The User email.
     */
    @ApiModelProperty(value="订单状态(1:已下单2:已发货3:已收货)", example = "1", required = true)
    private Integer orderStatus;
}
