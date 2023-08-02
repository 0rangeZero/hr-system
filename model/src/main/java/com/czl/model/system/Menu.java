package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.czl.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@TableName("menu")
@ApiModel(description = "菜单")
public class Menu extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "菜单编号")
    @TableId(value = "menu_id", type = IdType.AUTO)
    private Long menuId;

    @ApiModelProperty(value = "上级菜单")
    @TableField("parent_id")
    private Long parentId;

    @ApiModelProperty(value = "菜单名称")
    @TableField("menu_name")
    private String menuName;

    @ApiModelProperty(value = "类型(0:目录,1:菜单,2:按钮)")
    @TableField("type")
    private Integer type;

    @ApiModelProperty(value = "路由地址")
    @TableField("path")
    private String path;

    @ApiModelProperty(value = "组件路径")
    @TableField("component")
    private String component;

    @ApiModelProperty(value = "权限标志")
    @TableField("perms")
    private String perms;

    @ApiModelProperty(value = "图标")
    @TableField("icon")
    private String icon;

    @ApiModelProperty(value = "状态字段(1表示可用，0表示停用)")
    @TableField("status")
    private Integer status;

    //下级列表
    @TableField(exist = false)
    private List<Menu> children;

    //是否选中
    @TableField(exist = false)
    private boolean isSelect;

}
