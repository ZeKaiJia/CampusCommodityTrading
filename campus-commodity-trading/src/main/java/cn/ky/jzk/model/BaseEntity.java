package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 基本实体类
 * The type Abstract entity.
 * BaseEntity
 * @Author: Kevin
 * @Date: 2020 /6/2 3:42 下午
 */
@Data
@ApiModel(value = "基本实体类", description = "基本实体类")
public abstract class BaseEntity implements Serializable {
    /**
     * 序列化
     * The constant serialVersionUID.
     */
    protected static final long serialVersionUID = 4846381295033205916L;
    /**
     * UTC创建时间
     * The Utc create.
     */
    @ApiModelProperty(value = "创建时间", required = true)
    protected long utcCreate;
     /**
      * UTC修改时间
     * The Utc modify.
     */
    @ApiModelProperty(value = "修改时间", required = true)
    protected long utcModify;
    /**
     * 修改人
     * The Modify by.
     */
    @ApiModelProperty(value = "修改人", required = true)
    protected String modifyBy;
    /**
     * 是否有效
     * The Valid.
     */
    @ApiModelProperty(value = "是否有效", required = true)
    protected Boolean valid;
    /**
     * 备注
     * The Remark.
     */
    @ApiModelProperty(value = "备注", required = false)
    protected String remark;
    /**
     * 自定义字段a
     * The Custom A.
     */
    @ApiModelProperty(value = "自定义字段a", required = false)
    protected String customa;
    /**
     * 自定义字段b
     * The Custom B.
     */
    @ApiModelProperty(value = "自定义字段b", required = false)
    protected String customb;
}
