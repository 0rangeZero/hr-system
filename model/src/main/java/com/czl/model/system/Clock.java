package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("clock")
@ApiModel(description = "员工打卡")
public class Clock {

    @ApiModelProperty(value = "打卡编号")
    @TableId("clock_id")
    private String clockId;

    @ApiModelProperty(value = "用户id")
    @TableField("user_id")
    private Long userId;

    @ApiModelProperty(value = "工号")
    @TableField("work_id")
    private Long workId;

    @ApiModelProperty(value = "姓名")
    @TableField("name")
    private String name;

    @ApiModelProperty(value = "性别")
    @TableField("sex")
    private String sex;

    @ApiModelProperty(value = "打卡时间")
    @TableField("clock_time")
    private String clockTime;

    // 逻辑删除字段
    // 默认：0没有删除，1已经删除
    @TableLogic
    @TableField("is_deleted")
    private Integer isDeleted;

}
