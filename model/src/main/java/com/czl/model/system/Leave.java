package com.czl.model.system;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.czl.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Data
@TableName("`leave`")
@ApiModel(description = "请假")
public class Leave extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "请假单号")
    @TableId("leave_id")
    private String leaveId;

    @ApiModelProperty("请假天数")
    @TableField("leave_days")
    private Integer leaveDays;

    @ApiModelProperty("请假时间")
    @TableField("leave_time")
    private String leaveTime;

    @ApiModelProperty("请假理由")
    @TableField("leave_reason")
    private String leaveReason;

    @ApiModelProperty("请假用户编号")
    @TableField("user_id")
    private Long userId;

    @ApiModelProperty("是否通过(1表示通过，0表示不通过，2表示待审批)")
    @TableField("passed")
    private Integer passed;

    @TableField(exist = false)
    private String workId;

    @TableField(exist = false)
    private String name;

    @TableField(exist = false)
    private String sex;

}
