package cn.ky.jzk.service;

import cn.ky.jzk.model.Role;

import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface RelationRoleUserService {

    String insert(String userName, String roleId);

    String update(String userName, String roleId);

    Role selectUserRole(String userName);

    Set<String> findRoleByUserName(String userName);
}
