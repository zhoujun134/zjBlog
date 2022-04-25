package com.zj.service.impl.converter;

import com.zj.domain.entity.Category;
import com.zj.domain.vo.CategoryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author junzhou
 * @date 2022/4/13 10:51
 * @since 1.8
 */
@Mapper(componentModel = "spring")
public interface CategoryConverter {

    CategoryConverter INSTANCE = Mappers.getMapper(CategoryConverter.class);

    CategoryVo toVo(Category category);
}
