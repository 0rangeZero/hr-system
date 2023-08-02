package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Post;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czl.model.vo.PostQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PostMapper extends BaseMapper<Post> {

    IPage<Post> selectPage(Page<Post> page, @Param("vo") PostQueryVo postQueryVo);

}
