package com.czl.model.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class PostQueryVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String postName;

    private String deptName;

}
