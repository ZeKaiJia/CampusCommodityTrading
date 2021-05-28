package cn.ky.jzk.service.implement;

import cn.ky.jzk.blockChain.Block;
import cn.ky.jzk.mapper.BlockMapper;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.BlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * AddressServiceImpl
 *
 * @author jiazekai 2021年05月19日
 * @version V1.0
 * @modify by user: jiazekai 2021年05月19日 16:05
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class BlockServiceImpl extends AbstractService implements BlockService {
    @Autowired
    BlockMapper blockMapper;

    private Block temp;

    private List<BlockService> temps;

    @Override
    public void insert(Block block) {
        blockMapper.insert(block);
    }

    @Override
    public void delete(Integer id) {
        blockMapper.delete(id);
    }

    @Override
    public void update(Block block) {
        blockMapper.update(block);
    }

    @Override
    public List<Block> select() {
        return blockMapper.select();
    }

    @Override
    public Block selectById(Integer id) {
        return blockMapper.selectById(id);
    }
}
