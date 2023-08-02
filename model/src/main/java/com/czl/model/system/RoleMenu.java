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
@TableName("role_menu")
@ApiModel(description = "角色菜单关系")
public class RoleMenu extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色菜单关系编号")
    @TableId(value = "rm_id", type = IdType.AUTO)
    private Long rmId;

    @ApiModelProperty(value = "角色编号")
    @TableField("role_id")
    private Long roleId;

    @ApiModelProperty(value = "菜单编号")
    @TableField("menu_id")
    private Long menuId;

}
