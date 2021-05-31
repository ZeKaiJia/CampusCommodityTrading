package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RelationRolePermissionMapper;
import cn.ky.jzk.service.RelationRolePermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class RelationRolePermissionServiceImpl implements RelationRolePermissionService {

    @Autowired
    private RelationRolePermissionMapper relationRolePermissionMapper;

    @Override
    public Set<String> findPermissionByRoleId(String roleId) {
        return relationRolePermissionMapper.findPermissionByRoleId(roleId);
    }

    @Override
    public void deleteByRoleId(String roleId) {
        relationRolePermissionMapper.deleteByRoleId(roleId);
    }

    @Override
    public String managePermission(String roleId, List<String> codes) {
        try {
            relationRolePermissionMapper.managePermission(roleId, codes);
        } catch (Exception e) {
            return null;
        }
        return "Success";
    }
}
