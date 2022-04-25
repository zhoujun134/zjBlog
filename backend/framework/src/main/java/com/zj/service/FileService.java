package com.zj.service;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author junzhou
 * @date 2022/4/10 22:24
 * @since 1.8
 */
public interface FileService {

    List<String> uploadImg(MultipartFile[] files, HttpServletRequest request);
}
