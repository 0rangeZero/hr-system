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
@TableName("user")
@ApiModel(description = "用户")
public class User extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户编号")
    @TableId(value = "user_id", type = IdType.AUTO)
    private Long userId;

    @ApiModelProperty(value = "用户名")
    @TableField("user_name")
    private String userName;

    @ApiModelProperty(value = "密码")
    @TableField("password")
    private String password;

    @ApiModelProperty(value = "工号")
    @TableField("work_id")
    private Long workId;

    @ApiModelProperty(value = "真实姓名")
    @TableField("name")
    private String name;

    @ApiModelProperty(value = "性别")
    @TableField("sex")
    private String sex;

    @ApiModelProperty(value = "出生日期")
    @TableField("birthday")
    private String birthday;

    @ApiModelProperty(value = "家庭住址")
    @TableField("address")
    private String address;

    @ApiModelProperty(value = "电话号码")
    @TableField("phone")
    private String phone;

    @ApiModelProperty(value = "电子邮箱")
    @TableField("email")
    private String email;

    @ApiModelProperty(value = "身份证号")
    @TableField("identification")
    private String identification;

    @ApiModelProperty(value = "入职日期")
    @TableField("entry_date")
    private String entryDate;

    @ApiModelProperty(value = "出勤时间表")
    @TableField("work_time")
    private String workTime;

    @ApiModelProperty(value = "出勤时间表")
    @TableField("leave_time")
    private String leaveTime;

    @ApiModelProperty(value = "头像地址")
    @TableField("head_url")
    private String headUrl;

    @ApiModelProperty(value = "部门编号")
    @TableField("dept_id")
    private Long deptId;

    @ApiModelProperty(value = "职位编号")
    @TableField("post_id")
    private Long postId;

    @ApiModelProperty(value = "职位编号")
    @TableField("salary_id")
    private String salaryId;

    @ApiModelProperty(value = "状态字段(1表示可用，0表示停用)")
    @TableField("status")
    private Integer status;

    //角色列表
    @TableField(exist = false)
    private List<Role> roleList;

    //新密码
    @TableField(exist = false)
    private String newPwd;

    //岗位
    @TableField(exist = false)
    private String postName;

    //部门
    @TableField(exist = false)
    private String deptName;

    //工资账套
    @TableField(exist = false)
    private String salaryName;

    @TableField(exist = false)
    private Long basicSalary;

    @TableField(exist = false)
    private Long meritPay;

    @TableField(exist = false)
    private Long allowance;

    @TableField(exist = false)
    private Long bonus;

    @TableField(exist = false)
    private Long finsurances;

}
