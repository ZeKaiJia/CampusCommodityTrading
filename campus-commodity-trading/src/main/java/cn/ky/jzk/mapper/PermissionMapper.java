package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface PermissionMapper {

    void insert(Permission permission);

    void delete(@Param("perId") int perId);

    void update(Permission permission);

    List<Permission> select();

    Permission selectById(@Param("perId") int perId);

    Permission selectByCode(@Param("perCode") String perCode);
}
