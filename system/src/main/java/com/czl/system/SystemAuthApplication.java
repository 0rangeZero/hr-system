package com.czl.system;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(basePackages = "com.czl.system.mapper")
@SpringBootApplication
public class SystemAuthApplication {

    public static void main(String[] args) {
        SpringApplication.run(SystemAuthApplication.class, args);
    }

}
