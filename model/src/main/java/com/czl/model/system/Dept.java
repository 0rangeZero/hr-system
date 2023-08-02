package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.czl.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@TableName("dept")
@ApiModel(description = "部门")
public class Dept extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "部门编号")
    @TableId(value = "dept_id", type = IdType.AUTO)
    private Long deptId;

    @ApiModelProperty(value = "部门名称")
    @TableField("dept_name")
    private String deptName;

    @ApiModelProperty(value = "部门编码")
    @TableField("dept_code")
    private String deptCode;

    @ApiModelProperty(value = "状态字段(1表示可用，0表示停用)")
    @TableField("status")
    private Integer status;

}