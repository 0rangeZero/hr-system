package com.czl.system.controller;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Clock;
import com.czl.model.system.ExcelClock;
import com.czl.model.vo.UserQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.ClockService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@Api(tags = "打卡签到")
@CrossOrigin
@RestController
@RequestMapping("/system/clock")
public class ClockController {

    @Autowired
    private ClockService clockService;

    @ApiOperation(value = "获取打卡分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             UserQueryVo userQueryVo) {
        Page<Clock> pageParam = new Page<>(page, limit);
        IPage<Clock> pageModel = clockService.selectPage(pageParam, userQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation("批量删除")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<String> idList) {
        boolean isRemove = clockService.removeByIds(idList);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("Excel数据导出")
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        // URLEncoder.encode可以防止中文乱码
        String fileName = URLEncoder.encode("签到时间表", "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        EasyExcel.write(response.getOutputStream(), ExcelClock.class)
                 .sheet("签到时间表")
                 .doWrite(clockService.listClockData());
    }

}
