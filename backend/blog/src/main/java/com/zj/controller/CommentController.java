package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.domain.dto.CommentDTO;
import com.zj.domain.vo.CommentVo;
import com.zj.domain.vo.PageVo;
import com.zj.service.CommentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/comment")
@Api(tags = "评论信息")
public class CommentController {
    @Resource
    private CommentService commentService;

    @GetMapping("/commentList")
    @ApiOperation(value = "获取所有评论")
    public ResponseResult<PageVo<CommentVo>> getCommentList( String articleId,
                                                             Integer pageNum,
                                                             Integer pageSize){
        return commentService.getCommentList(articleId, pageNum, pageSize);
    }

    @PostMapping
    @ApiOperation(value = "添加评论")
    public ResponseResult<Boolean> addComment(@RequestBody CommentDTO comment){

        return commentService.addComment(comment);
    }

    @PutMapping("/like/{id}")
    @ApiOperation(value = "增加评论的喜欢数")
    public ResponseResult<Boolean> like(@PathVariable("id") String id){
        return commentService.addLike(id);
    }

}
