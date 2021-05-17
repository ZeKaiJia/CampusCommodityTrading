package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 商品类
 * Commodity
 * 商品POJO类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "商品实体类", description = "商品实体类")
public class Commodity extends BaseEntity {
    /**
     * 商品号
     * The Commodity ID.
     */
    @ApiModelProperty(value="商品号", example = "SH001", required = true)
    private String comId;
    /**
     * 名称
     * The Commodity Name.
     */
    @ApiModelProperty(value="名称", example = "扫把", required = true)
    private String comName;
    /**
     * 数量
     * The Commodity Quantity.
     */
    @ApiModelProperty(value="数量", example = "5", required = true)
    private Integer comQuantity;
    /**
     * 当前数量
     * The Commodity Quantity Now.
     */
    @ApiModelProperty(value="当前数量", example = "1", required = true)
    private Integer comQuantityNow;
    /**
     * 单价
     * The Commodity Each Price.
     */
    @ApiModelProperty(value="单价", example = "1", required = true)
    private Double comEachPrice;
    /**
     * 描述
     * The Commodity Description.
     */
    @ApiModelProperty(value="描述", example = "扫把", required = false)
    private String comDescription;
    /**
     * 评价
     * The Commodity Rate.
     */
    @ApiModelProperty(value="评价", example = "5", required = true)
    private Double comRate;
    /**
     * 评价数量
     * The Commodity Sale Count.
     */
    @ApiModelProperty(value="评价数量", example = "10", required = true)
    private Integer comRateCount;
    /**
     * 图片
     * The Commodity Picture.
     */
    @ApiModelProperty(value="图片", example = "https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png", required = false)
    private String comPicture;
}
