package com.zj.service;

import com.zj.domain.ResponseResult;
import com.zj.domain.dto.LoginUserDTO;
import com.zj.domain.vo.BlogUserLoginVo;

public interface BlogLoginService {

    ResponseResult<BlogUserLoginVo> login(LoginUserDTO user);

    ResponseResult<Boolean> logout();
}

