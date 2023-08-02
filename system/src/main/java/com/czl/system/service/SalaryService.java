package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.czl.model.system.ExcelSalary;
import com.czl.model.system.Salary;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.vo.SalaryQueryVo;

import java.util.Collection;
import java.util.List;

public interface SalaryService extends IService<Salary> {

    // 获取账套分页数据
    IPage<Salary> selectPage(Page<Salary> pageParam, SalaryQueryVo salaryQueryVo);

    // 根据部门信息查询账套信息
    List<Salary> selectSalaryByDept(Dept dept);

    // 根据账套名称获取账套信息
    Salary selectSalaryByName(String salaryName);

    // 获取已发放工资员工id
    Long[] selectPaid(List<Long> idList);

    // 获取list类型数据
    Collection<ExcelSalary> listSalaryData(Long userId);

}
