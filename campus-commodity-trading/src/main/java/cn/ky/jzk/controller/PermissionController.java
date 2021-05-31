package cn.ky.jzk.controller;

import cn.ky.jzk.model.Permission;
import cn.ky.jzk.service.PermissionService;
import cn.ky.jzk.service.RelationRolePermissionService;
import cn.ky.jzk.swagger.api.PermissionControllerApi;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin
@RestController()
@RequestMapping("/permission/")
public class PermissionController extends BaseController implements PermissionControllerApi {

    @Autowired
    @Qualifier("permissionServiceImpl")
    private PermissionService permissionService;

    @Autowired
    @Qualifier("relationRolePermissionServiceImpl")
    private RelationRolePermissionService relationRolePermissionService;

    private Permission temp;

    List<Permission> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<Permission> insert(@RequestBody Permission permission) {
        temp = permissionService.insert(permission);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<Permission> delete(@RequestParam int perId) {
        temp = permissionService.delete(perId);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<Permission> update(@RequestBody Permission permission) {
        temp = permissionService.update(permission);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Permission>> select() {
        temps = permissionService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectById")
    @ResponseBody
    public Response<Permission> selectById(@RequestParam int perId) {
        temp =  permissionService.selectById(perId);
        return dataAnalyse(temp, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/findPermissionByRoleId")
    @ResponseBody
    public Response<List<Permission>> findPermissionByRoleId(String roleId) {
        temps = new LinkedList<>();
        Set<String> permissions = relationRolePermissionService.findPermissionByRoleId(roleId);
        for (String permission : permissions) {
            temps.add(permissionService.selectByCode(permission));
        }
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @PostMapping(value = "/managePermission")
    @ResponseBody
    public Response<String> managePermission(@RequestParam String roleId, @RequestParam List<String> permissionCodes) {
        String result = null;
        relationRolePermissionService.deleteByRoleId(roleId);
        if (permissionCodes.size() != 0) {
            result = relationRolePermissionService.managePermission(roleId, permissionCodes);
        }
        return dataAnalyse(result, 404, "未找到数据");
    }
}
