package cn.ky.jzk.shiro;

import cn.ky.jzk.util.CorsUtil;
import cn.ky.jzk.util.DateUtil;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.web.filter.authc.UserFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: Kevin
 * @Date: 2020/8/4 2:06 下午
 */
public class CorsAuthenticationFilter extends UserFilter {
    private static final String OPTIONS_FOR_REQUEST = "OPTIONS";

    public CorsAuthenticationFilter() {
        super();
    }

    @Override
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        if (OPTIONS_FOR_REQUEST.equals(((HttpServletRequest) request).getMethod().toUpperCase())) {
            return true;
        }
        return super.isAccessAllowed(request, response, mappedValue);
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletResponse res = (HttpServletResponse)response;
        HttpServletRequest req = (HttpServletRequest)request;
        CorsUtil.setResponseHeader(res, req);
        res.setStatus(HttpServletResponse.SC_OK);
        PrintWriter writer = res.getWriter();
        Map<String, Object> map= new HashMap<>(16);
        map.put("success", false);
        map.put("code", 702);
        map.put("message", "用户未登录");
        map.put("timestamp", DateUtil.currentSecond());
        writer.write(JSON.toJSONString(map));
        writer.close();
        return false;
    }
}
