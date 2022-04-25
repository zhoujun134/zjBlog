package com.zj.service.impl;

import com.zj.service.FileService;
import com.zj.utils.FileUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * @author junzhou
 * @date 2022/4/10 22:28
 * @since 1.8
 */
@Service
public class FileServiceImpl implements FileService {

    @Value("${upload.filePath}")
    private String rootImagePath;

    @Override
    public List<String> uploadImg(MultipartFile[] files, HttpServletRequest request) {
        List<String> images = new ArrayList<>();
        for (MultipartFile file : files) {
            String curFilePath = FileUtil.uploadImg(rootImagePath, file);
            String filePath = request.getScheme() + "://localhost:8081/uploadImg" + curFilePath;
            images.add(filePath);
        }
        return images;
    }
}
