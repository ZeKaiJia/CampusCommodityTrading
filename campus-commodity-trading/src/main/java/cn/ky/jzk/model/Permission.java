package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 权限类
 * Role
 * 权限实体类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "权限实体类", description = "权限实体类")
public class Permission extends BaseEntity {
    /**
     * 序号
     * The Permission ID.
     */
    @ApiModelProperty(value = "序号", example = "1", required = true)
    private String perId;
    /**
     * 权限名
     * The Permission Name.
     */
    @ApiModelProperty(value = "权限名", example = "添加用户", required = true)
    private String perName;
    /**
     * 权限代码
     * The Permission Code.
     */
    @ApiModelProperty(value = "权限代码", example = "user:select", required = true)
    private String perCode;
}
