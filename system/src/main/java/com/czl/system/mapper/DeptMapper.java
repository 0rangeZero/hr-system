package com.czl.system.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.czl.model.system.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czl.model.vo.DeptQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DeptMapper extends BaseMapper<Dept> {

    IPage<Dept> selectPage(Page<Dept> page, @Param("vo") DeptQueryVo deptQueryVo);

}