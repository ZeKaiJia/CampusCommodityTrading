package cn.ky.jzk.service.implement;

import cn.ky.jzk.mapper.AddressMapper;
import cn.ky.jzk.mapper.OrderMapper;
import cn.ky.jzk.model.Address;
import cn.ky.jzk.model.Order;
import cn.ky.jzk.service.AbstractService;
import cn.ky.jzk.service.AddressService;
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
public class AddressServiceImpl extends AbstractService implements AddressService {
    @Autowired
    AddressMapper addressMapper;

    private Address temp;

    private List<Address> temps;

    @Override
    public void insert(Address address) {
        addressMapper.insert(packageInfo(request, address, 1));
    }

    @Override
    public void delete(Integer id) {
        addressMapper.delete(id);
    }

    @Override
    public void update(Address address) {
        addressMapper.update(address);
    }

    @Override
    public List<Address> select() {
        return addressMapper.select();
    }

    @Override
    public List<Address> selectByName(String userName) {
        return addressMapper.selectByName(userName);
    }
}
