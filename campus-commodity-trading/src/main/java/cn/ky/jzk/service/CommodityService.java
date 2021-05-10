package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface CommodityService {

    Commodity insert(@NotNull Commodity commodity);

    Commodity delete(String comId);

    String deleteAllZero(String userName);

    Commodity update(@NotNull Commodity commodity);

    List<Commodity> select();

    Commodity selectById(String comId);

    List<Commodity> selectByName(String comName);

    List<Commodity> selectByPriceBetween(Double min, Double max);

    List<Commodity> selectByQuantityBetween(Integer min, Integer max);

    List<Commodity> selectByQuantityNow(Integer comQuantityNow);

    List<Commodity> selectByAnyParam(String comId, String comName, Double minPrice, Double maxPrice,
                                     Integer minQuantity, Integer maxQuantity, String comDescription);
}
