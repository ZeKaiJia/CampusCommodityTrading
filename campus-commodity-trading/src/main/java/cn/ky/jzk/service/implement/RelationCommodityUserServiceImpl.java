package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.CommodityMapper;
import cn.ky.jzk.mapper.RelationCommodityUserMapper;
import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.mapper.UserMapper;
import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.RelationCommodityUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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

    @Autowired
    private CommodityMapper commodityMapper;

    @Autowired
    private UserMapper userMapper;


    List<Commodity> commodities;

    List<User> users;


    @Override
    public void insert(String userName, String comId) {
        relationCommodityUserMapper.insert(userName, comId);
    }

    @Override
    public List<Commodity> selectByName(String userName) {
        commodities.clear();
        List<String> res = relationCommodityUserMapper.selectByName(userName);
        for (String str : res) {
            commodities.add(commodityMapper.selectById(str));
        }
        if (commodities.size() == 0) {
            return null;
        }
        return commodities;
    }

    @Override
    public User selectById(String comId) {
        String res = relationCommodityUserMapper.selectById(comId);
        if (res == null && "".equals(res)) {
            return null;
        }
        return userMapper.selectByName(res);
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
