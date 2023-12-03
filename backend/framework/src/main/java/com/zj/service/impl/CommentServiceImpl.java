package com.zj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zj.constants.SystemConstants;
import com.zj.domain.ResponseResult;
import com.zj.domain.dto.CommentDTO;
import com.zj.domain.entity.User;
import com.zj.domain.vo.CommentUserVo;
import com.zj.domain.vo.CommentVo;
import com.zj.domain.vo.PageVo;
import com.zj.domain.vo.UserInfoVo;
import com.zj.mapper.CommentMapper;
import com.zj.domain.entity.Comment;
import com.zj.service.CommentService;
import com.zj.service.UserService;
import com.zj.service.impl.converter.CommentConverter;
import com.zj.service.impl.converter.UserConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 评论表(CommentDTO)表服务实现类
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {
    @Autowired
    private UserService userService;

    @Override
    public ResponseResult<PageVo<CommentVo>> getCommentList(String articleId, Integer pageNum, Integer pageSize) {
        // 查询所有根评论
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comment::getArticleId, articleId);
        wrapper.eq(Comment::getRootId, SystemConstants.COMMENT_ROOT);

        Page<Comment> page = new Page<>(pageNum, pageSize);
        this.page(page, wrapper);

        List<Comment> comments = page.getRecords();
        List<CommentVo> commentVos = getCommentVos(comments);

        // 查询所有子评论
        commentVos.forEach(i -> i.setChildren(getChildren(i.getId())));
        return ResponseResult.okResult(new PageVo<>(page.getTotal(), commentVos));
    }

    @Override
    public ResponseResult<Boolean> addComment(CommentDTO comment) {
        Comment entity = CommentConverter.INSTANCE.toEntity(comment);
        ResponseResult<UserInfoVo> userInfo = userService.getUserInfo();
        int insert = baseMapper.insert(entity);
        return ResponseResult.okResult(insert > 0);
    }

    private List<CommentVo> getChildren(String id) {
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comment::getToCommentId, id);
        List<Comment> comments = list(wrapper);
        return getCommentVos(comments);
    }

    private List<CommentVo> getCommentVos(List<Comment> comments) {

        return comments.stream()
                .map(comment -> {
                    CommentVo commentVo = CommentConverter.INSTANCE.toVO(comment);
                    User user = userService.getById(comment.getCreateBy());
                    CommentUserVo commentUser = UserConverter.INSTANCE.toCommentUser(user);
                    commentVo.setUser(commentUser);
                    return commentVo;
                }).collect(Collectors.toList());

    }

    @Override
    public ResponseResult<Boolean> addLike(String commentId) {
        Comment comment = this.getById(commentId);
        if (Objects.isNull(comment)) {
            return ResponseResult.okResult(Boolean.FALSE);
        }
        comment.setLikeCount(comment.getLikeCount() + 1);
        boolean result = this.updateById(comment);
        return ResponseResult.okResult(result);
    }
}

