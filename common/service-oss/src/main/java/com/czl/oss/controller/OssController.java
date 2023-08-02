package com.czl.oss.controller;

import com.czl.model.system.User;
import com.czl.oss.service.OssService;
import com.czl.system.result.Result;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@CrossOrigin
@RestController
@RequestMapping("/hross/file")
public class OssController {

    @Autowired
    private OssService ossService;

    @PostMapping("uploadOssHeadUrl")
    public Result uploadOssHeadUrl(MultipartFile file) {
        String url = ossService.uploadAvatar(file);
        return Result.ok(url);
    }

}
