package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Leave;
import com.czl.model.system.User;
import com.czl.model.vo.RouterVo;
import com.czl.model.vo.UserQueryVo;
import com.czl.system.mapper.PayoffMapper;
import com.czl.system.mapper.UserMapper;
import com.czl.system.service.LeaveService;
import com.czl.system.service.MenuService;
import com.czl.system.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author czl
 * @since 2023-04-16
 */
@Transactional
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MenuService menuService;

    @Autowired
    private LeaveService leaveService;

    // 查询用户分页数据
    @Override
    public IPage<User> selectPage(Page<User> pageParam, UserQueryVo userQueryVo) {
        return userMapper.selectPage(pageParam, userQueryVo);
    }

    // 更新用户状态
    @Override
    public void updateStatus(Long id, Integer status) {
        User user = userMapper.selectById(id);
        user.setStatus(status);
        userMapper.updateById(user);
    }

    // 根据用户名获取用户信息，返回User对象
    @Override
    public User getByUsername(String username) {
        return userMapper.selectOne(new QueryWrapper<User>().eq("user_name", username));
    }

    // 根据用户名获取用户信息，返回Map对象
    @Override
    public Map<String, Object> getUserInfo(String username) {
        Map<String, Object> result = new HashMap<>();
        User user = this.getByUsername(username);

        //根据用户id获取菜单权限值
        List<RouterVo> routerVoList = menuService.findUserMenuList(user.getUserId());
        //根据用户id获取用户按钮权限
        List<String> permsList = menuService.findUserPermsList(user.getUserId());

        result.put("name", user.getName());
        if (user.getHeadUrl() == null || user.getHeadUrl().equals(""))  result.put("avatar", "https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png");
        else result.put("avatar", user.getHeadUrl());
        result.put("roles",  new HashSet<>());
        result.put("buttons", permsList);
        result.put("routers", routerVoList);
        return result;
    }

    // 更新用户请假时间表
    @Override
    public void updateLeaveTime(User user, List<String> leaveTimes) {
        String leaveTime = user.getLeaveTime();
        if (!leaveTime.equals("")) {
            for (String time : leaveTimes) {
                leaveTime += "," + time;
            }
        } else {
            leaveTime += leaveTimes.get(0);
            if (leaveTimes.size() > 1) {
                for (int i = 1; i < leaveTimes.size(); i++) {
                    leaveTime += "," + leaveTimes.get(i);
                }
            }
        }
        user.setLeaveTime(leaveTime);
        userMapper.updateById(user);
    }

    @Override
    public void removeLeaveTime(String leaveId, Long userId) {
        // 通过id获取用户信息
        User user = userMapper.selectById(userId);

        // 请假时间封装到集合中
        Leave leave = leaveService.getById(leaveId);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime ldt = LocalDate.parse(leave.getLeaveTime(), fmt).atStartOfDay(); // String类型的请假时间转为LocalDateTime类型操作
        // 请假申请时间表
        List<String> leaveTimes = new ArrayList<>();
        for (int i = 0; i < leave.getLeaveDays(); i++) {
            ldt = ldt.plusDays(i);
            String leaveTime = ldt.format(fmt);
            leaveTimes.add(leaveTime);
        }

        // 原用户请假时间表
        String leaveTime = user.getLeaveTime();
        String[] leaveTimeInDB = leaveTime.split(",");
        List<String> leaveTimeArr = new ArrayList<>();
        for (String time : leaveTimeInDB) {
            leaveTimeArr.add(time);
        }

        // 删除用户请假时间表中的信息
        List<String> leaveTimeNew = new ArrayList<>(leaveTimeArr);
        for (String time : leaveTimes) {
            for (String timeDB : leaveTimeArr) {
                if (timeDB.equals(time)) leaveTimeNew.remove(timeDB);
            }
        }
        String newLeaveTime = "";
        if (leaveTimeNew.size() > 0) newLeaveTime += leaveTimeArr.get(0);
        for (int i = 1; i < leaveTimeNew.size(); i++) {
            newLeaveTime += "," + leaveTimeNew.get(i);
        }

        // 更新用户请假时间表
        user.setLeaveTime(newLeaveTime);
        userMapper.updateById(user);
    }

    // 获取工资发放记录
    @Override
    public IPage<User> selectPayOffPage(Page<User> pageParam, UserQueryVo userQueryVo) {
        return userMapper.selectPayOffPage(pageParam, userQueryVo);
    }

    // 获取工资导出数据
    @Override
    public List<User> getExcelInfo(Long userId) {
        return userMapper.selectExcelInfo(userId);
    }

}