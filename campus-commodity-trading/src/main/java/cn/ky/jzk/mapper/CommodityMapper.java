package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Commodity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface CommodityMapper {

    void insert(Commodity commodity);

    void delete(@Param("comId") String comId);

    void update(Commodity commodity);

    List<Commodity> select();

    Commodity selectById(@Param("comId") String comId);

    List<Commodity> selectByName(@Param("comName") String comName);

    List<Commodity> selectByPriceBetween(@Param("min") Double min, @Param("max") Double max);

    List<Commodity> selectByQuantityNow(@Param("comQuantityNow") Integer comQuantityNow);

    void deleteAllZero(@Param("userName") String userName);
}
