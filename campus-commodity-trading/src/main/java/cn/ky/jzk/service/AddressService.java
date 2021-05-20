package cn.ky.jzk.service;

import cn.ky.jzk.model.Address;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:25
 */
public interface AddressService {

    void insert(Address address);

    void delete(Integer id);

    void deleteByName(String userName);

    void update(Address address);

    List<Address> select();

    List<Address> selectByName(String userName);
}
