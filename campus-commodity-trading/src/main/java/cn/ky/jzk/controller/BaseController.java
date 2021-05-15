package cn.ky.jzk.controller;

import cn.ky.jzk.util.DateUtil;
import cn.ky.jzk.util.GlobalConstant;
import cn.ky.jzk.vo.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * @Author: Kevin
 * @Date: 2021/4/18 17:46
 */
@Component
public abstract class BaseController {
    /**
     * Do biz.
     * 事物
     *
     * @param choice the choice
     */
    void doBiz(int choice) {
    }

    /**
     * The Logger.
     */
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * The Request.
     * 请求
     */
    @Autowired
    protected HttpServletRequest request;

    /**
     * The Response.
     * 响应
     */
    @Autowired(required = false)
    protected HttpServletResponse response;

    /**
     * The Session.
     * 会话
     */
    @Autowired
    protected HttpSession session;


    /**
     * 获取失败信息
     *
     * @method: get fail result.
     * @param: <T> the type parameter
     * @param: code the code
     * @param: msg the msg
     * @return: fail result
     */
    protected <T> Response<T> getFailResult(Integer code, String msg) {
        return new Response<T>()
                .setCode(code)
                .setMessage(msg)
                .setSuccess(false)
                .setData(null)
                .setTimestamp(DateUtil.currentSecond());
    }


    /**
     * 获取成功信息
     *
     * @method: get success result.
     * @param: <T> the type parameter
     * @param: data the data
     * @return: success result
     */
    protected <T> Response<T> getSuccessResult(T data) {
        return new Response<T>()
                .setCode(200)
                .setMessage(GlobalConstant.REQUEST_SUCCESS)
                .setSuccess(true)
                .setData(data)
                .setTimestamp(DateUtil.currentSecond());
    }

    /**
     * 获取ID
     *
     * @method: get current user id.
     * @return: current user id
     */
    protected long getCurrentUserId() {
        return 1L;
    }

    protected <T> Response<T> dataAnalyse(T data, Integer code, String message) {
        if (data == null) {
            return getFailResult(code, message);
        } else {
            return getSuccessResult(data);
        }
    }
}
