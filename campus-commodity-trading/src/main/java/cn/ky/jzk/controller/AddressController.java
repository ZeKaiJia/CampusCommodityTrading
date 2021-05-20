package cn.ky.jzk.controller;

import cn.ky.jzk.model.Address;
import cn.ky.jzk.model.Role;
import cn.ky.jzk.service.AddressService;
import cn.ky.jzk.service.RelationRoleUserService;
import cn.ky.jzk.service.RoleService;
import cn.ky.jzk.swagger.api.AddressControllerApi;
import cn.ky.jzk.swagger.api.RoleControllerApi;
import cn.ky.jzk.vo.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:43
 */
@CrossOrigin
@RestController()
@RequestMapping("/address/")
public class AddressController extends BaseController implements AddressControllerApi {

    @Autowired
    @Qualifier("addressServiceImpl")
    private AddressService addressService;

    private Address temp;

    List<Address> temps;

    @Override
    @PostMapping(value = "/insert")
    @ResponseBody
    public Response<String> insert(@RequestBody Address address) {
        addressService.insert(address);
        return dataAnalyse("Success", 404, "插入失败");
    }

    @Override
    @PostMapping(value = "/delete")
    @ResponseBody
    public Response<String> delete(@RequestParam Integer id) {
        addressService.delete(id);
        return dataAnalyse("Success", 404, "删除失败");
    }

    @Override
    @PostMapping(value = "/deleteByName")
    @ResponseBody
    public Response<String> deleteByName(@RequestParam String username) {
        addressService.deleteByName(username);
        return dataAnalyse("Success", 404, "删除失败");
    }

    @Override
    @PostMapping(value = "/update")
    @ResponseBody
    public Response<String> update(@RequestBody Address address) {
        addressService.update(address);
        return dataAnalyse("Success", 404, "更新失败");
    }

    @Override
    @GetMapping(value = "/select")
    @ResponseBody
    public Response<List<Address>> select() {
        temps = addressService.select();
        return dataAnalyse(temps, 404, "未找到数据");
    }



    @Override
    @GetMapping(value = "/selectByName")
    @ResponseBody
    public Response<List<Address>> selectByName(@RequestParam String userName) {
        temps =  addressService.selectByName(userName);
        return dataAnalyse(temps, 404, "未找到数据");
    }
}
