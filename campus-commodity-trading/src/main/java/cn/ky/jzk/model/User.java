package cn.ky.jzk.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;


/**
 * 用户实体类
 * User
 * 用户实体类
 * @author kevin
 */
@Data
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "用户实体类", description = "用户实体类")
public class User extends BaseEntity {
    /**
     * 用户名
     * The User name.
     */
    @ApiModelProperty(value="用户名", example = "Xb18620208", required = true)
    private String userName;
    /**
     * 密码
     * The User password.
     */
    @ApiModelProperty(value="密码", example = "123456", required = true)
    private String userPassword;
    /**
     * 姓名
     * The User nick.
     */
    @ApiModelProperty(value="姓名", example = "贾泽楷", required = true)
    private String userNick;
    /**
     * 性别
     * The User gender.
     */
    @ApiModelProperty(value="性别", example = "男", required = true)
    private String userGender;
    /**
     * 电话
     * The User phone.
     */
    @ApiModelProperty(value="电话", example = "13506839371", required = false)
    private String userPhone;
    /**
     * 邮箱
     * The User email.
     */
    @ApiModelProperty(value="邮箱", example = "jiazekai1003@gmail.com", required = false)
    private String userEmail;
    /**
     * 密保
     * The User quest.
     */
    @ApiModelProperty(value="密保", example = "您的大学叫什么？", required = true)
    private String userQuest;
    /**
     * 答案
     * The User answer.
     */
    @ApiModelProperty(value="答案", example = "科艺", required = true)
    private String userAnswer;
    /**
     * 用户头像
     * The User Avatar.
     */
    @ApiModelProperty(value="用户头像", example = "https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg", required = false)
    private String userAvatar;

    /**
     * 最近登录时间
     * The User Last Login.
     */
    @ApiModelProperty(value="最近登录时间", example = "1621074167413", required = false)
    private long userLastLogin;
}
