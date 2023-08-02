package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.czl.model.system.Clock;
import com.czl.model.system.ExcelClock;
import com.czl.model.vo.UserQueryVo;
import com.czl.system.mapper.ClockMapper;
import com.czl.system.service.ClockService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class ClockServiceImpl extends ServiceImpl<ClockMapper, Clock> implements ClockService {

    @Autowired
    private ClockMapper clockMapper;

    // 获取打卡信息分页数据
    @Override
    public IPage<Clock> selectPage(Page<Clock> pageParam, UserQueryVo userQueryVo) {
        return clockMapper.selectPage(pageParam, userQueryVo);
    }

    // 获取list类型数据
    @Override
    public Collection<ExcelClock> listClockData() {
        List<Clock> clocks = baseMapper.selectList(new QueryWrapper<Clock>().orderByDesc("clock_time"));
        ArrayList<ExcelClock> excelClocks = new ArrayList<>(clocks.size());
        clocks.forEach(clock -> {
            ExcelClock excelClock = new ExcelClock();
            BeanUtils.copyProperties(clock, excelClock);
            excelClocks.add(excelClock);
        });
        return excelClocks;
    }

}
