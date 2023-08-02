package com.czl.system.controller;

import com.czl.model.system.User;
import com.czl.model.vo.LoginVo;
import com.czl.system.exception.MyException;
import com.czl.system.result.Result;
import com.czl.system.result.ResultCodeEnum;
import com.czl.system.service.UserService;
import com.czl.system.utils.JwtHelper;
import com.czl.system.utils.MD5;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Api(tags = "登录接口")
@CrossOrigin
@RestController
@RequestMapping("/system/index")
public class IndexController {

    @Autowired
    private UserService userService;

    /**
     * 登录
     * @return
     */
    @ApiOperation("登录")
    @PostMapping("/login")
    public Result login(@RequestBody LoginVo loginVo) {
        User user = userService.getByUsername(loginVo.getUsername());

        if(null == user) {
            throw new MyException(ResultCodeEnum.ACCOUNT_ERROR);
        }
        if(!MD5.encrypt(loginVo.getPassword()).equals(user.getPassword())) {
            throw new MyException(ResultCodeEnum.PASSWORD_ERROR);
        }
        if(user.getStatus().intValue() == 0) {
            throw new MyException(ResultCodeEnum.ACCOUNT_STOP);
        }

        Map<String, Object> map = new HashMap<>();
        map.put("token", JwtHelper.createToken(user.getUserId(), user.getUserName()));
        return Result.ok(map);
    }

    /**
     * 获取用户信息
     * @return
     */
    @ApiOperation("获取用户信息")
    @GetMapping("/info")
    public Result info(HttpServletRequest request) {
        String username = JwtHelper.getUsername(request.getHeader("token"));
        Map<String, Object> map = userService.getUserInfo(username);
        return Result.ok(map);
    }

    /**
     * 退出
     * @return
     */
    @PostMapping("/logout")
    public Result logout(){
        return Result.ok();
    }

}
