package com.czl.system.result;

import lombok.Getter;

@Getter
public enum  ResultCodeEnum {

    SUCCESS(200,"成功"),
    FAIL(201, "失败"),
    SERVICE_ERROR(2012, "服务异常"),
    DATA_ERROR(204, "数据异常"),
    ILLEGAL_REQUEST(205, "非法请求"),
    REPEAT_SUBMIT(206, "重复提交"),
    ARGUMENT_VALID_ERROR(210, "参数校验异常"),
    REPEAT_USERNAME(211, "用户名已存在"),
    WRONG_PASSWORD(212, "密码错误"),
    NULL_USERNAME(213, "请输入用户名"),
    NULL_PASSWORD(219, "请输入密码"),

    LOGIN_AUTH(208, "未登陆"),
    PERMISSION(209, "没有权限"),
    ACCOUNT_ERROR(214, "账号不正确"),
    PASSWORD_ERROR(215, "密码错误"),
    LOGIN_MOBLE_ERROR( 216, "用户名不正确"),
    ACCOUNT_STOP( 217, "账号已停用，请联系管理员"),
    NODE_ERROR( 218, "该节点下有子节点，不可以删除");

    private Integer code;

    private String message;

    private ResultCodeEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

}
