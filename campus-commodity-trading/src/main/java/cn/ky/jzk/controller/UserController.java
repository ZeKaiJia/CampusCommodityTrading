package cn.ky.jzk.controller;

import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.RelationRoleUserService;
import cn.ky.jzk.service.RoleService;
import cn.ky.jzk.service.UserService;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin()
@RestController()
@RequestMapping("/user/")
public class UserController extends BaseController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("relationCommodityUserServiceImpl")
    private RelationCommodityUserService relationCommodityUserService;

    private User temp;

    // TODO 角色名重复问题
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<User> insert(@RequestBody User user, @RequestParam String roleNameCn) {
        temp = userService.insert(user, roleNameCn);
        if (temp == null) {
            return getFailResult(404, "用户名已存在");
        }
        return getSuccessResult(temp);
    }

    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<User> delete(@RequestParam String userName) {
        temp = userService.delete(userName);
        if (temp == null) {
            return getFailResult(404, "用户名不存在");
        }
        relationCommodityUserService.deleteAll(userName);
        return getSuccessResult(temp);
    }

    @PostMapping(value = "/update")
    @ResponseBody
    public Response<User> update(@RequestBody User user, @RequestParam String roleNameCn) {
        temp = userService.update(user, roleNameCn);
        if (temp == null) {
            return getFailResult(404, "数据错误");
        }
        return getSuccessResult(temp);
    }

    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<User>> select() {
        List<User> users = userService.select();
        if (users.size() == 0) {
            return getFailResult(404, "未找到数据");
        }
        return getSuccessResult(users);
    }

    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<User> selectByName(@RequestParam String userName) {
        temp =  userService.selectByName(userName);
        if (temp == null) {
            getFailResult(404, "未找到数据");
        }
        return getSuccessResult(temp);
    }

    @PostMapping(value = "/login")
    @ResponseBody
    public Response<User> login(@RequestBody User user) {
        temp = userService.login(user.getUserName(), user.getUserPassword());
        if (temp == null) {
            return getFailResult(404, "登录失败");
        }
        return getSuccessResult(temp);
    }
}
