package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 22:41
 */
@Repository
public interface RelationCommodityUserMapper {

    void insert(@Param("userName") String userName, @Param("comId") String comId);

    List<Commodity> select(@Param("userName") String userName);

    void delete(@Param("comId") String comId);

    void deleteAll(@Param("userName") String userName);
}
