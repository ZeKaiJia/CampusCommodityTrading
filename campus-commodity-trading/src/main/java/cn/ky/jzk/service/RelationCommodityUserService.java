package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/24 16:02
 */
public interface RelationCommodityUserService {
    void insert(String userName, String comId, Integer number);

    List<Commodity> selectByName(String userName);

    List<Commodity> selectById(String comId);

    Integer selectQuantity(String userName, String comId);

    void deleteById(String comId);

    void deleteByName(String userName);

    void deleteSingle(String userName, String comId);

}
