package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.User;
import com.czl.model.vo.UserQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper extends BaseMapper<User> {

    // 获取
    IPage<User> selectPage(Page<User> page, @Param("vo") UserQueryVo userQueryVo);

    // 获取工资发放记录
    IPage<User> selectPayOffPage(Page<User> pageParam, @Param("vo") UserQueryVo userQueryVo);

    // 获取工资导出数据
    List<User> selectExcelInfo(Long userId);

}
