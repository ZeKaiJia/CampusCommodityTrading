package cn.ky.jzk.service;

import cn.ky.jzk.model.Role;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface RoleService {

    Role insert(@NotNull Role role);

    Role delete(String roleId);

    Role update(@NotNull Role role);

    List<Role> select();

    Role selectById(String roleId);

    Role selectByNameCn(String roleNameCn);
}
