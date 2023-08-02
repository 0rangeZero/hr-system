package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Post;
import com.czl.model.vo.PostQueryVo;
import com.czl.system.mapper.PostMapper;
import com.czl.system.service.PostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author czl
 * @since 2023-04-21
 */
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {

    @Autowired
    private PostMapper postMapper;

    // 获取职位分页列表
    @Override
    public IPage<Post> selectPage(Page<Post> pageParam, PostQueryVo postQueryVo) {
        return postMapper.selectPage(pageParam, postQueryVo);
    }

    // 更新状态
    @Override
    public void updateStatus(Long id, Integer status) {
        Post post = postMapper.selectById(id);
        post.setStatus(status);
        postMapper.updateById(post);
    }

    // 根据职位名称查询职位信息
    @Override
    public Post selectByPostName(String postName) {
        return postMapper.selectOne(new QueryWrapper<Post>().eq("post_name", postName));
    }

}
