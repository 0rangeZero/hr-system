package com.czl.system.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Role;
import com.czl.model.vo.AssginRoleVo;
import com.czl.model.vo.RoleQueryVo;
import com.czl.system.result.Result;
import com.czl.system.service.RoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Api(tags = "角色管理")
@CrossOrigin
@RestController
@RequestMapping("/system/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @ApiOperation("查询所有角色")
    @GetMapping("/findAll")
    public Result selectAll() {
        List<Role> roleList = roleService.list();
        return Result.ok(roleList);
    }

    @ApiOperation("根据id查询查询角色")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        Role role = roleService.getById(id);
        return Result.ok(role);
    }

    @ApiOperation("添加角色")
    @PostMapping("/save")
    public Result save(@RequestBody Role role) {
        boolean isSave = roleService.save(role);
        if (isSave) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("修改角色")
    @PutMapping("/update")
    public Result updateById(@RequestBody Role role) {
        boolean isUpdate = roleService.updateById(role);
        if (isUpdate) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("删除角色")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        boolean isRemove = roleService.removeById(id);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation("批量删除")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        boolean isRemove = roleService.removeByIds(idList);
        if (isRemove) return Result.ok();
        else return Result.fail();
    }

    @ApiOperation(value = "获取角色分页列表")
    @GetMapping("/{page}/{limit}")
    public Result selectPage(@PathVariable Long page,
                             @PathVariable Long limit,
                             RoleQueryVo roleQueryVo) {
        Page<Role> pageParam = new Page<>(page, limit);
        IPage<Role> pageModel = roleService.selectPage(pageParam, roleQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "根据用户获取角色数据")
    @GetMapping("/toAssign/{userId}")
    public Result toAssign(@PathVariable Long userId) {
        Map<String, Object> roleMap = roleService.getRolesByUserId(userId);
        return Result.ok(roleMap);
    }

    @ApiOperation(value = "根据用户分配角色")
    @PostMapping("/doAssign")
    public Result doAssign(@RequestBody AssginRoleVo assginRoleVo) {
        roleService.doAssign(assginRoleVo);
        return Result.ok();
    }

}
