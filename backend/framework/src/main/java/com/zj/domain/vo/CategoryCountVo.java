package com.zj.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryCountVo {
    private String id;
    private String name;
    private Integer count;
    private String pid;
}
