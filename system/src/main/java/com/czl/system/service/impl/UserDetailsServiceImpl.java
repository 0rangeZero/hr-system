package com.czl.system.service.impl;

import com.czl.model.system.User;
import com.czl.system.custom.CustomUser;
import com.czl.system.exception.AccountStopException;
import com.czl.system.exception.MyException;
import com.czl.system.exception.MyUsernameException;
import com.czl.system.result.ResultCodeEnum;
import com.czl.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username.equals("")) {
            throw new MyException(ResultCodeEnum.NULL_USERNAME);
        }
        User user = userService.getByUsername(username);
        if (user == null) {
            throw new MyUsernameException(ResultCodeEnum.ACCOUNT_ERROR);
        }
        if (user.getStatus() == 0) {
            throw new AccountStopException(ResultCodeEnum.ACCOUNT_STOP);
        }
        return new CustomUser(user, Collections.emptyList());
    }

}
