package com.czl.system.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Leave;
import com.czl.model.system.User;
import com.czl.model.vo.LeaveQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.LeaveService;
import com.czl.system.service.UserService;
import com.czl.system.utils.JwtHelper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Api(tags = "请假管理")
@CrossOrigin
@RestController
@RequestMapping("/system/leave")
public class LeaveController {

    @Autowired
    private LeaveService leaveService;

    @Autowired
    private UserService userService;

    @ApiOperation(value = "获取当前用户请假申请分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             LeaveQueryVo leaveQueryVo,
                             HttpServletRequest request) {
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        leaveQueryVo.setUserId(user.getUserId());
        Page<Leave> pageParam = new Page<>(page, limit);
        IPage<Leave> pageModel = leaveService.selectPage(pageParam, leaveQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation("添加申请")
    @PostMapping("/save")
    public Result save(@RequestBody Leave leave,
                       HttpServletRequest request) {
        // 对日期属性进行处理
        String leaveTime = leave.getLeaveTime().substring(0, 10);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime ldt = LocalDate.parse(leaveTime, fmt).atStartOfDay();
        ldt = ldt.plusDays(1);
        leaveTime = ldt.format(fmt);
        leave.setLeaveTime(leaveTime);

        // 根据请求头的用户名查询用户信息
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        leave.setUserId(user.getUserId());

        boolean isSave = leaveService.save(leave);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("根据id查询查询职位")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        Leave leave = leaveService.getById(id);
        return Result.ok(leave);
    }

    @ApiOperation("修改申请")
    @PutMapping("/update")
    public Result update(@RequestBody Leave leave) {
        // 对日期属性进行处理
        String leaveTime = leave.getLeaveTime().substring(0, 10);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime ldt = LocalDate.parse(leaveTime, fmt).atStartOfDay();
        ldt = ldt.plusDays(1);
        leaveTime = ldt.format(fmt);
        leave.setLeaveTime(leaveTime);

        boolean isUpdate = leaveService.updateById(leave);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("删除申请")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        boolean isRemove = leaveService.removeById(id);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取所有请假申请分页列表")
    @GetMapping("/getList/{page}/{limit}/{passedNum}")
    public Result getList(@PathVariable Long page,
                          @PathVariable Long limit,
                          @PathVariable Long passedNum,
                          LeaveQueryVo leaveQueryVo,
                          HttpServletRequest request) {
        // 通过请求头获取用户信息
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);

        // 封装查询数据
        leaveQueryVo.setUserId(user.getUserId());
        leaveQueryVo.setPassed(passedNum);

        // 获取分页信息
        Page<Leave> pageParam = new Page<>(page, limit);
        IPage<Leave> pageModel = leaveService.selectAllPage(pageParam, leaveQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation("申请通过")
    @PutMapping("/pass/{leaveId}/{userId}")
    public Result pass(@PathVariable String leaveId,
                       @PathVariable String userId) throws ParseException {
        // 通过id获取用户信息
        User user = userService.getById(userId);
        // 请假时间封装到集合中
        Leave leave = leaveService.getById(leaveId);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime ldt = LocalDate.parse(leave.getLeaveTime(), fmt).atStartOfDay(); // String类型的请假时间转为LocalDateTime类型操作
        List<String> leaveTimes = new ArrayList<>();
        for (int i = 0; i < leave.getLeaveDays(); i++) {
            ldt = ldt.plusDays(i);
            String leaveTime = ldt.format(fmt);
            leaveTimes.add(leaveTime);
        }
        // 调用userService更新用户请假时间表
        userService.updateLeaveTime(user, leaveTimes);

        // 修改请假表状态
        leave.setPassed(1);
        boolean isUpdate = leaveService.updateById(leave);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("申请驳回")
    @PutMapping("/reject/{id}")
    public Result reject(@PathVariable String id) {
        Leave leave = leaveService.getById(id);
        leave.setPassed(0);
        boolean isUpdate = leaveService.updateById(leave);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("撤销申请")
    @PutMapping("/revocation/{leaveId}/{userId}")
    public Result revocation(@PathVariable String leaveId,
                             @PathVariable Long userId) throws ParseException {
        // 更新用户请假时间
        userService.removeLeaveTime(leaveId, userId);

        // 删除申请记录
        boolean isUpdate = leaveService.removeById(leaveId);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

}

