package cn.ky.jzk.controller;

import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.RelationRoleUserService;
import cn.ky.jzk.service.RoleService;
import cn.ky.jzk.swagger.api.RoleControllerApi;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin
@RestController()
@RequestMapping("/role/")
public class RoleController extends BaseController implements RoleControllerApi {

    @Autowired
    @Qualifier("roleServiceImpl")
    private RoleService roleService;

    @Autowired
    @Qualifier("relationRoleUserServiceImpl")
    private RelationRoleUserService relationRoleUserService;

    private Role temp;

    List<Role> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<Role> insert(@RequestBody Role role) {
        temp = roleService.insert(role);
        return dataAnalyse(temp, 404, "ID已存在");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Role> delete(@RequestParam String roleId) {
        temp = roleService.delete(roleId);
        return dataAnalyse(temp, 404, "ID不存在");
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Role> update(@RequestBody Role role) {
        temp = roleService.update(role);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Role>> select() {
        temps = roleService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectUserRole")
    @ResponseBody
    public Response<Role> selectUserRole(@RequestParam String userName) {
        temp = relationRoleUserService.selectUserRole(userName);
        return dataAnalyse(temp, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Role> selectById(@RequestParam String roleId) {
        temp =  roleService.selectById(roleId);
        return dataAnalyse(temp, 404, "未找到数据");
    }
}
