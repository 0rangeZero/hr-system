package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Post;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.vo.PostQueryVo;

public interface PostService extends IService<Post> {

    // 获取职位分页列表
    IPage<Post> selectPage(Page<Post> pageParam, PostQueryVo postQueryVo);

    // 更新状态
    void updateStatus(Long id, Integer status);

    // 根据职位名称查询职位信息
    Post selectByPostName(String postName);

}
