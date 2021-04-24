package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.RelationCommodityUserMapper;
import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.RelationRoleUserService;
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
public class RelationCommodityUserServiceImpl implements RelationCommodityUserService {

    @Autowired
    private RelationCommodityUserMapper relationCommodityUserMapper;

    List<Commodity> commodities;


    @Override
    public void insert(String userName, String comId, Integer number) {
        Integer num =  relationCommodityUserMapper.selectQuantity(userName, comId);
        if (num != 0) {
            relationCommodityUserMapper.deleteSingle(userName, comId);
            relationCommodityUserMapper.insert(userName, comId, num + number);
        } else {
            relationCommodityUserMapper.insert(userName, comId, number);
        }
    }

    @Override
    public List<Commodity> selectByName(String userName) {
        return relationCommodityUserMapper.selectByName(userName);
    }

    @Override
    public List<Commodity> selectById(String comId) {
        return relationCommodityUserMapper.selectById(comId);
    }

    @Override
    public Integer selectQuantity(String userName, String comId) {
        return relationCommodityUserMapper.selectQuantity(userName, comId);
    }

    @Override
    public void deleteById(String comId) {
        relationCommodityUserMapper.deleteById(comId);
    }

    @Override
    public void deleteByName(String userName) {
        relationCommodityUserMapper.deleteByName(userName);
    }

    @Override
    public void deleteSingle(String userName, String comId) {
        relationCommodityUserMapper.deleteSingle(userName, comId);
    }
}
