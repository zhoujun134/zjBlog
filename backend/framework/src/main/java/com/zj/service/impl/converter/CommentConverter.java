package com.zj.service.impl.converter;

import com.zj.domain.dto.CommentDTO;
import com.zj.domain.entity.Comment;
import com.zj.domain.vo.CommentVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @author junzhou
 * @date 2022/4/18 22:10
 * @since 1.8
 */
@Mapper(componentModel = "spring")
public interface CommentConverter {

    CommentConverter INSTANCE = Mappers.getMapper(CommentConverter.class);

    Comment toEntity(CommentDTO comment);

    @Mapping(source = "createTime", target = "createAt")
    @Mapping(source = "likeCount", target = "likes")
    CommentVo toVO(Comment comment);
}
