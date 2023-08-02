package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.czl.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@TableName("user_role")
@ApiModel(description = "用户角色关系")
public class UserRole extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户角色关系编号")
    @TableId("ur_id")
    private Long urId;

    @ApiModelProperty(value = "用户编号")
    @TableField("user_id")
    private Long userId;

    @ApiModelProperty(value = "角色编号")
    @TableField("role_id")
    private Long roleId;

}
