package com.zj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zj.domain.ResponseResult;
import com.zj.domain.entity.Tag;
import com.zj.domain.vo.TagCountVo;
import com.zj.domain.vo.TagVo;

import java.util.List;

public interface TagService extends IService<Tag> {

    ResponseResult<List<TagCountVo>> getTagCountList();

    TagVo getOrAddTagByName(String name);
}
