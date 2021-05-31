package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.PermissionMapper;
import cn.ky.jzk.model.Permission;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.PermissionService;
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
public class PermissionServiceImpl extends AbstractService implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    private Permission temp;

    private List<Permission> temps;

    @Override
    public Permission insert(Permission permission) {
        temp = permissionMapper.selectById(permission.getPerId());
        if (temp != null) {
            return null;
        }
        permissionMapper.insert(packageInfo(request, permission, 1));
        return permission;
    }

    @Override
    public Permission delete(int perId) {
        temp = permissionMapper.selectById(perId);
        if (temp == null) {
            return null;
        }
        permissionMapper.delete(perId);
        return temp;
    }

    @Override
    public Permission update(Permission permission) {
        temp = permissionMapper.selectById(permission.getPerId());
        if (temp == null) {
            return null;
        }
        permissionMapper.update(packageInfo(request, permission, 0));
        return permission;
    }

    @Override
    public List<Permission> select() {
        temps = permissionMapper.select();
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public Permission selectById(int perId) {
        return permissionMapper.selectById(perId);
    }

    @Override
    public Permission selectByCode(String perCode) {
        return permissionMapper.selectByCode(perCode);
    }
}
