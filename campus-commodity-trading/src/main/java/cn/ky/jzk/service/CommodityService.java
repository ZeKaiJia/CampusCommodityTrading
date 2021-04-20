package cn.ky.jzk.service;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface CommodityService {

    Commodity insert(@NotNull Commodity commodity);

    Commodity delete(String comId);

    Commodity update(@NotNull Commodity commodity);

    List<Commodity> select();

    Commodity selectById(String comId);
}
