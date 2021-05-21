package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import org.jetbrains.annotations.NotNull;
import org.springframework.web.bind.annotation.RequestParam;

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

    Commodity updateRate(String comId, Double rate);

    List<Commodity> select();

    Commodity selectById(String comId);

    List<Commodity> selectByName(String comName);

    List<Commodity> selectByPriceBetween(Double min, Double max);

    List<Commodity> selectByQuantityBetween(Integer min, Integer max);

    List<Commodity> selectByQuantityNow(Integer comQuantityNow);

    List<Commodity> selectByAnyParam(@NotNull Commodity commodity, Integer minQuantity,
                                     Integer maxQuantity, Double minPrice,
                                     Double maxPrice);
}
