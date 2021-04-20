package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
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
}
