package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Leave;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.vo.LeaveQueryVo;

public interface LeaveService extends IService<Leave> {

    // 查询当前用户分页
    IPage<Leave> selectPage(Page<Leave> pageParam, LeaveQueryVo leaveQueryVo);

    // 查询所有记录
    IPage<Leave> selectAllPage(Page<Leave> pageParam, LeaveQueryVo leaveQueryVo);

}
