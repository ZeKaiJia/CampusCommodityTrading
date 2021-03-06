package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 22:41
 */
@Repository
public interface RelationRoleUserMapper {

    void insert(@Param("userName") String userName, @Param("roleId") String roleId);

    void update(@Param("userName") String userName, @Param("roleId") String roleId);

    Role selectUserRole(@Param("userName") String userName);

    Set<String> findRoleByUserName(@Param("userName") String userName);

    void delete(@Param("userName") String userName);
}
