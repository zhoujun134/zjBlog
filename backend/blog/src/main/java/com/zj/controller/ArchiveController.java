package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.vo.ArchiveCountVo;
import com.zj.domain.vo.ArchiveVo;
import com.zj.domain.vo.PageVo;
import com.zj.service.ArchiveService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/archive")
@Api(tags = "文章归档信息")
public class ArchiveController {
    @Autowired
    private ArchiveService archiveService;

    @GetMapping("/archiveCountList")
    @ApiOperation(value = "获取归档及其包含的文章数量")
    public ResponseResult<PageVo<ArchiveCountVo>> getArchiveCountList(Integer pageNum, Integer pageSize){
        return archiveService.getArchiveCountList(pageNum, pageSize);
    }

    @GetMapping("/archiveList")
    @ApiOperation(value = "获取归档列表")
    public ResponseResult<PageVo<ArchiveVo>> getArchiveList(Integer pageNum, Integer pageSize){
        return archiveService.getArchiveList(pageNum, pageSize);
    }
}
