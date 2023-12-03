package com.zj.controller;

import com.zj.domain.ResponseResult;
import com.zj.service.FileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author junzhou
 * @date 2022/4/10 22:20
 * @since 1.8
 */
@RestController
@RequestMapping("/file")
@Api(tags = "文件上传")
public class FileController {

    @Resource
    private FileService fileService;

    @ApiOperation(value = "上传图片")
    @PostMapping(value = "/image/uploadImage", consumes = "multipart/form-data")
    public ResponseResult<List<String>> upload(@RequestPart("file")
                                               @NotNull(message = "文件不能为空")
                                                           MultipartFile[] files,
                                               HttpServletRequest request){

        List<String> result = fileService.uploadImg(files, request);
        return ResponseResult.okResult(result);
    }

    @ApiOperation(value = "上传图片")
    @PostMapping(value = "/image/uploadOneImage", consumes = "multipart/form-data")
    public ResponseResult<String> upload(@RequestPart("file")
                                               @NotNull(message = "文件不能为空")
                                                       MultipartFile file,
                                               HttpServletRequest request){

        List<String> result = fileService.uploadImg(new MultipartFile[]{file},
                request);
        return ResponseResult.okResult(result.get(0));
    }
}
