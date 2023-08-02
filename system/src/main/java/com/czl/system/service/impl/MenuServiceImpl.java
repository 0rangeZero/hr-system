package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.czl.model.system.Menu;
import com.czl.model.system.RoleMenu;
import com.czl.model.vo.AssginMenuVo;
import com.czl.model.vo.RouterVo;
import com.czl.system.exception.MyException;
import com.czl.system.mapper.MenuMapper;
import com.czl.system.mapper.RoleMenuMapper;
import com.czl.system.result.ResultCodeEnum;
import com.czl.system.service.MenuService;
import com.czl.system.utils.MenuHelper;
import com.czl.system.utils.RouterHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private RoleMenuMapper roleMenuMapper;

    // 返回菜单树形数据
    @Override
    public List<Menu> findNodes() {
        //全部权限列表
        List<Menu> menuList = this.list();
        if (CollectionUtils.isEmpty(menuList)) return null;

        //构建树形数据
        List<Menu> result = MenuHelper.buildTree(menuList);
        return result;
    }

    // 根据id移除节点
    @Override
    public boolean removeById(Serializable id) {
        int count = this.count(new QueryWrapper<Menu>().eq("parent_id", id));
        if (count > 0) {
            throw new MyException(ResultCodeEnum.NODE_ERROR);
        }
        menuMapper.deleteById(id);
        return false;
    }

    // 根据角色id获取可操作的菜单
    @Override
    public List<Menu> selectMenuByRoleId(Long roleId) {
        // 获取所有status为1的权限列表
        List<Menu> menuList = menuMapper.selectList(new QueryWrapper<Menu>().eq("status", 1));
        // 根据角色id获取角色权限
        List<RoleMenu> roleMenus = roleMenuMapper.selectList(new QueryWrapper<RoleMenu>().eq("role_id", roleId));
        // 获取该角色已分配的所有权限id
        List<Long> roleMenuIds = new ArrayList<>();
        for (RoleMenu roleMenu : roleMenus) {
            roleMenuIds.add(roleMenu.getMenuId());
        }
        // 遍历所有权限列表
        for (Menu menu : menuList) {
            if(roleMenuIds.contains(menu.getMenuId())){
                // 设置该权限已被分配
                menu.setSelect(true);
            } else {
                menu.setSelect(false);
            }
        }
        // 将权限列表转换为权限树
        List<Menu> menus = MenuHelper.buildTree(menuList);
        return menus;
    }

    // 为角色分配权限
    @Override
    public void doAssign(AssginMenuVo assginMenuVo) {
        //删除已分配的权限
        roleMenuMapper.delete(new QueryWrapper<RoleMenu>().eq("role_id", assginMenuVo.getRoleId()));
        //遍历所有已选择的权限id
        for (Long menuId : assginMenuVo.getMenuIdList()) {
            if(menuId != null){
                //创建SysRoleMenu对象
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setMenuId(menuId);
                roleMenu.setRoleId(assginMenuVo.getRoleId());
                //添加新权限
                roleMenuMapper.insert(roleMenu);
            }
        }
    }

    // 更新菜单状态
    @Override
    public void updateStatus(Long id, Integer status) {
        Menu menu = menuMapper.selectById(id);
        List<Menu> childrenMenu = new ArrayList<>();
        List<Menu> menus = menuMapper.selectList(null);
        menu = MenuHelper.findChildren(menu, menus);
        MenuHelper.getChildrenMenu(menu, childrenMenu);
        for (Menu child : childrenMenu) {
            child.setStatus(status);
            menuMapper.updateById(child);
        }
    }

    // 获取用户可操作的菜单
    @Override
    public List<RouterVo> findUserMenuList(Long userId) {
        // 超级管理员admin账号id为：1
        List<Menu> sysMenuList = null;
        if (userId.longValue() == 1) {
            sysMenuList = menuMapper.selectList(new QueryWrapper<Menu>().eq("status", 1));
        } else {
            sysMenuList = menuMapper.findListByUserId(userId);
        }
        //构建树形数据
        List<Menu> sysMenuTreeList = MenuHelper.buildTree(sysMenuList);

        //构建路由
        List<RouterVo> routerVoList = RouterHelper.buildRouters(sysMenuTreeList);
        return routerVoList;
    }

    // 获取用户按钮权限
    @Override
    public List<String> findUserPermsList(Long userId) {
        //超级管理员admin账号id为：1
        List<Menu> sysMenuList = null;
        if (userId.longValue() == 1) {
            sysMenuList = menuMapper.selectList(new QueryWrapper<Menu>().eq("status", 1));
        } else {
            sysMenuList = menuMapper.findListByUserId(userId);
        }
        //创建返回的集合
        List<String> permissionList = new ArrayList<>();
        for (Menu menu : sysMenuList) {
            if(menu.getType() == 2){
                permissionList.add(menu.getPerms());
            }
        }
        return permissionList;
    }

}
