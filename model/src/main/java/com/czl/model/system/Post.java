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
@TableName("post")
@ApiModel(description = "职位")
public class Post extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "职位编号")
    @TableId(value = "post_id", type = IdType.AUTO)
    private Long postId;

    @ApiModelProperty(value = "职位名称")
    @TableField("post_name")
    private String postName;

    @ApiModelProperty(value = "职位编码")
    @TableField("post_code")
    private String postCode;

    @ApiModelProperty(value = "隶属部门编号")
    @TableField("dept_id")
    private Long deptId;

    @ApiModelProperty(value = "状态字段(1表示可用，0表示停用)")
    @TableField("status")
    private Integer status;

    // 部门
    @TableField(exist = false)
    private String deptName;

}
