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

    void updateRate(@Param("comId") String comId, @Param("comRate") Double comRate, @Param("comRateCount") Integer comRateCount);

    List<Commodity> select();

    Commodity selectById(@Param("comId") String comId);

    Commodity selectValidId(@Param("comId") String comId);

    List<Commodity> selectByName(@Param("comName") String comName);

    List<Commodity> selectByPriceBetween(@Param("min") Double min, @Param("max") Double max);

    List<Commodity> selectByQuantityNow(@Param("comQuantityNow") Integer comQuantityNow);

    List<Commodity> selectByQuantityBetween(@Param("min") Integer min, @Param("max") Integer max);

    void deleteAllZero(@Param("userName") String userName);

    List<Commodity> selectByAnyParam(@Param("commodity") Commodity commodity, @Param("minQuantity") Integer minQuantity,
                                     @Param("maxQuantity") Integer maxQuantity, @Param("minPrice") Double minPrice,
                                     @Param("maxPrice") Double maxPrice);
}
