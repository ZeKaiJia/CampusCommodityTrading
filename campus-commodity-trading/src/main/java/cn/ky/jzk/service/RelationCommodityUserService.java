package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/24 16:02
 */
public interface RelationCommodityUserService {
    void insert(String userName, String comId);

    List<Commodity> selectByName(String userName);

    User selectById(String comId);

    void deleteById(String comId);

    void deleteByName(String userName);

    void deleteSingle(String userName, String comId);

}
