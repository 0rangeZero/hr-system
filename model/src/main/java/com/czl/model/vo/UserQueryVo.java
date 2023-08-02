package com.czl.model.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class UserQueryVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String keyword;

    private String createTimeBegin;
    private String createTimeEnd;

    private Long userId;
    private Long roleId;
    private Long postId;
    private Long deptId;

}
