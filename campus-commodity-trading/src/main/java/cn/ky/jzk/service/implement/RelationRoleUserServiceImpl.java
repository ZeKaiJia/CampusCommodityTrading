package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.RelationRoleUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class RelationRoleUserServiceImpl implements RelationRoleUserService {

    @Autowired
    private RelationRoleUserMapper relationRoleUserMapper;

    @Override
    public String insert(String userName, String roleId) {
        try {
            relationRoleUserMapper.insert(userName, roleId);
            return "关联用户角色成功";
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public String update(String userName, String roleId) {
        try {
            relationRoleUserMapper.update(userName, roleId);
            return "修改用户角色成功";
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Role selectUserRole(String userName) {
        return relationRoleUserMapper.selectUserRole(userName);
    }
}
