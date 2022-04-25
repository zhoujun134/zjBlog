package com.zj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zj.domain.ResponseResult;
import com.zj.domain.entity.Article;
import com.zj.domain.entity.ArticleTag;
import com.zj.domain.entity.Tag;
import com.zj.domain.vo.TagCountVo;
import com.zj.domain.vo.TagVo;
import com.zj.mapper.ArticleTagMapper;
import com.zj.mapper.TagMapper;
import com.zj.service.ArticleService;
import com.zj.service.TagService;
import com.zj.service.impl.converter.TagConverter;
import com.zj.utils.BeanCopyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class TagServiceImpl extends ServiceImpl<TagMapper, Tag> implements TagService {
    @Autowired
    private ArticleService articleService;

    @Autowired
    private ArticleTagMapper articleTagMapper;

    @Override
    public ResponseResult<List<TagCountVo>> getTagCountList() {
        // 查询出所有非草稿文章携带的标签 id
        List<Article> articles = articleService.listNormalArticle();
        List<Long> articleIds = articles.stream().map(Article::getId).collect(Collectors.toList());
        QueryWrapper<ArticleTag> articleTagWrapper = new QueryWrapper<>();
        articleTagWrapper.in("article_id", articleIds);
        articleTagWrapper.select("tag_id", "count(*) as count").groupBy("tag_id");
        List<ArticleTag> articleTags = articleTagMapper.selectList(articleTagWrapper);

        // 获取标签名和标签出现次数
        Map<Long, Integer> tagCountMap = articleTags.stream()
                .collect(Collectors.toMap(ArticleTag::getTagId, ArticleTag::getCount));
        LambdaQueryWrapper<Tag> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(Tag::getId, tagCountMap.keySet());
        List<TagCountVo> tagVos = BeanCopyUtils.copyBeanList(list(wrapper), TagCountVo.class);
        tagVos.forEach(tagVo -> tagVo.setCount(tagCountMap.get(tagVo.getId())));

        return ResponseResult.okResult(tagVos);
    }

    @Override
    public TagVo getOrAddTagByName(String name) {
        LambdaQueryWrapper<Tag> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Tag::getName, name);
        Tag tag = getOne(wrapper);

        if (tag == null) {
            tag = new Tag();
            tag.setName(name);
            save(tag);
        }

        return TagConverter.INSTANCE.toVo(tag);
    }
}
