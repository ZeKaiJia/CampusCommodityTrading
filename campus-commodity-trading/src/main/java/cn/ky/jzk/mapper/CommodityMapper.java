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

    List<Commodity> selectByQuantityBetween(@Param("min") Integer min, @Param("max") Integer max);

    void deleteAllZero(@Param("userName") String userName);

    List<Commodity> selectByAnyParam(@Param("comId") String comId, @Param("comName") String comName,
                                     @Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice,
                                     @Param("minQuantity") Integer minQuantity, @Param("maxQuantity") Integer maxQuantity,
                                     @Param("comDescription") String comDescription);
}
