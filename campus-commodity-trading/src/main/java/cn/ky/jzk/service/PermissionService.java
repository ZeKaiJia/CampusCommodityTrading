package cn.ky.jzk.service;

import cn.ky.jzk.model.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface PermissionService {

    Permission insert(Permission permission);

    Permission delete(int perId);

    Permission update(Permission permission);

    List<Permission> select();

    Permission selectById(int perId);

    Permission selectByCode(@Param("perCode") String perCode);
}
