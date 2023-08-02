package com.czl.system.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.czl.model.system.Post;
import com.czl.model.vo.DeptQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.DeptService;
import com.czl.system.service.PostService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "部门管理")
@CrossOrigin
@RestController
@RequestMapping("/system/dept")
public class DeptController {

    @Autowired
    private DeptService deptService;

    @Autowired
    private PostService postService;

    @ApiOperation("查询所有部门")
    @GetMapping("/findAll")
    public Result selectAll() {
        List<Dept> deptList = deptService.list();
        return Result.ok(deptList);
    }

    @ApiOperation("查询可用的部门")
    @GetMapping("/findValid")
    public Result findValid() {
        List<Dept> deptList = deptService.list(new QueryWrapper<Dept>().eq("status", 1));
        return Result.ok(deptList);
    }

    @ApiOperation("根据id查询查询部门")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        Dept dept = deptService.getById(id);
        return Result.ok(dept);
    }

    @ApiOperation("添加部门")
    @PostMapping("/save")
    public Result save(@RequestBody Dept dept) {
        boolean isSave = deptService.save(dept);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("修改部门")
    @PutMapping("/update")
    public Result updateById(@RequestBody Dept dept) {
        boolean isUpdate = deptService.updateById(dept);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("删除部门")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        boolean isRemove = deptService.removeById(id);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("批量删除")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        boolean isRemove = deptService.removeByIds(idList);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取部门分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             DeptQueryVo deptQueryVo) {
        Page<Dept> pageParam = new Page<>(page, limit);
        IPage<Dept> pageModel = deptService.selectPage(pageParam, deptQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "更新状态")
    @GetMapping("updateStatus/{id}/{status}")
    public Result updateStatus(@PathVariable Long id, @PathVariable Integer status) {
        deptService.updateStatus(id, status);
        List<Post> posts = postService.list();
        for (Post post : posts) {
            if (post.getDeptId() == id) {
                post.setStatus(status);
                postService.updateById(post);
            }
        }
        return Result.ok();
    }

}

