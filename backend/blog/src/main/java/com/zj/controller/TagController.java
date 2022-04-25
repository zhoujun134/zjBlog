package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.vo.TagCountVo;
import com.zj.service.TagService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/tag")
@Api(tags = "标签信息")
public class TagController {
    @Autowired
    private TagService tagService;

    @GetMapping("/tagCountList")
    @ApiOperation(value = "获取所有标签和他包含的文章数量")
    public ResponseResult<List<TagCountVo>> getTagCountList(){
        return tagService.getTagCountList();
    }
}
