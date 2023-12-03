package com.zj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zj.constants.SystemConstants;
import com.zj.domain.ResponseResult;
import com.zj.domain.entity.Article;
import com.zj.domain.entity.Category;
import com.zj.domain.vo.CategoryCountVo;
import com.zj.domain.vo.CategoryVo;
import com.zj.mapper.CategoryMapper;
import com.zj.service.ArticleService;
import com.zj.service.CategoryService;
import com.zj.service.impl.converter.CategoryConverter;
import com.zj.utils.BeanCopyUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 分类表(Category)表服务实现类
 *
 * @author makejava
 * @since 2022-02-27 15:05:37
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

    @Resource
    private ArticleService articleService;

    @Override
    public ResponseResult<List<CategoryCountVo>> getCategoryCountList() {
        // 从数据库中查询非草稿的文章的目录 id
        List<Article> articles = articleService.listNormalArticle();
        Set<String> categoryIds = articles.stream().map(Article::getCategoryId).collect(Collectors.toSet());

        // 从数据库中查询目录
        LambdaQueryWrapper<Category> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(Category::getId, categoryIds);
        queryWrapper.eq(Category::getStatus, SystemConstants.Category_STATUS_NORMAL);
        List<Category> categories = list(queryWrapper);
        List<CategoryCountVo> categoryVos = BeanCopyUtils.copyBeanList(categories, CategoryCountVo.class);

        // 统计每种分类的数量
        Map<String, Integer> categoryIdCountMap = new HashMap<>();
        for (Article article : articles) {
            String categoryId = article.getCategoryId();
            Integer count = categoryIdCountMap.get(categoryId);
            categoryIdCountMap.put(categoryId, count == null ? 1 : count + 1);
        }

        for (CategoryCountVo categoryVo : categoryVos) {
            categoryVo.setCount(categoryIdCountMap.get(categoryVo.getId()));
        }

        return ResponseResult.okResult(categoryVos);
    }

    @Override
    public CategoryVo getOrAddCategoryByName(String name) {
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Category::getName, name);
        Category category = getOne(wrapper);

        if (category == null) {
            category = new Category();
            category.setName(name);
            save(category);
        }

        return CategoryConverter.INSTANCE.toVo(category);
    }
}

