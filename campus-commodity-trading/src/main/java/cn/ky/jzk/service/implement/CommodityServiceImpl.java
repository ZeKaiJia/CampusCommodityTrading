package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.CommodityMapper;
import cn.ky.jzk.mapper.RoleMapper;
import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.CommodityService;
import cn.ky.jzk.service.RoleService;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class CommodityServiceImpl implements CommodityService {

    @Autowired
    private CommodityMapper commodityMapper;

    private Commodity temp;

    @Override
    public Commodity insert(@NotNull Commodity commodity) {
        temp = commodityMapper.selectById(commodity.getComId());
        if (temp != null) {
            return null;
        }
        commodityMapper.insert(commodity);
        return commodity;
    }

    @Override
    public Commodity delete(String comId) {
        temp = commodityMapper.selectById(comId);
        if (temp == null) {
            return null;
        }
        commodityMapper.delete(comId);
        return temp;
    }

    @Override
    public Commodity update(@NotNull Commodity commodity) {
        temp = commodityMapper.selectById(commodity.getComId());
        if (temp == null) {
            return null;
        }
        commodityMapper.update(commodity);
        return commodity;
    }

    @Override
    public List<Commodity> select() {
        return commodityMapper.select();
    }

    @Override
    public Commodity selectById(String comId) {
        return commodityMapper.selectById(comId);
    }
}
