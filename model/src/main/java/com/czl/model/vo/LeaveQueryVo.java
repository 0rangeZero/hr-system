package com.czl.model.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class LeaveQueryVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long userId;

    private String keywords;

    private String createTimeBegin;

    private String createTimeEnd;

    private Long passed;

}
