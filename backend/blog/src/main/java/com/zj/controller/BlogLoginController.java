package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.dto.LoginUserDTO;
import com.zj.domain.vo.BlogUserLoginVo;
import com.zj.service.BlogLoginService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@Api(tags = "用户登录信息")
public class BlogLoginController {
    @Resource
    private BlogLoginService blogLoginService;

    @PostMapping("/login")
    @ApiOperation(value = "用户登录")
    public ResponseResult<BlogUserLoginVo> login(@Valid @RequestBody LoginUserDTO user) {
        return blogLoginService.login(user);
    }

    @PostMapping("/logout")
    @ApiOperation(value = "注销")
    public ResponseResult<Boolean> logout() {
        return blogLoginService.logout();
    }
}
