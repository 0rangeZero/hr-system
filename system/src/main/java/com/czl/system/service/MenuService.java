package com.czl.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.czl.model.system.Menu;
import com.czl.model.vo.AssginMenuVo;
import com.czl.model.vo.RouterVo;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MenuService extends IService<Menu> {

    // 返回菜单树形数据
    List<Menu> findNodes();

    // 根据角色id获取可操作的菜单
    List<Menu> selectMenuByRoleId(Long roleId);

    // 给角色分配权限
    void doAssign(AssginMenuVo assginMenuVo);

    // 更新菜单状态
    void updateStatus(Long id, Integer status);

    // 获取用户可操作的菜单
    List<RouterVo> findUserMenuList(Long userId);

    // 获取用户按钮权限
    List<String> findUserPermsList(Long userId);
}