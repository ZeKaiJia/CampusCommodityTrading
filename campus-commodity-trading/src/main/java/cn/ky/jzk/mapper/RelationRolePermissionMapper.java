package cn.ky.jzk.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 22:41
 */
@Repository
public interface RelationRolePermissionMapper {
    Set<String> findPermissionByRoleId(@Param("roleId") String roleId);
}
