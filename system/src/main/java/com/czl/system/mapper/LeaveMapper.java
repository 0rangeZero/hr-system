package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Leave;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czl.model.vo.LeaveQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LeaveMapper extends BaseMapper<Leave> {

    IPage<Leave> selectPage(Page<Leave> page, @Param("vo") LeaveQueryVo leaveQueryVo);

    IPage<Leave> selectAllPage(Page<Leave> pageParam, @Param("vo") LeaveQueryVo leaveQueryVo);

}
