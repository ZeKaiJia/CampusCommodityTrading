package cn.ky.jzk.service;

import java.util.List;
import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface RelationRolePermissionService {
    Set<String> findPermissionByRoleId(String roleId);

    void deleteByRoleId(String roleId);

    String managePermission(String roleId, List<String> codes);
}
