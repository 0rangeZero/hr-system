package com.czl.model.base;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Data
public class BaseEntity implements Serializable {

    // 创建时间
    @TableField("create_time")
    private Date createTime;

    // 更新时间
    @TableField("update_time")
    private Date updateTime;

    // 逻辑删除字段
    // 默认：0没有删除，1已经删除
    @TableLogic
    @TableField("is_deleted")
    private Integer isDeleted;

    @TableField(exist = false)
    private Map<String,Object> param = new HashMap<>();

}
