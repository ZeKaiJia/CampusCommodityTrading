package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.CommodityMapper;
import cn.ky.jzk.mapper.RelationCommodityUserMapper;
import cn.ky.jzk.mapper.RelationRoleUserMapper;
import cn.ky.jzk.mapper.UserMapper;
import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.model.User;
import cn.ky.jzk.service.RelationCommodityUserService;
import cn.ky.jzk.service.RelationRoleUserService;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import sun.tools.jconsole.JConsole;

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


    List<Commodity> commodities = new ArrayList<Commodity>();

    List<User> users = new ArrayList<User>();


    @Override
    public void insert(String userName, String comId, Integer number) {
        Integer num =  relationCommodityUserMapper.selectQuantity(userName, comId);
        System.err.println(num);
        if (num == null) {
            relationCommodityUserMapper.insert(userName, comId, number);
        } else {
            relationCommodityUserMapper.deleteSingle(userName, comId);
            relationCommodityUserMapper.insert(userName, comId, num + number);
        }
    }

    @Override
    public List<Commodity> selectByName(String userName) {
        commodities.clear();
        List<String> res = relationCommodityUserMapper.selectByName(userName);
        for (String str : res) {
            commodities.add(commodityMapper.selectById(str));
        }
        return commodities;
    }

    @Override
    public List<User> selectById(String comId) {
        users.clear();
        List<String> res = relationCommodityUserMapper.selectById(comId);
        for (String str : res) {
            users.add(userMapper.selectByName(str));
        }
        return users;
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
