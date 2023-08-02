package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czl.model.system.Menu;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuMapper extends BaseMapper<Menu> {
    // 根据用户id获取菜单列表
    List<Menu> findListByUserId(Long userId);
}
