package cn.ky.jzk.util;

import org.jetbrains.annotations.NotNull;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author: Kevin
 * @Date: 2020/8/19 7:11 下午
 */
public class CorsUtil implements HandlerInterceptor {
    private static final String OPTIONS_FOR_REQUEST = "OPTIONS";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, @NotNull Object handler) throws Exception {
        // 设置编码格式
        response.setContentType("text/html;charset=UTF-8");
        // 允许哪些Origin发起跨域请求,nginx下正常
        response.setHeader( "Access-Control-Allow-Origin", request.getHeader("Origin"));
        // 允许请求的方法
        response.setHeader( "Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE" );
        // 多少秒内，不需要再发送预检验请求，可以缓存该结果
        response.setHeader( "Access-Control-Max-Age", "86400" );
        // 表明它允许跨域请求包含xxx头
        response.setHeader( "Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With," +
                "If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type," +
                "X-E4M-With,userId,token, Accept, Authorization" );
        // 允许浏览器携带用户身份信息（cookie）
        response.setHeader( "Access-Control-Allow-Credentials", "true" );
        response.setHeader("XDomainRequestAllowed","1");
        // 允许OPTIONS请求直接通过
        if (OPTIONS_FOR_REQUEST.equals((request).getMethod().toUpperCase())) {
            response.setStatus(HttpServletResponse.SC_OK);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }

    public static void setResponseHeader(HttpServletResponse response, HttpServletRequest request) {
        // 设置编码格式
        response.setContentType("text/html;charset=UTF-8");
        // 允许哪些Origin发起跨域请求,nginx下正常
        response.setHeader( "Access-Control-Allow-Origin", request.getHeader("Origin"));
        // 允许请求的方法
        response.setHeader( "Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE" );
        // 多少秒内，不需要再发送预检验请求，可以缓存该结果
        response.setHeader( "Access-Control-Max-Age", "86400" );
        // 表明它允许跨域请求包含xxx头
        response.setHeader( "Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With," +
                "If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type," +
                "X-E4M-With,userId,token, Accept, Authorization" );
        // 允许浏览器携带用户身份信息（cookie）
        response.setHeader( "Access-Control-Allow-Credentials", "true" );
        response.setHeader("XDomainRequestAllowed","1");
        // 允许OPTIONS请求直接通过
        if (OPTIONS_FOR_REQUEST.equals((request).getMethod().toUpperCase())) {
            response.setStatus(HttpServletResponse.SC_OK);
        }
    }
}
