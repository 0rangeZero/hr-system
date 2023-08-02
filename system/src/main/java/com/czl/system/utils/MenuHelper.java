package com.czl.system.utils;

import com.czl.model.system.Menu;

import java.util.ArrayList;
import java.util.List;

public class MenuHelper {

    /**
     * 使用递归方法建菜单
     * @param menuList 数据库查询出的菜单列表
     * @return 菜单树形结构
     */
    public static List<Menu> buildTree(List<Menu> menuList) {
        List<Menu> trees = new ArrayList<>();
        for (Menu menu : menuList) {
            // 查找顶层目录，规定数字“0”表示顶层目录
            if (menu.getParentId().longValue() == 0) {
                trees.add(findChildren(menu, menuList));
            }
        }
        return trees;
    }

    /**
     * 递归查找子节点
     * @param treeNodes 数据库查询出的菜单列表
     * @return 菜单树形结构
     */
    public static Menu findChildren(Menu menu, List<Menu> treeNodes) {
        menu.setChildren(new ArrayList<>());
        // 遍历所有节点，该节点的parentId与顶层目录(传进来的菜单)menuId相同，
        // 表明该节点是顶层目录的子节点，将其加入到顶层目录的children中
        for (Menu it : treeNodes) {
            if(menu.getMenuId().longValue() == it.getParentId().longValue()) {
                if (menu.getChildren() == null) {
                    menu.setChildren(new ArrayList<>());
                }
                // 遍历子节点的节点
                menu.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return menu;
    }

    /**
     * 递归获取子节点
     * @param menu 父菜单
     * @param childrenMenu 子节点接收数组
     */
    public static void getChildrenMenu(Menu menu, List<Menu> childrenMenu) {
        if (menu.getChildren() == null) return;
        childrenMenu.add(menu);
        for (Menu child : menu.getChildren()) {
            getChildrenMenu(child, childrenMenu);
        }
    }

}
