package cn.ky.jzk.mapper;

import cn.ky.jzk.model.Address;
import cn.ky.jzk.model.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:04
 */
@Repository
public interface AddressMapper {

    void insert(Address address);

    void delete(@Param("id") Integer id);

    void deleteByName(@Param("userName") String userName);

    void update(Address address);

    List<Address> select();

    List<Address> selectByName(@Param("userName") String userName);
}
