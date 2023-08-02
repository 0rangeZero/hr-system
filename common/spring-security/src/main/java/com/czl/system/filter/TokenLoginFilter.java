package com.czl.system.filter;

import com.czl.model.vo.LoginVo;
import com.czl.system.custom.CustomUser;
import com.czl.system.exception.AccountStopException;
import com.czl.system.exception.MyUsernameException;
import com.czl.system.result.Result;
import com.czl.system.result.ResultCodeEnum;
import com.czl.system.utils.JwtHelper;
import com.czl.system.utils.ResponseUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import com.czl.system.exception.MyException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class TokenLoginFilter extends UsernamePasswordAuthenticationFilter {

    private String pwd;

    public TokenLoginFilter(AuthenticationManager authenticationManager) {
        this.setAuthenticationManager(authenticationManager);
        this.setPostOnly(false);
        //指定登录接口及提交方式，可以指定任意路径
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/system/index/login","POST"));
    }

    /**
     * 登录认证
     * @param request
     * @param response
     * @return
     * @throws AuthenticationException
     */
    @SneakyThrows
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response) throws AuthenticationException {
        LoginVo loginVo = new ObjectMapper().readValue(request.getInputStream(), LoginVo.class);
        pwd = loginVo.getPassword();
        Authentication authenticationToken =
                new UsernamePasswordAuthenticationToken(loginVo.getUsername(), loginVo.getPassword());
        return this.getAuthenticationManager().authenticate(authenticationToken);
    }

    /**
     * 登录成功
     * @param request
     * @param response
     * @param chain
     * @param auth
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication auth) throws IOException, ServletException {
        // 获取认证对象
        CustomUser customUser = (CustomUser)auth.getPrincipal();
        // 生成token
        String token =
                JwtHelper.createToken(customUser.getUser().getUserId(), customUser.getUser().getUserName());
        // 返回token
        Map<String, Object> map = new HashMap<>();
        map.put("token", token);
        ResponseUtil.out(response, Result.ok(map));
    }

    /**
     * 登录失败
     * @param request
     * @param response
     * @param e
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
                                              AuthenticationException e) throws IOException, ServletException {
        if(e.getCause() instanceof MyException) {
            ResponseUtil.out(response, Result.build(null, ResultCodeEnum.NULL_USERNAME)); // 用户名为空
        } else if (e.getCause() instanceof AccountStopException) {
            ResponseUtil.out(response, Result.build(null, ResultCodeEnum.ACCOUNT_STOP)); // 账号停用
        } else if (e.getCause() instanceof MyUsernameException) {
            ResponseUtil.out(response, Result.build(null, ResultCodeEnum.LOGIN_MOBLE_ERROR)); // 用户名不正确
        } else if (pwd.equals("")) {
            ResponseUtil.out(response, Result.build(null, ResultCodeEnum.NULL_PASSWORD)); // 密码为空
        } else {
            ResponseUtil.out(response, Result.build(null, ResultCodeEnum.PASSWORD_ERROR)); // 密码不正确
        }
    }

}
