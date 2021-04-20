package cn.ky.jzk.model;

import lombok.*;

/**
 * 商品类
 * Commodity
 * 商品POJO类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Commodity {
    /**
     * 商品号
     * The Commodity ID.
     */
    private String comId;
    /**
     * 名称
     * The Commodity Name.
     */
    private String comName;
    /**
     * 数量
     * The Commodity Quantity.
     */
    private Integer comQuantity;
    /**
     * 当前数量
     * The Commodity Quantity Now.
     */
    private Integer comQuantityNow;
    /**
     * 单价
     * The Commodity Each Price.
     */
    private Double comEachPrice;
    /**
     * 描述
     * The Commodity Description.
     */
    private String comDescription;
}
