package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Clock;
import com.czl.model.vo.UserQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ClockMapper extends BaseMapper<Clock> {

    IPage<Clock> selectPage(Page<Clock> page, @Param("vo") UserQueryVo userQueryVo);

}
