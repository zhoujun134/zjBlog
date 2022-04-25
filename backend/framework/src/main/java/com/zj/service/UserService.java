package com.zj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.UserDTO;
import com.zj.domain.entity.User;
import com.zj.domain.vo.UserInfoVo;

public interface UserService extends IService<User> {
    ResponseResult<UserInfoVo> getUserInfo();

    ResponseResult<UserInfoVo> getAdminInfo();

    ResponseResult<Boolean> register(User user);

    ResponseResult<Boolean> updateUserInfo(UserDTO user);
}
