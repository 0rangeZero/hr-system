package com.czl.model.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class SalaryQueryVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String deptName;

    private Long deptId;

}
