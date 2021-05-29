package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface RoleMapper {

    void insert(Role role);

    void delete(@Param("roleId") String roleId);

    void update(Role role);

    List<Role> select();

    Role selectById(@Param("roleId") String roleId);

    Role selectByNameCn(@Param("roleNameCn") String roleNameCn);
}
