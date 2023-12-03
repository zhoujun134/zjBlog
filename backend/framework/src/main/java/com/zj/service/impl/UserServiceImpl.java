package com.zj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zj.constants.SystemConstants;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.UserDTO;
import com.zj.domain.entity.User;
import com.zj.domain.vo.UserInfoVo;
import com.zj.enums.AppHttpCodeEnum;
import com.zj.exception.SystemException;
import com.zj.mapper.UserMapper;
import com.zj.service.UserService;
import com.zj.utils.Assert;
import com.zj.utils.BeanCopyUtils;
import com.zj.utils.SecurityUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private PasswordEncoder passwordEncoder;

    @Override
    public ResponseResult<UserInfoVo> getUserInfo() {
        Long userId = SecurityUtils.getUserId();

        User user = getById(userId);
        if (user != null) {
            return ResponseResult.okResult(BeanCopyUtils.copyBean(user, UserInfoVo.class));
        }

        return ResponseResult.errorResult(AppHttpCodeEnum.NEED_LOGIN);
    }

    @Override
    public ResponseResult<UserInfoVo> getAdminInfo() {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getType, SystemConstants.ADMIN_USER);
        User user = getOne(wrapper, false);
        return ResponseResult.okResult(BeanCopyUtils.copyBean(user, UserInfoVo.class));
    }

    @Override
    public ResponseResult<Boolean> register(User user) {
        // 查询用户是否已经存在
        LambdaQueryWrapper<User> sameNameWrapper = new LambdaQueryWrapper<>();
        sameNameWrapper.eq(User::getUserName, user.getUserName());
        User sameNameUser = getOne(sameNameWrapper);
        Assert.isNull(sameNameUser, AppHttpCodeEnum.USERNAME_EXIST);

        // 查询邮箱是否已经存在
        LambdaQueryWrapper<User> sameEmailWrapper = new LambdaQueryWrapper<>();
        sameEmailWrapper.eq(User::getEmail, user.getEmail());
        User sameEmailUser = getOne(sameEmailWrapper);
        Assert.isNull(sameEmailUser, AppHttpCodeEnum.EMAIL_EXIST);

        // 添加用户
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        save(user);
        return ResponseResult.okResult(Boolean.TRUE);
    }

    @Override
    public ResponseResult<Boolean> updateUserInfo(UserDTO user) {
        // 查询邮箱是否已经存在
        LambdaQueryWrapper<User> sameEmailWrapper = new LambdaQueryWrapper<>();
        sameEmailWrapper.eq(User::getEmail, user.getEmail());
        User sameEmailUser = getOne(sameEmailWrapper);
        if (sameEmailUser != null && !user.getId().equals(sameEmailUser.getId())) {
            throw new SystemException(AppHttpCodeEnum.EMAIL_EXIST);
        }

        updateById(BeanCopyUtils.copyBean(user, User.class));
        return ResponseResult.okResult(Boolean.TRUE);
    }
}
