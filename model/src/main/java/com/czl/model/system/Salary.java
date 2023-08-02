package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.czl.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@TableName("salary")
@ApiModel(description = "薪酬")
public class Salary extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "工资账套编号")
    @TableId("salary_id")
    private String salaryId;

    @ApiModelProperty(value = "工资账套名称")
    @TableField("salary_name")
    private String salaryName;

    @ApiModelProperty(value = "基本工资")
    @TableField("basic_salary")
    private Long basicSalary;

    @ApiModelProperty(value = "绩效工资")
    @TableField("merit_pay")
    private Long meritPay;

    @ApiModelProperty(value = "补助补贴")
    @TableField("allowance")
    private Long allowance;

    @ApiModelProperty(value = "奖金")
    @TableField("bonus")
    private Long bonus;

    @ApiModelProperty(value = "五险一金")
    @TableField("finsurances")
    private Long finsurances;

    @ApiModelProperty(value = "部门编号")
    @TableField("dept_id")
    private Long deptId;

}
