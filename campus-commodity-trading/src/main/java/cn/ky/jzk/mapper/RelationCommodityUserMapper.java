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

    void insert(@Param("userName") String userName, @Param("comId") String comId, @Param("number") Integer number);

    List<String> selectByName(@Param("userName") String userName);

    List<String> selectById(@Param("comId") String comId);

    Integer selectQuantity(@Param("userName") String userName, @Param("comId") String comId);

    void deleteById(@Param("comId") String comId);

    void deleteByName(@Param("userName") String userName);

    void deleteSingle(@Param("userName") String userName, @Param("comId") String comId);


}
