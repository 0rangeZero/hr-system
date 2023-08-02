package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.system.Clock;
import com.czl.model.system.ExcelClock;
import com.czl.model.vo.UserQueryVo;

import java.util.Collection;

public interface ClockService extends IService<Clock> {

    // 获取打卡信息分页数据
    IPage<Clock> selectPage(Page<Clock> pageParam, UserQueryVo userQueryVo);

    // 获取list类型数据
    Collection<ExcelClock> listClockData();

}
