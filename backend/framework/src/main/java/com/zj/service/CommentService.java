package com.zj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.CommentDTO;
import com.zj.domain.entity.Comment;
import com.zj.domain.vo.CommentVo;
import com.zj.domain.vo.PageVo;

/**
 * 评论表(CommentDTO)表服务接口
 */
public interface CommentService extends IService<Comment> {

    /**
     * 分页查询评论信息
     * @param articleId 文章ID
     * @param pageNum 分页号码
     * @param pageSize 页面大小
     * @return 分页结果
     */
    ResponseResult<PageVo<CommentVo>> getCommentList(Long articleId, Integer pageNum, Integer pageSize);

    /**
     * 添加评论信息
     * @param comment 待添加的评论信息
     * @return 是否添加成功
     */
    ResponseResult<Boolean> addComment(CommentDTO comment);

    /**
     * 点赞评论
     * @param commentId 评论 Id
     * @return 是否点赞成功
     */
    ResponseResult<Boolean> addLike(Long commentId);
}

