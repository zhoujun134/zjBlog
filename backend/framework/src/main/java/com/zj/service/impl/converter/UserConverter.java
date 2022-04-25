package com.zj.service.impl.converter;

import com.zj.domain.entity.User;
import com.zj.domain.vo.CommentUserVo;
import com.zj.domain.vo.UserInfoVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author junzhou
 * @date 2022/4/18 22:10
 * @since 1.8
 */
@Mapper(componentModel = "spring")
public interface UserConverter {

    UserConverter INSTANCE = Mappers.getMapper(UserConverter.class);

    UserInfoVo toVO(User user);

    CommentUserVo toCommentUser(User user);
}
