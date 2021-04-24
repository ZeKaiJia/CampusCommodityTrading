package cn.ky.jzk.model;

import lombok.*;


/**
 * 用户实体类
 * User
 * 用户POJO类
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    /**
     * 用户名
     * The User name.
     */
    private String userName;
    /**
     * 密码
     * The User password.
     */
    private String userPassword;
    /**
     * 姓名
     * The User nick.
     */
    private String userNick;
    /**
     * 性别
     * The User gender.
     */
    private String userGender;
    /**
     * 电话
     * The User phone.
     */
    private String userPhone;
    /**
     * 邮箱
     * The User email.
     */
    private String userEmail;
    /**
     * 密保
     * The User quest.
     */
    private String userQuest;
    /**
     * 答案
     * The User answer.
     */
    private String userAnswer;
}
