package com.zj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zj.domain.ResponseResult;
import com.zj.domain.entity.Category;
import com.zj.domain.vo.CategoryCountVo;
import com.zj.domain.vo.CategoryVo;

import java.util.List;


/**
 * 分类表(Category)表服务接口
 */
public interface CategoryService extends IService<Category> {

    ResponseResult<List<CategoryCountVo>> getCategoryCountList();

    CategoryVo getOrAddCategoryByName(String name);
}

