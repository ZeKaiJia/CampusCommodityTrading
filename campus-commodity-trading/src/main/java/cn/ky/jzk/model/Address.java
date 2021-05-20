package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 地址类
 * Role
 * 地址实体类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "地址实体类", description = "地址实体类")
public class Address extends BaseEntity {
    /**
     * 序号
     * The ID.
     */
    @ApiModelProperty(value="序号", example = "1", required = false)
    private Integer id;
    /**
     * 用户名
     * The User Name.
     */
    @ApiModelProperty(value="用户名", example = "Xb18620208", required = true)
    private String userName;
    /**
     * 地址
     * The Address.
     */
    @ApiModelProperty(value="地址", example = "浙江省绍兴市上虞区浙江理工大学科技与艺术学院", required = true)
    private String address;
}
