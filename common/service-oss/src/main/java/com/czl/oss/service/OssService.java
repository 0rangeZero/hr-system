package com.czl.oss.service;

import com.czl.model.system.User;
import org.springframework.web.multipart.MultipartFile;

public interface OssService {

    // 上传头像到OSS
    String uploadAvatar(MultipartFile file);

}



