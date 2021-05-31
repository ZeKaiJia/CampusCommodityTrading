package cn.ky.jzk.shiro;

import cn.ky.jzk.model.User;
import cn.ky.jzk.service.*;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

/**
 * Realm
 *
 * @Author: Kevin
 * @Date: 2020/8/3 10:50 上午
 */
public class MyShiroRealm extends AuthorizingRealm {
    private static final Logger LOGGER = LoggerFactory.getLogger(MyShiroRealm.class);
    @Resource(name = "relationRolePermissionServiceImpl")
    private RelationRolePermissionService relationRolePermissionService;
    @Resource(name = "roleServiceImpl")
    private RoleService roleService;
    @Resource(name = "relationRoleUserServiceImpl")
    private RelationRoleUserService relationRoleUserService;
    @Resource(name = "userServiceImpl")
    private UserService userService;
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String userName = token.getUsername();
        User user = userService.selectByName(userName);
        if (user == null) {
            throw new UnknownAccountException("Message not found");
        } else if (!user.getValid()) {
            throw new LockedAccountException("Account locked");
        }
        return new SimpleAuthenticationInfo(
            user.getUserName(),
            user.getUserPassword(),
            ByteSource.Util.bytes(userName),
            getName()
        );
    }
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        String userName = (String)principalCollection.getPrimaryPrincipal();
        if (userName == null) {
            LOGGER.error("授权失败，用户信息为空!");
            return null;
        }
        try {
            Set<String> roleIds = relationRoleUserService.findRoleByUserName(userName);
            Set<String> roles = new HashSet<>();
            for (String id : roleIds) {
                // TODO
                roles.add(roleService.selectById(id).getRoleNameEn());
            }
            simpleAuthorizationInfo.addRoles(roles);
            for (String role : roles) {
                Set<String> permissions = relationRolePermissionService.findPermissionByRoleId(role);
                simpleAuthorizationInfo.addStringPermissions(permissions);
            }
            return simpleAuthorizationInfo;
        } catch (Exception e) {
            LOGGER.error("授权失败，系统内部错误!");
        }
        return simpleAuthorizationInfo;
    }
}
