package cn.ky.jzk.mapper;

import cn.ky.jzk.blockChain.Block;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface BlockMapper {

    void insert(Block block);

    void delete(@Param("id") Integer id);

    void update(Block block);

    List<Block> select();

    Block selectById(@Param("id") Integer id);
}
