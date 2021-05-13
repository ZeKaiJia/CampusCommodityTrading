package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.mapper.RoleMapper;
import cn.ky.jzk.mapper.UserMapper;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.UserService;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RelationRoleUserMapper relationRoleUserMapper;

    private User temp;

    private List<User> temps;

    @Override
    public User insert(@NotNull User user, String roleNameCn) {
        temp = userMapper.selectByName(user.getUserName());
        Role role = roleMapper.selectByNameCn(roleNameCn);
        if (temp != null) {
            return null;
        }
        userMapper.insert(user);
        relationRoleUserMapper.insert(user.getUserName(), role.getRoleId());
        return user;
    }

    @Override
    public User delete(String userName) {
        temp = userMapper.selectByName(userName);
        if (temp == null) {
            return null;
        }
        userMapper.delete(userName);
        return temp;
    }

    @Override
    public User update(@NotNull User user, String roleNameCn) {
        temp = userMapper.selectByName(user.getUserName());
        Role role = roleMapper.selectByNameCn(roleNameCn);
        if (temp == null) {
            return null;
        }
        relationRoleUserMapper.delete(user.getUserName());
        relationRoleUserMapper.insert(user.getUserName(), role.getRoleId());
        userMapper.update(user);
        return user;
    }

    @Override
    public List<User> select() {
        temps = userMapper.select();
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public User selectByName(String userName) {
        return userMapper.selectByName(userName);
    }

    @Override
    public User login(String userName, String userPassword) {
        temp = userMapper.login(userName, userPassword);
        if (temp == null) {
            return null;
        }
        return temp;
    }
}
