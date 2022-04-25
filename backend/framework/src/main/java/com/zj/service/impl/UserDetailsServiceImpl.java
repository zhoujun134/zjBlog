package com.zj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zj.domain.entity.LoginUser;
import com.zj.domain.entity.User;
import com.zj.enums.AppHttpCodeEnum;
import com.zj.mapper.AccessMapper;
import com.zj.mapper.UserMapper;
import com.zj.utils.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AccessMapper accessMapper;

    @Override
    public UserDetails loadUserByUsername(String userName) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUserName, userName);
        User user = userMapper.selectOne(wrapper);
        Assert.notNull(user, AppHttpCodeEnum.LOGIN_ERROR);

        List<String> permissions = accessMapper.selectPermissionsByUserId(user.getId());

        return new LoginUser(user, permissions);
    }
}
