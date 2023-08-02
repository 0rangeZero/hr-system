package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Salary;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czl.model.vo.SalaryQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SalaryMapper extends BaseMapper<Salary> {

    // 获取账套分页数据
    IPage<Salary> selectPage(Page<Salary> page, @Param("vo") SalaryQueryVo salaryQueryVo);

}
