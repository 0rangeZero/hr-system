package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.czl.model.vo.DeptQueryVo;
import com.czl.system.mapper.DeptMapper;
import com.czl.system.service.DeptService;
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
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Autowired
    private DeptMapper deptMapper;

    // 获取部门分页列表
    @Override
    public IPage<Dept> selectPage(Page<Dept> pageParam, DeptQueryVo deptQueryVo) {
        return deptMapper.selectPage(pageParam, deptQueryVo);
    }

    // 更新部门状态
    @Override
    public void updateStatus(Long id, Integer status) {
        Dept dept = deptMapper.selectById(id);
        dept.setStatus(status);
        deptMapper.updateById(dept);
    }

    // 根据部门名称查询部门信息
    @Override
    public Dept selectByDeptName(String deptName) {
        return deptMapper.selectOne(new QueryWrapper<Dept>().eq("dept_name", deptName));
    }

}
