package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.vo.CategoryCountVo;
import com.zj.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/category")
@Api(tags = "文章分类信息")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/categoryCountList")
    @ApiOperation(value = "获取分类及其包含的文章数量")
    public ResponseResult<List<CategoryCountVo>> getCategoryCountList(){
        return categoryService.getCategoryCountList();
    }
}
