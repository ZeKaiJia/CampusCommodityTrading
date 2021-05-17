package cn.ky.jzk.service;

import cn.ky.jzk.model.User;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface UserService {

    User insert(@NotNull User user, String roleNameCn, Integer status);

    User delete(String userName);

    User update(@NotNull User user, String roleNameCn, Integer status);

    List<User> select();

    User selectByName(String userName);

    User login(String userName, String userPassword);
}
