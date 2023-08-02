package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Leave;
import com.czl.model.vo.LeaveQueryVo;
import com.czl.system.mapper.LeaveMapper;
import com.czl.system.service.LeaveService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service
public class LeaveServiceImpl extends ServiceImpl<LeaveMapper, Leave> implements LeaveService {

    @Autowired
    private LeaveMapper leaveMapper;

    // 获取请假申请分页列表
    @Override
    public IPage<Leave> selectPage(Page<Leave> pageParam, LeaveQueryVo leaveQueryVo) {
        return leaveMapper.selectPage(pageParam, leaveQueryVo);
    }

    // 获取所有请假申请分页列表
    @Override
    public IPage<Leave> selectAllPage(Page<Leave> pageParam, LeaveQueryVo leaveQueryVo) {
        return leaveMapper.selectAllPage(pageParam, leaveQueryVo);
    }

}
