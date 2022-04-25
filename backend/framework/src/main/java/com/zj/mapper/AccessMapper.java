package com.zj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zj.domain.entity.Access;

import java.util.List;

public interface AccessMapper extends BaseMapper<Access> {
    List<String> selectPermissionsByUserId(Long id);
}
