package com.zj.service.impl;

import com.zj.constants.SystemConstants;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.LoginUserDTO;
import com.zj.domain.entity.LoginUser;
import com.zj.domain.vo.BlogUserLoginVo;
import com.zj.domain.vo.UserInfoVo;
import com.zj.enums.AppHttpCodeEnum;
import com.zj.service.BlogLoginService;
import com.zj.utils.Assert;
import com.zj.utils.BeanCopyUtils;
import com.zj.utils.JwtUtil;
import com.zj.utils.RedisCache;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class BlogLoginServiceImpl implements BlogLoginService {
    @Resource
    private AuthenticationManager authenticationManager;

    @Resource
    private RedisCache redisCache;

    @Override
    public ResponseResult<BlogUserLoginVo> login(LoginUserDTO user) {
        // 验证用户名和密码
        UsernamePasswordAuthenticationToken authenticationToken = new
                UsernamePasswordAuthenticationToken(user.getUserName(), user.getPassword());
        Authentication authentication = authenticationManager.authenticate(authenticationToken);
        Assert.notNull(authentication, AppHttpCodeEnum.LOGIN_ERROR);

        // 将用户信息存入 redis
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        String userId = loginUser.getUser().getId().toString();
        String token = JwtUtil.createJWT(userId);
        redisCache.setCacheObject(SystemConstants.REDIS_USER_ID_PREFIX + userId, loginUser);

        // 将 token 和用户信息返回给用户
        UserInfoVo userInfo = BeanCopyUtils.copyBean(loginUser.getUser(), UserInfoVo.class);
        userInfo.setIsAdmin(SystemConstants.ADMIN_USER.equals(loginUser.getUser().getType()));
        BlogUserLoginVo blogUserLoginVo = new BlogUserLoginVo(token, userInfo);
        return ResponseResult.okResult(blogUserLoginVo);
    }

    @Override
    public ResponseResult<Boolean> logout() {
        // 获取 userId
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        String userId = loginUser.getUser().getId().toString();

        // 从 redis 中删除用户信息
        redisCache.deleteObject(SystemConstants.REDIS_USER_ID_PREFIX + userId);
        return ResponseResult.okResult(Boolean.TRUE);
    }
}
