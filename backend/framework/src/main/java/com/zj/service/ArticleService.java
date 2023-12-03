package com.zj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.ArticleDTO;
import com.zj.domain.dto.ArticleQueryDTO;
import com.zj.domain.entity.Article;
import com.zj.domain.vo.*;

import java.util.List;

/**
 * 文章表(Article)表服务接口
 */
public interface ArticleService extends IService<Article> {
    List<Article> listNormalArticle();
    Long getNormalArticleCount();

    ResponseResult<List<HotArticleVo>> getHotArticleList();

    ResponseResult<PageVo<ArticleListVo>> getArticleList(ArticleQueryDTO articleQueryDTO);

    ResponseResult<ArticleDetailsVo> getArticleDetail(String id);

    ResponseResult<ArticleCountVo> getArticleCount();

    ResponseResult<Boolean> updateViewCount(String id);

    ResponseResult<PreviousNextArticleVo> getPreviousNextArticle(String id);

    ResponseResult<String> addArticle(ArticleDTO article);

    ResponseResult<String> editArticle(ArticleDTO article);
}

