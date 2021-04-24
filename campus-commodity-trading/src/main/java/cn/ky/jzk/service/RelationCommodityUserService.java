package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/24 16:02
 */
public interface RelationCommodityUserService {
    void insert(String userName, String comId);

    List<Commodity> select(String userName);

    void delete(String comId);

    void deleteAll(String userName);
}
