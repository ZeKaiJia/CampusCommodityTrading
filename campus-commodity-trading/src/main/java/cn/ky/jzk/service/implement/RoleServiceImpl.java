package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RoleMapper;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.RoleService;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class RoleServiceImpl extends AbstractService implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    private Role temp;

    private List<Role> temps;

    @Override
    public Role insert(@NotNull Role role) {
        temp = roleMapper.selectById(role.getRoleId());
        if (temp != null) {
            return null;
        }
        roleMapper.insert(packageInfo(request, role, 1));
        return role;
    }

    @Override
    public Role delete(String roleId) {
        temp = roleMapper.selectById(roleId);
        if (temp == null) {
            return null;
        }
        roleMapper.delete(roleId);
        return temp;
    }

    @Override
    public Role update(@NotNull Role role) {
        temp = roleMapper.selectById(role.getRoleId());
        if (temp == null) {
            return null;
        }
        roleMapper.update(packageInfo(request, role, 0));
        return role;
    }

    @Override
    public List<Role> select() {
        temps = roleMapper.select();
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public Role selectById(String roleId) {
        return roleMapper.selectById(roleId);
    }

    @Override
    public Role selectByNameCn(String roleNameCn) {
        return roleMapper.selectByNameCn(roleNameCn);
    }
}
