package com.zj.service.impl;

import com.zj.domain.ResponseResult;
import com.zj.domain.vo.ArchiveCountVo;
import com.zj.domain.vo.ArchiveVo;
import com.zj.domain.vo.PageVo;
import com.zj.mapper.ArchiveMapper;
import com.zj.service.ArchiveService;
import com.zj.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArchiveServiceImpl implements ArchiveService {
    @Autowired
    private ArchiveMapper archiveMapper;

    @Autowired
    private ArticleService articleService;

    @Override
    public ResponseResult<PageVo<ArchiveCountVo>> getArchiveCountList(Integer pageNum, Integer pageSize) {
        Long total = archiveMapper.selectArchiveTotalCount();
        List<ArchiveCountVo> archiveCountVos = archiveMapper.selectArchiveCount((pageNum - 1) * pageSize, pageSize);
        return ResponseResult.okResult(new PageVo<>(total, archiveCountVos));
    }

    @Override
    public ResponseResult<PageVo<ArchiveVo>>  getArchiveList(Integer pageNum, Integer pageSize) {
        List<ArchiveVo> archiveVos = archiveMapper.selectArchiveList((pageNum - 1) * pageSize, pageSize);
        return ResponseResult.okResult(new PageVo<>(articleService.getNormalArticleCount(), archiveVos));
    }
}
