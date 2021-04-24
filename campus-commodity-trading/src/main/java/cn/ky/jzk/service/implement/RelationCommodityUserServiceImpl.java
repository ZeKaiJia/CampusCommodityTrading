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

    @Override
    public void insert(String userName, String comId) {
        relationCommodityUserMapper.insert(userName, comId);
    }

    @Override
    public List<Commodity> select(String userName) {
        return relationCommodityUserMapper.select(userName);
    }

    @Override
    public void delete(String comId) {
        relationCommodityUserMapper.delete(comId);
    }

    @Override
    public void deleteAll(String userName) {
        relationCommodityUserMapper.deleteAll(userName);
    }
}
