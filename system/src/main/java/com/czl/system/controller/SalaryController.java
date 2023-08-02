package com.czl.system.controller;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.*;
import com.czl.model.vo.SalaryQueryVo;
import com.czl.model.vo.UserQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.DeptService;
import com.czl.system.service.PayoffService;
import com.czl.system.service.SalaryService;
import com.czl.system.service.UserService;
import com.czl.system.utils.JwtHelper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(tags = "薪酬管理")
@CrossOrigin
@RestController
@RequestMapping("/system/salary")
public class SalaryController {

    @Autowired
    private SalaryService salaryService;

    @Autowired
    private DeptService deptService;

    @Autowired
    private PayoffService payoffService;

    @Autowired
    private UserService userService;

    @ApiOperation(value = "获取账套分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             SalaryQueryVo salaryQueryVo) {
        Page<Salary> pageParam = new Page<>(page, limit);
        IPage<Salary> pageModel = salaryService.selectPage(pageParam, salaryQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation("添加账套")
    @PostMapping("/save")
    public Result save(@RequestBody Salary salary) {
        boolean isSave = salaryService.save(salary);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("根据id查询查询账套")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        Salary salary = salaryService.getById(id);
        return Result.ok(salary);
    }

    @ApiOperation("修改角色")
    @PutMapping("/update")
    public Result updateById(@RequestBody Salary salary) {
        boolean isUpdate = salaryService.updateById(salary);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("删除账套")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        boolean isRemove = salaryService.removeById(id);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("批量删除")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        boolean isRemove = salaryService.removeByIds(idList);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("根据部门名称查询账套信息")
    @GetMapping("/getByDeptName/{deptName}")
    public Result getByDeptName(@PathVariable String deptName) {
        Dept dept = deptService.selectByDeptName(deptName);
        List<Salary> salaryList = salaryService.selectSalaryByDept(dept);
        return Result.ok(salaryList);
    }

    @ApiOperation("添加账套")
    @PostMapping("payoff")
    public Result payoff(@RequestBody Payoff payoff) {
        boolean isSave = payoffService.save(payoff);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("查看用户工资发放记录")
    @PostMapping("getPayTime")
    public Result getPayTime(@RequestBody List<Long> idList) {
        return Result.ok(salaryService.selectPaid(idList));
    }

    @ApiOperation("Excel数据导出")
    @GetMapping("/export")
    public void export(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String token = "";
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("vue_admin_template_token"))
                token = cookie.getValue();
        }
        String username = JwtHelper.getUsername(token);
        User user = userService.getByUsername(username);
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        // URLEncoder.encode可以防止中文乱码
        String fileName = URLEncoder.encode("工资单", "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        EasyExcel.write(response.getOutputStream(), ExcelSalary.class)
                .sheet("工资单")
                .doWrite(salaryService.listSalaryData(user.getUserId()));
    }

}

