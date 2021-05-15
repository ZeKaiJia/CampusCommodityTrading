package cn.ky.jzk.controller;

import cn.ky.jzk.model.User;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.UserService;
import cn.ky.jzk.swagger.api.UserControllerApi;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin()
@RestController()
@RequestMapping("/user/")
public class UserController extends BaseController implements UserControllerApi {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("relationCommodityUserServiceImpl")
    private RelationCommodityUserService relationCommodityUserService;

    private User temp;

    List<User> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<User> insert(@RequestBody User user, @RequestParam String roleNameCn) {
        temp = userService.insert(user, roleNameCn);
        return dataAnalyse(temp, 404, "用户已存在");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<User> delete(@RequestParam String userName) {
        temp = userService.delete(userName);
        if (temp == null) {
            return getFailResult(404, "用户名不存在");
        }
        relationCommodityUserService.deleteByName(userName);
        return getSuccessResult(temp);
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<User> update(@RequestBody User user, @RequestParam String roleNameCn) {
        temp = userService.update(user, roleNameCn);
        return dataAnalyse(temp, 404, "数据错误");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<User>> select() {
        temps = userService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }

    @Override
    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<User> selectByName(@RequestParam String userName) {
        temp =  userService.selectByName(userName);
        return dataAnalyse(temp, 404, "未找到数据");
    }

    @Override
    @PostMapping(value = "/login")
    @ResponseBody
    public Response<User> login(@RequestBody User user) {
        temp = userService.login(user.getUserName(), user.getUserPassword());
        return dataAnalyse(temp, 404, "登陆失败");
    }
}
