package cn.ky.jzk.mapper;

import cn.ky.jzk.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface UserMapper {

    void insert(User user);

    void importExcel(@Param("users") List<User> users);

    void delete(@Param("userName") String userName);

    void update(User user);

    List<User> select();

    User selectByName(@Param("userName") String userName);

    void login(User user);
}
