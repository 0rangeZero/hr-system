package com.czl.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.czl.model.system.Role;
import com.czl.model.system.UserRole;
import com.czl.model.vo.AssginRoleVo;
import com.czl.model.vo.RoleQueryVo;
import com.czl.system.mapper.RoleMapper;
import com.czl.system.mapper.UserRoleMapper;
import com.czl.system.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    // 获取角色分页列表
    @Override
    public IPage<Role> selectPage(Page<Role> pageParam, RoleQueryVo roleQueryVo) {
        return roleMapper.selectPage(pageParam, roleQueryVo);
    }

    // 根据用户获取角色数据
    @Override
    public Map<String, Object> getRolesByUserId(Long userId) {
        //获取所有角色
        List<Role> roles = roleMapper.selectList(null);
        //根据用户id查询
        QueryWrapper<UserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id",userId);
        //获取用户已分配的角色
        List<UserRole> userRoles = userRoleMapper.selectList(queryWrapper);
        //获取用户已分配的角色id
        List<Long> userRoleIds = new ArrayList<>();
        for (UserRole userRole : userRoles) {
            userRoleIds.add(userRole.getRoleId());
        }
        //创建返回的Map
        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("allRoles", roles);
        returnMap.put("userRoleIds", userRoleIds);
        return returnMap;
    }

    // 分配角色
    @Override
    public void doAssign(AssginRoleVo assginRoleVo) {
        //根据用户id删除原来分配的角色
        QueryWrapper<UserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id",assginRoleVo.getUserId());
        userRoleMapper.delete(queryWrapper);
        //获取所有的角色id
        List<Long> roleIdList = assginRoleVo.getRoleIdList();
        for (Long roleId : roleIdList) {
            if(roleId != null){
                UserRole sysUserRole = new UserRole();
                sysUserRole.setUserId(assginRoleVo.getUserId());
                sysUserRole.setRoleId(roleId);
                //保存
                userRoleMapper.insert(sysUserRole);
            }
        }
    }
}
