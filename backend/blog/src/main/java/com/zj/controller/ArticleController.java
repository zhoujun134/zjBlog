package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.dto.ArticleDTO;
import com.zj.domain.dto.ArticleQueryDTO;
import com.zj.domain.vo.*;
import com.zj.service.ArticleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/article")
@Api(tags = "文章信息")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @GetMapping("/hotArticleList")
    @ApiOperation(value = "获取热度前十的文章")
    public ResponseResult<List<HotArticleVo>> getHotArticleList() {
        return articleService.getHotArticleList();
    }

    @GetMapping("/articleList")
    @ApiOperation(value = "获取文章列表")
    public ResponseResult<PageVo<ArticleListVo>> getArticleList(@Valid ArticleQueryDTO articleQueryDTO){
        return articleService.getArticleList(articleQueryDTO);
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "获取文章详情")
    public ResponseResult<ArticleDetailsVo> getArticleDetail(@PathVariable("id") Long id) {
        return articleService.getArticleDetail(id);
    }

    @PostMapping
    @PreAuthorize("hasAuthority('article:add')")
    @ApiOperation(value = "发表文章")
    public ResponseResult<Long> addArticle(@Valid @RequestBody ArticleDTO article){
        return articleService.addArticle(article);
    }

    @PutMapping
    @PreAuthorize("hasAuthority('article:edit')")
    @ApiOperation(value = "编辑文章")
    public ResponseResult<Long> editArticle(@Valid @RequestBody ArticleDTO article){
        return articleService.editArticle(article);
    }

    @GetMapping("/count")
    @ApiOperation(value = "获取热度前十的文章")
    public ResponseResult<ArticleCountVo> getArticleCount(){
        return articleService.getArticleCount();
    }

    @PutMapping("/updateViewCount/{id}")
    @ApiOperation(value = "更新阅读数量")
    public ResponseResult<Boolean> updateViewCount(@PathVariable Long id){
        return articleService.updateViewCount(id);
    }

    @GetMapping("/previousNextArticle/{id}")
    @ApiOperation(value = "获取上一篇和下一篇文章")
    public ResponseResult<PreviousNextArticleVo> getPreviousNextArticle(@PathVariable Long id){
        return articleService.getPreviousNextArticle(id);
    }

}
