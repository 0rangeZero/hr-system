package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.*;
import com.czl.model.vo.SalaryQueryVo;
import com.czl.system.mapper.SalaryMapper;
import com.czl.system.service.PayoffService;
import com.czl.system.service.SalaryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.czl.system.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class SalaryServiceImpl extends ServiceImpl<SalaryMapper, Salary> implements SalaryService {

    @Autowired
    private SalaryMapper salaryMapper;

    @Autowired
    private PayoffService payoffService;

    @Autowired
    private UserService userService;

    // 获取账套分页数据
    @Override
    public IPage<Salary> selectPage(Page<Salary> pageParam, SalaryQueryVo salaryQueryVo) {
        return salaryMapper.selectPage(pageParam, salaryQueryVo);
    }

    // 根据部门名称查询账套信息
    @Override
    public List<Salary> selectSalaryByDept(Dept dept) {
        return salaryMapper.selectList(new QueryWrapper<Salary>().eq("dept_id", dept.getDeptId()));
    }

    // 根据账套名称获取账套信息
    @Override
    public Salary selectSalaryByName(String salaryName) {
        return salaryMapper.selectOne(new QueryWrapper<Salary>().eq("salary_name", salaryName));
    }

    // 获取已发放工资员工id
    @Override
    public Long[] selectPaid(List<Long> idList) {
        List<Long> resList = new ArrayList<>();
        LocalDateTime ldt = LocalDateTime.now();
        String year = String.valueOf(ldt.getYear());
        String month = String.valueOf(ldt.getMonthValue());
        if (ldt.getMonthValue() < 10) month = "0" + month;
        for (Long id : idList) {
            List<Payoff> payList = payoffService.list(new QueryWrapper<Payoff>().eq("user_id", id));
            for (Payoff payoff : payList) {
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                String payTime = df.format(payoff.getCreateTime());
                if (payTime.substring(0, 4).equals(year) && payTime.substring(5, 7).equals(month)) {
                    resList.add(payoff.getUserId());
                }
            }
        }
        return resList.toArray(new Long[resList.size()]);
    }

    @Override
    public Collection<ExcelSalary> listSalaryData(Long userId) {
        List<User> users = userService.getExcelInfo(userId);
        ArrayList<ExcelSalary> excelSalaries = new ArrayList<>(users.size());
        users.forEach(user -> {
            ExcelSalary excelSalary = new ExcelSalary();
            BeanUtils.copyProperties(user, excelSalary);
            excelSalary.setSum(excelSalary.getBasicSalary()+excelSalary.getMeritPay()+excelSalary.getAllowance()
                               +excelSalary.getBonus()+excelSalary.getFinsurances());
            excelSalaries.add(excelSalary);
        });
        return excelSalaries;
    }

}