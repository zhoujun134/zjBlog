package com.zj.service.impl.converter;

import com.zj.domain.entity.Tag;
import com.zj.domain.vo.TagVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author junzhou
 * @date 2022/4/18 22:10
 * @since 1.8
 */
@Mapper(componentModel = "spring")
public interface TagConverter {

    TagConverter INSTANCE = Mappers.getMapper(TagConverter.class);

    TagVo toVo(Tag tag);
}
