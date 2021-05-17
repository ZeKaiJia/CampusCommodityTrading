package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.CommodityMapper;
import cn.ky.jzk.model.Commodity;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.CommodityService;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:33
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
public class CommodityServiceImpl extends AbstractService implements CommodityService {

    @Autowired
    private CommodityMapper commodityMapper;

    private Commodity temp;

    private List<Commodity> temps;

    @Override
    public Commodity insert(@NotNull Commodity commodity) {
        temp = commodityMapper.selectById(commodity.getComId());
        if (temp != null) {
            return null;
        }
        commodityMapper.insert(packageInfo(request, commodity, 1));
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
    public String deleteAllZero(String userName) {
        commodityMapper.deleteAllZero(userName);
        return "Success";
    }

    @Override
    public Commodity update(@NotNull Commodity commodity) {
        temp = commodityMapper.selectById(commodity.getComId());
        if (temp == null) {
            return null;
        }
        commodityMapper.update(packageInfo(request, commodity, 0));
        return commodity;
    }

    @Override
    public Commodity updateRate(String comId, Double rate) {
        temp = commodityMapper.selectById(comId);
        if (temp == null) {
            return null;
        }
        Double comRate = (temp.getComRate() * 1.0 * temp.getComRateCount() + rate);
        temp.setComRateCount(temp.getComRateCount() + 1);
        BigDecimal bg = new BigDecimal(comRate * 1.0 / temp.getComRateCount());
        comRate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        commodityMapper.updateRate(comId, comRate, temp.getComRateCount());
        return commodityMapper.selectById(comId);
    }

    @Override
    public List<Commodity> select() {
        temps = commodityMapper.select();
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public Commodity selectById(String comId) {
        return commodityMapper.selectById(comId);
    }

    @Override
    public List<Commodity> selectByName(String comName) {
        temps = commodityMapper.selectByName(comName);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public List<Commodity> selectByPriceBetween(Double min, Double max) {
        temps = commodityMapper.selectByPriceBetween(min, max);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public List<Commodity> selectByQuantityBetween(Integer min, Integer max) {
        temps = commodityMapper.selectByQuantityBetween(min, max);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public List<Commodity> selectByQuantityNow(Integer comQuantityNow) {
        temps = commodityMapper.selectByQuantityNow(comQuantityNow);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }

    @Override
    public List<Commodity> selectByAnyParam(String comId, String comName, Double minPrice, Double maxPrice, Integer minQuantity, Integer maxQuantity, String comDescription) {
        temps = commodityMapper.selectByAnyParam(comId, comName, minPrice, maxPrice, minQuantity, maxQuantity, comDescription);
        if (temps.size() == 0) {
            return null;
        }
        return temps;
    }
}
