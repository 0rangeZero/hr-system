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
@TableName("payoff")
@ApiModel(description = "工资发放")
public class Payoff extends BaseEntity {

    @ApiModelProperty(value = "用户编号")
    @TableField(value = "user_id")
    private Long userId;

    @ApiModelProperty(value = "工资账套编号")
    @TableField("salary_id")
    private String salaryId;

}
