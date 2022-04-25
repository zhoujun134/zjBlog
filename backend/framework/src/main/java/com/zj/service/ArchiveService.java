package com.zj.service;

import com.zj.domain.ResponseResult;
import com.zj.domain.vo.ArchiveCountVo;
import com.zj.domain.vo.ArchiveVo;
import com.zj.domain.vo.PageVo;

public interface ArchiveService {
    ResponseResult<PageVo<ArchiveCountVo>> getArchiveCountList(Integer pageNum, Integer pageSize);
    ResponseResult<PageVo<ArchiveVo>> getArchiveList(Integer pageNum, Integer pageSize);
}
