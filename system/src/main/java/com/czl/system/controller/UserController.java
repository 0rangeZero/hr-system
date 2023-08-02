package com.czl.system.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.*;
import com.czl.model.vo.UserQueryVo;
import com.czl.system.result.Result;
import com.czl.system.result.ResultCodeEnum;
import com.czl.system.service.*;
import com.czl.system.utils.ChineseCharToEnUtil;
import com.czl.system.utils.JwtHelper;
import com.czl.system.utils.MD5;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Api(tags = "用户管理")
@RestController
@RequestMapping("/system/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private DeptService deptService;

    @Autowired
    private PostService postService;

    @Autowired
    private ClockService clockService;

    @Autowired
    private SalaryService salaryService;

    @ApiOperation(value = "获取分页列表")
    @GetMapping("/{page}/{limit}")
    public Result index(@PathVariable Long page,
                        @PathVariable Long limit,
                        UserQueryVo userQueryVo) {
        Page<User> pageParam = new Page<>(page, limit);
        IPage<User> pageModel = userService.selectPage(pageParam, userQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "获取用户")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        User user = userService.getById(id);
        Dept dept = deptService.getById(user.getDeptId());
        Post post = postService.getById(user.getPostId());
        user.setDeptName(dept.getDeptName());
        user.setPostName(post.getPostName());
        return Result.ok(user);
    }

    @ApiOperation(value = "保存用户")
    @PostMapping("/save")
    public Result save(@RequestBody User user) {
        // 对日期属性进行截取
        user.setEntryDate(user.getEntryDate().substring(0, 10));
        if (user.getBirthday() != null)
            user.setBirthday(user.getBirthday().substring(0, 10));

        // 设置前端没有传递的属性
        String pwd = user.getWorkId() + ChineseCharToEnUtil.getFirstSpell(user.getName());
        user.setPassword(MD5.encrypt(pwd));
        Dept dept = deptService.selectByDeptName(user.getDeptName());
        user.setDeptId(dept.getDeptId());
        Post post = postService.selectByPostName(user.getPostName());
        user.setPostId(post.getPostId());

        boolean isSave = userService.save(user);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "更新用户")
    @PutMapping("/update")
    public Result updateById(@RequestBody User user) {
        // 对日期属性进行截取
        user.setEntryDate(user.getEntryDate().substring(0, 10));
        if (user.getBirthday() != null)
            user.setBirthday(user.getBirthday().substring(0, 10));

        // 设置前端没有传递的属性
        Dept dept = deptService.selectByDeptName(user.getDeptName());
        user.setDeptId(dept.getDeptId());
        Post post = postService.selectByPostName(user.getPostName());
        user.setPostId(post.getPostId());

        boolean isUpdate = userService.updateById(user);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "删除用户")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        userService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "更新状态")
    @GetMapping("updateStatus/{id}/{status}")
    public Result updateStatus(@PathVariable Long id, @PathVariable Integer status) {
        userService.updateStatus(id, status);
        return Result.ok();
    }

    @ApiOperation(value = "查看用户是否存在")
    @GetMapping("isLive/{username}")
    public Result isLive(@PathVariable String username) {
        int isAlive = userService.count(new QueryWrapper<User>().eq("user_name", username));
        if (isAlive == 0) return Result.ok();
        else return Result.fail(ResultCodeEnum.REPEAT_USERNAME);
    }

    @ApiOperation(value = "查看除了自己的用户是否存在")
    @GetMapping("isLiveExceptMe/{username}/{formerName}")
    public Result isLiveExceptMe(@PathVariable String username,
                                 @PathVariable String formerName) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>()
                .eq("user_name", username)
                .notIn("user_name", formerName);
        int isAlive = userService.count(userQueryWrapper);
        if (isAlive == 0) return Result.ok();
        else return Result.fail(ResultCodeEnum.REPEAT_USERNAME);
    }

    @ApiOperation(value = "根据token获取用户信息")
    @GetMapping("selectByToken")
    public Result selectByToken(HttpServletRequest request) {
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        return Result.ok(user);
    }

    @ApiOperation(value = "修改密码")
    @PutMapping("/updatePwd")
    public Result updatePwd(@RequestBody User user) {
        user.setPassword(MD5.encrypt(user.getNewPwd()));
        boolean isUpdate = userService.updateById(user);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取用户打卡日期")
    @GetMapping("selectWorkDate")
    public Result selectWorkDate(HttpServletRequest request) {
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        String workTime = user.getWorkTime();
        String[] workDate = workTime.split(",");
        return Result.ok(workDate);
    }

    @ApiOperation(value = "获取用户请假日期")
    @GetMapping("selectLeaveDate")
    public Result selectLeaveDate(HttpServletRequest request) {
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        String leaveTime = user.getLeaveTime();
        String[] leaveDate = leaveTime.split(",");
        return Result.ok(leaveDate);
    }

    @ApiOperation(value = "打卡")
    @PutMapping("clock/{date}")
    public Result clock(@PathVariable String date,
                        HttpServletRequest request) {
        // 将打卡日期添加到员工信息的work_time字段中
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        String workTime = "";
        if (user.getWorkTime() != null) {
            workTime = user.getWorkTime();
        }
        if (!workTime.equals("")) workTime += "," + date;
        else workTime += date;
        user.setWorkTime(workTime);

        // 将部分员工信息和打卡日期添加到打卡出勤表中
        Clock clock = new Clock(null, user.getUserId(), user.getWorkId(), user.getName(),
                                user.getSex(), date, 0);
        clockService.save(clock);
        
        boolean isUpdate = userService.updateById(user);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "修改账套id")
    @PutMapping("/updateSalary/{userId}/{salaryName}")
    public Result updateSalary(@PathVariable Long userId,
                               @PathVariable String salaryName) {
        Salary salary = salaryService.selectSalaryByName(salaryName);
        User user = userService.getById(userId);
        user.setSalaryId(salary.getSalaryId());
        boolean isUpdate = userService.updateById(user);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取工资发放记录")
    @GetMapping("/getPayOffList/{page}/{limit}")
    public Result getPayOffList(@PathVariable Long page,
                                @PathVariable Long limit,
                                UserQueryVo userQueryVo) {
        Page<User> pageParam = new Page<>(page, limit);
        IPage<User> pageModel = userService.selectPayOffPage(pageParam, userQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "获取个人工资发放记录")
    @GetMapping("/getPayMyOffList/{page}/{limit}")
    public Result getPayMyOffList(@PathVariable Long page,
                                  @PathVariable Long limit,
                                  UserQueryVo userQueryVo,
                                  HttpServletRequest request) {
        // 当前用户id封装到userQueryVo中，以查找自己的工资单
        String username = JwtHelper.getUsername(request.getHeader("token"));
        User user = userService.getByUsername(username);
        userQueryVo.setUserId(user.getUserId());

        Page<User> pageParam = new Page<>(page, limit);
        IPage<User> pageModel = userService.selectPayOffPage(pageParam, userQueryVo);
        return Result.ok(pageModel);
    }

}

