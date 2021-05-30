package cn.ky.jzk.controller;

import cn.ky.jzk.model.User;
import cn.ky.jzk.service.AddressService;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.UserService;
import cn.ky.jzk.swagger.api.UserControllerApi;
import cn.ky.jzk.util.CorsUtil;
import cn.ky.jzk.vo.Response;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.SessionException;
import org.apache.shiro.subject.Subject;
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
    @Qualifier("addressServiceImpl")
    private AddressService addressService;

    @Autowired
    @Qualifier("relationCommodityUserServiceImpl")
    private RelationCommodityUserService relationCommodityUserService;

    private User temp;

    List<User> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<User> insert(@RequestBody User user, @RequestParam String roleNameCn,
                                 @RequestParam Integer status) {
        temp = userService.insert(user, roleNameCn, status);
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
        return getSuccessResult(temp);
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<User> update(@RequestBody User user, @RequestParam String roleNameCn,
                                 @RequestParam Integer status) {
        temp = userService.update(user, roleNameCn, status);
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
    public Response<String> login(@RequestBody User user) {
        User result;
        int code;
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), user.getUserPassword());
        token.setRememberMe(true);
        try {
            subject.login(token);
            code = userService.login(user.getUserName(), user.getUserPassword());
            session.setAttribute("user", subject);
        } catch (UnknownAccountException e) {
            return getFailResult(404, "Message not found");
        } catch (IncorrectCredentialsException e) {
            return getFailResult(412, "Incorrect message");
        } catch (LockedAccountException e) {
            return getFailResult(401, "Account locked");
        } catch (Exception e) {
            e.printStackTrace();
            return getFailResult(408, "Unknown error");
        }
        if (code != 200) {
            return getFailResult(code, "登录失败");
        } else {
            return getSuccessResult("登录成功");
        }
    }


    @Override
    @GetMapping(value = "/logout")
    @ResponseBody
    public Response<String> userLogout() {
        CorsUtil.setResponseHeader(response, request);
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.logout();
        } catch (SessionException e) {
            e.printStackTrace();
            return getFailResult(408, e.toString());
        }
        return getSuccessResult("logout");
    }

    @Override
    @RequestMapping(value = "/toLogin", method = RequestMethod.GET)
    public String toLogin() {
        return "redirect:user/login";
    }
}
