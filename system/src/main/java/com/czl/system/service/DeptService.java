package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.vo.DeptQueryVo;

public interface DeptService extends IService<Dept> {

    // 获取部门分页列表
    IPage<Dept> selectPage(Page<Dept> pageParam, DeptQueryVo deptQueryVo);

    // 更新部门状态
    void updateStatus(Long id, Integer status);

    // 根据部门名称查询部门信息
    Dept selectByDeptName(String deptName);

}
