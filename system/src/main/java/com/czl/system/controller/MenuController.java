package com.czl.system.controller;

import com.czl.model.system.Menu;
import com.czl.model.vo.AssginMenuVo;
import com.czl.system.result.Result;
import com.czl.system.service.MenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "菜单管理")
@CrossOrigin
@RestController
@RequestMapping("/system/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @ApiOperation(value = "获取菜单")
    @GetMapping("findNodes")
    public Result findNodes() {
        List<Menu> list = menuService.findNodes();
        return Result.ok(list);
    }

    @ApiOperation(value = "新增菜单")
    @PostMapping("save")
    public Result save(@RequestBody Menu permission) {
        menuService.save(permission);
        return Result.ok();
    }

    @ApiOperation(value = "修改菜单")
    @PutMapping("update")
    public Result updateById(@RequestBody Menu permission) {
        menuService.updateById(permission);
        return Result.ok();
    }

    @ApiOperation(value = "删除菜单")
    @DeleteMapping("remove/{id}")
    public Result remove(@PathVariable Long id) {
        menuService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "根据角色id获取可操作的菜单")
    @GetMapping("/toAssign/{roleId}")
    public Result toAssign(@PathVariable Long roleId) {
        List<Menu> list = menuService.selectMenuByRoleId(roleId);
        return Result.ok(list);
    }

    @ApiOperation(value = "为角色分配权限")
    @PostMapping("/doAssign")
    public Result doAssign(@RequestBody AssginMenuVo assginMenuVo) {
        menuService.doAssign(assginMenuVo);
        return Result.ok();
    }

    @ApiOperation(value = "更新状态")
    @GetMapping("updateStatus/{id}/{status}")
    public Result updateStatus(@PathVariable Long id, @PathVariable Integer status) {
        menuService.updateStatus(id, status);
        return Result.ok();
    }

}