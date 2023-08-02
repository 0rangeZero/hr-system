package com.czl.system.test;

import com.czl.model.system.Role;
import com.czl.system.mapper.RoleMapper;
import com.czl.system.service.RoleService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class TestRole {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RoleService roleService;

    @Test
    public void testMapper() {
        List<Role> roles = roleMapper.selectList(null);
        roles.forEach(System.out::println);
    }

    @Test
    public void testService() {
        Role role = roleService.getById(1);
        System.out.println(role);
    }

}
