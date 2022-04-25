package com.zj.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentUserVo {
    private Long id;

    private String userName;

    private String nickName;

    private String signature;

    private String avatar;

    private Boolean author;

}
