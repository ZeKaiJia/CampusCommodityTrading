package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 角色类
 * Role
 * 角色实体类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "角色实体类", description = "角色实体类")
public class Role extends BaseEntity{
    /**
     * 角色号
     * The Role ID.
     */
    @ApiModelProperty(value="角色号", example = "1", required = true)
    private String roleId;
    /**
     * 中文名
     * The Role Name China.
     */
    @ApiModelProperty(value="中文名", example = "管理员", required = true)
    private String roleNameCn;
    /**
     * 英文名
     * The Role Name English.
     */
    @ApiModelProperty(value="英文名", example = "admin", required = true)
    private String roleNameEn;
    /**
     * 描述
     * The Role Description.
     */
    @ApiModelProperty(value="描述", example = "系统管理员，拥有最高权限", required = true)
    private String roleDescription;
}
