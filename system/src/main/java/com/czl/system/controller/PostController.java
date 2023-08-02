package com.czl.system.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.czl.model.system.Post;
import com.czl.model.vo.PostQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.DeptService;
import com.czl.system.service.PostService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Api(tags = "职位管理")
@CrossOrigin
@RestController
@RequestMapping("/system/post")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private DeptService deptService;

    @ApiOperation("查询所有职位")
    @GetMapping("/findAll")
    public Result selectAll() {
        List<Post> postList = postService.list();
        return Result.ok(postList);
    }

//    @ApiOperation("查询可用职位")
//    @GetMapping("/findValid")
//    public Result findValid() {
//        List<Post> postList = postService.list(new QueryWrapper<Post>().eq("status", 1));
//        return Result.ok(postList);
//    }

    @ApiOperation("根据id查询查询职位")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        Post post = postService.getById(id);
        return Result.ok(post);
    }

    @ApiOperation("添加职位")
    @PostMapping("/save")
    public Result save(@RequestBody Post post) {
        Dept dept = deptService.selectByDeptName(post.getDeptName());
        post.setDeptId(dept.getDeptId());
        boolean isSave = postService.save(post);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("修改职位")
    @PutMapping("/update")
    public Result updateById(@RequestBody Post post) {
        Dept dept = deptService.selectByDeptName(post.getDeptName());
        post.setDeptId(dept.getDeptId());
        boolean isUpdate = postService.updateById(post);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("删除职位")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        boolean isRemove = postService.removeById(id);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("批量删除")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        boolean isRemove = postService.removeByIds(idList);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取职位分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             PostQueryVo postQueryVo) {
        Page<Post> pageParam = new Page<>(page, limit);
        IPage<Post> pageModel = postService.selectPage(pageParam, postQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "更新状态")
    @GetMapping("updateStatus/{id}/{status}")
    public Result updateStatus(@PathVariable Long id, @PathVariable Integer status) {
        postService.updateStatus(id, status);
        return Result.ok();
    }

    @ApiOperation(value = "查询该部门下的职位")
    @GetMapping("selectPostByDeptName")
    public Result selectPostByDeptName(PostQueryVo postQueryVo) {
        List<Post> postList = new ArrayList<>();
        Dept dept = deptService.selectByDeptName(postQueryVo.getDeptName());
        List<Post> posts = postService.list(new QueryWrapper<Post>().eq("status", 1));
        for (Post post : posts) {
            if (post.getDeptId() == dept.getDeptId())
                postList.add(post);
        }
        return Result.ok(postList);
    }

}

