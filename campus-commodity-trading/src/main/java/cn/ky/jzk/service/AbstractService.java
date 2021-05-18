package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Order;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * @Author: Kevin
 * @Date: 2021/5/16 20:17
 */
public abstract class AbstractService {
    /**
     * The Logger.
     */
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * The Request.
     * 请求
     */
    @Autowired
    protected HttpServletRequest request;

    /**
     * The Response.
     * 响应
     */
    @Autowired(required = false)
    protected HttpServletResponse response;

    /**
     * The Session.
     * 会话
     */
    @Autowired
    protected HttpSession session;

    protected static Cookie getCookieByName(HttpServletRequest request, String name){
        Map<String, Cookie> cookieMap = ReadCookieMap(request);
        if(cookieMap.containsKey(name)){
            Cookie cookie = cookieMap.get(name);
            return cookie;
        }else{
            return null;
        }
    }

    protected static Map<String, Cookie> ReadCookieMap(HttpServletRequest request){
        Map<String, Cookie> cookieMap = new HashMap<>();
        Cookie[] cookies = request.getCookies();
        if(null!=cookies){
            for(Cookie cookie : cookies){
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }

    protected static Map<String, String> getInfo(HttpServletRequest request) {
        Map<String, String> map = new HashMap<>();
        map.put("modifyBy", Objects.requireNonNull(getCookieByName(request, "ID")).getValue());
        map.put("utcModify", DateUtil.currentSecond().toString());
        return map;
    }

    protected static User packageInfo(HttpServletRequest request, User user, Integer status) {
        if (status == 2) {
            // 无权限修改用户
            user.setUtcModify(DateUtil.currentSecond());
            user.setModifyBy(user.getUserName());
        } else if (status == 1) {
            // 新增用户
            user.setUtcCreate(DateUtil.currentSecond());
            user.setUtcModify(Long.parseLong(getInfo(request).get("utcModify")));
            user.setModifyBy(getInfo(request).get("modifyBy"));
        } else if (status == 3) {
            // 无权限添加用户
            user.setUtcCreate(DateUtil.currentSecond());
            user.setUtcModify(user.getUtcCreate());
            user.setModifyBy(user.getUserName());
        } else {
            user.setUtcModify(Long.parseLong(getInfo(request).get("utcModify")));
            user.setModifyBy(getInfo(request).get("modifyBy"));
        }
        return user;
    }

    protected static Role packageInfo(HttpServletRequest request, Role role, Integer status) {
        role.setUtcModify(Long.parseLong(getInfo(request).get("utcModify")));
        role.setModifyBy(getInfo(request).get("modifyBy"));
        // 状态为1时为新建数据
        if (status == 1) {
            role.setUtcCreate(role.getUtcModify());
        }
        return role;
    }

    protected static Commodity packageInfo(HttpServletRequest request, Commodity commodity, Integer status) {
        commodity.setUtcModify(Long.parseLong(getInfo(request).get("utcModify")));
        commodity.setModifyBy(getInfo(request).get("modifyBy"));
        // 状态为1时为新建数据
        if (status == 1) {
            commodity.setUtcCreate(commodity.getUtcModify());
        }
        return commodity;
    }

    protected static Order packageInfo(HttpServletRequest request, Order order, Integer status) {
        order.setUtcModify(Long.parseLong(getInfo(request).get("utcModify")));
        order.setModifyBy(getInfo(request).get("modifyBy"));
        // 状态为1时为新建数据
        if (status == 1) {
            order.setUtcCreate(order.getUtcModify());
        }
        return order;
    }
}
