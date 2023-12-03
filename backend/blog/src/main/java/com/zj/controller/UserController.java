package com.zj.controller;


import com.zj.domain.ResponseResult;
import com.zj.domain.dto.UserDTO;
import com.zj.domain.entity.User;
import com.zj.domain.vo.UserInfoVo;
import com.zj.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/user")
@Api(tags = "用户信息")
public class UserController {

    @Resource
    private UserService userService;

    @GetMapping("/userInfo")
    @ApiOperation(value = "获取用户信息")
    public ResponseResult<UserInfoVo> getUserInfo(){
        return userService.getUserInfo();
    }

    @PutMapping("/userInfo")
    @ApiOperation(value = "更新用户信息")
    public ResponseResult<Boolean> updateUserInfo(@Valid @RequestBody UserDTO user){
        return userService.updateUserInfo(user);
    }

    @GetMapping("/adminInfo")
    @ApiOperation(value = "获取管理员信息")
    public ResponseResult<UserInfoVo> getAdminInfo(){
        return userService.getAdminInfo();
    }

    @PostMapping("/register")
    @ApiOperation(value = "注册用户")
    public ResponseResult<Boolean> register(@Valid @RequestBody User user){
        return userService.register(user);
    }
}
