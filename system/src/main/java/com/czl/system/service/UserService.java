package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.system.User;
import com.czl.model.vo.UserQueryVo;

import java.util.List;
import java.util.Map;

public interface UserService extends IService<User> {

    // 查询用户分页数据
    IPage<User> selectPage(Page<User> pageParam, UserQueryVo userQueryVo);

    // 更新用户状态
    void updateStatus(Long id, Integer status);

    // 根据用户名获取用户信息，返回User对象
    User getByUsername(String username);

    // 根据用户名获取用户信息，返回Map对象
    Map<String, Object> getUserInfo(String username);

    // 更新用户请假时间表
    void updateLeaveTime(User user, List<String> leaveTimes);

    // 撤销用户请假时间
    void removeLeaveTime(String leaveId, Long userId);

    // 获取工资发放记录
    IPage<User> selectPayOffPage(Page<User> pageParam, UserQueryVo userQueryVo);

    // 获取工资导出数据
    List<User> getExcelInfo(Long userId);

}