package cn.ky.jzk.util;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

/**
 * The type String util
 * 字符串工具类
 * StringUtil
 * @author Daye
 */
public class StringUtil {

    /**
     * 去除字符串中的空格
     *
     * @param str 待处理的字符串
     * @return 去除空格后的字符串 string
     */
    public static String removeSpace(String str) {
        return str.trim();
    }

    /**
     * 判断是否是空
     *
     * @param str 待判断的字符串
     * @return 返回boolean boolean
     */
    public static boolean isEmpty(String str) {
        return (str == null || "".equals(str));
    }

    /**
     * 判断是否不是空
     *
     * @param str 待判断的字符串
     * @return 返回boolean boolean
     */
    public static boolean isNotEmpty(String str) {
        return (str != null) && !"".equals(str);
    }

    /**
     * 格式化模糊查询
     *
     * @param str 待处理的字符串
     * @return 返回处理完成的字符串 string
     */
    public static String formatLike(String str) {
        return "%" + str + "%";
    }

    /**
     * 过滤掉集合里的空格
     *
     * @param list 待处理的list
     * @return 返回处理完成的list list
     */
    public static List<String> filterSpaceFromList(List<String> list) {
        List<String> resultList = new ArrayList<>();
        for (String l : list) {
            if (isNotEmpty(l)) {
                resultList.add(removeSpace(l));
            }
        }
        return resultList;
    }

    /**
     * Apply sha 256 string.
     * 区块链加密算法
     * @param input the input
     * @return the string
     */
    public static String applySha256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
