package com.czl.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.system.Role;
import com.czl.model.vo.AssginRoleVo;
import com.czl.model.vo.RoleQueryVo;

import java.util.Map;

public interface RoleService extends IService<Role> {

    // 获取角色分页列表
    IPage<Role> selectPage(Page<Role> pageParam, RoleQueryVo roleQueryVo);

    // 根据用户获取角色数据
    Map<String, Object> getRolesByUserId(Long userId);

    // 分配角色
    void doAssign(AssginRoleVo assginRoleVo);

}
