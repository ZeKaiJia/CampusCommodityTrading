package cn.ky.jzk.service;

import cn.ky.jzk.blockChain.Block;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface BlockService {

    void insert(Block block);

    void delete(Integer id);

    void update(Block block);

    List<Block> select();

    Block selectById(Integer id);
}
