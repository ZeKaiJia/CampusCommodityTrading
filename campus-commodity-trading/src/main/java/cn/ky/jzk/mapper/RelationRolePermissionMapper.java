package cn.ky.jzk.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 22:41
 */
@Repository
public interface RelationRolePermissionMapper {
    void managePermission(@Param("roleId") String roleId, @Param("codes") List<String> codes);

    Set<String> findPermissionByRoleId(@Param("roleId") String roleId);

    void deleteByRoleId(@Param("roleId") String roleId);
}
