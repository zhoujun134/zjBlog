package com.zj.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Slf4j
public class FileUtil {

    /**
     * <p>保存md文件</p>
     * 将字符串写入指定文件(当指定的父路径中文件夹不存在时，会最大限度去创建，以保证保存成功！)
     * @param content 保存的内容
     * @param rootPath 根目录
     * @param category 文章类别
     * @param fileName 文件名称
     * @return 保存的路径，如果保存失败返回 “error”
     */
      public static String saveMdFile(String content, String rootPath, String category, String fileName) {
        String mdFilePath = getMdFilePath(rootPath, category, fileName);
        BufferedReader bufferedReader = null;
        BufferedWriter bufferedWriter = null;
        try {
            File distFile = new File(mdFilePath);
            if (!distFile.getParentFile().exists()) {
                distFile.getParentFile()
                        .mkdirs();
            }
            bufferedReader = new BufferedReader(new StringReader(content));
            bufferedWriter = new BufferedWriter(new FileWriter(distFile));
            char buf[] = new char[1024];         //字符缓冲区
            int len;
            while ((len = bufferedReader.read(buf)) != -1) {
                bufferedWriter.write(buf, 0, len);
            }
            bufferedWriter.flush();
            bufferedReader.close();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return mdFilePath;
    }

    private static String getMdFilePath(String rootPath, String category, String fileName){
        SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/");
        String dateFormat = sdf.format(new Date());
        return String.format("%s/%s/%s/%s", rootPath, category, dateFormat, fileName);
    }

    public static String uploadImg(String rootImagePath, MultipartFile file){
        String filePath = "";
        // 获取绝对路径
        String realPath = rootImagePath;
        SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/");
        String format = sdf.format(new Date());
        //文件存放的目录
        File folder = new File(realPath + format);
        if (!folder.isDirectory()) {
            folder.mkdirs();
        }
        String oldName = file.getOriginalFilename();
        //文件后缀
        assert oldName != null;
        String suffix = oldName.substring(oldName.lastIndexOf("."));
        //文件新名字
        String newName = UUID.randomUUID().toString() + suffix;

        try {
            File targetFile = new File(folder, newName);
            if (!targetFile.exists()) {
                targetFile.mkdirs();
            } else {
                targetFile.delete();
            }
            file.transferTo(targetFile);
            filePath = format + newName;
        } catch (IOException e) {
            e.printStackTrace();
            return filePath;
        }
        return filePath;

    }

}
