package com.czl.oss.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.PutObjectRequest;
import com.aliyun.oss.model.PutObjectResult;
import com.czl.model.system.User;
import com.czl.oss.service.OssService;
import com.czl.oss.utils.ConstantPropertiesUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class OssServiceImpl implements OssService {

    // 上传头像到OSS
    @Override
    public String uploadAvatar(MultipartFile file) {

        // 获取文件名称
        String filename = file.getOriginalFilename();
        // 为文件名称添加随机的唯一值
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        filename = uuid + filename;

        // 将文件按日期分类
        LocalDateTime date = LocalDateTime.now();
        String year = date.getYear() + "";
        String month = date.getMonthValue() + "";
        String day = date.getDayOfMonth() + "";
        String datePath = year + "/" + month + "/" + day;
        filename = datePath + "/" + filename;

        // 地域节点
        String endpoint = ConstantPropertiesUtils.END_POINT;
        // 访问id和密钥
        String accessKeyId = ConstantPropertiesUtils.ACCESS_KEY_ID;
        String accessKeySecret = ConstantPropertiesUtils.ACCESS_KEY_SECRET;
        // Bucket名称
        String bucketName = ConstantPropertiesUtils.BUCKET_NAME;

        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        try {
            // 获取上传文件输入流。
            InputStream inputStream = file.getInputStream();
            // 创建PutObjectRequest对象。
            // objectName: 上传到oss的文件路劲和文件名称
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, filename, inputStream);
            // 设置该属性可以返回response。如果不设置，则返回的response为空。
            putObjectRequest.setProcess("true");
            // 创建PutObject请求。
            PutObjectResult result = ossClient.putObject(putObjectRequest);
            // 如果上传成功，则返回200。
            System.out.println(result.getResponse().getStatusCode());
            // 将上传到阿里云oss的路径进行拼接。
            String url = "https://" + bucketName + "." + endpoint + "/" + filename;
            // 返回url路径给前端。
            return url;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

}