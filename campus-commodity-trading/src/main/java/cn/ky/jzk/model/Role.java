package cn.ky.jzk.model;

import lombok.*;

/**
 * 角色类
 * Role
 * 角色POJO类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Role {
    /**
     * 角色号
     * The Role ID.
     */
    private String roleId;
    /**
     * 中文名
     * The Role Name China.
     */
    private String roleNameCn;
    /**
     * 英文名
     * The Role Name English.
     */
    private String roleNameEn;
    /**
     * 描述
     * The Role Description.
     */
    private String roleDescription;
}
