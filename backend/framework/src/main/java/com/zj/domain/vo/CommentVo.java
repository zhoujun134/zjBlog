package com.zj.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentVo {

    private String id;
    /**
     * 评论内容
     */
    private String content;
    /**
     * 评论中的图片地址，非必需
     */
    private String imgSrc;

    /**
     * 点赞数，非必需
     */
    private Long likes;
    /**
     * 是否已点赞，非必需
     */
    private boolean liked;
    /**
     * 子评论（回复）人信息，非必需
     */
    private String reply;
    /**
     * 评论时间，必需
     */
    private Date createAt;

    private CommentUserVo user;

    private List<CommentVo> children;
}
