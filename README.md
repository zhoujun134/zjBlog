# zjBlog
zj个人博客
该博客采用springBoot搭建后端，vue3搭建的前端博客展示内容。

## 后端采用技术
> springBoot 2.5.0
> 
> mybatis-plus 3.5.1 
> 
> springfox-swagger2 2.9.2
> 
> mapstruct 1.4.2 
> 
> redis 6.2.0 
> 
> Mysql 5.7
### 部署
下载文件之后。打开 `backend`项目， 然后编辑 `backend/blog/src/main/resources/application.yml` 文件。
+ 首先用mysql创建一个数据库，并执行`zjBlog.sql`文件。
+ 将 `url`改为自己的数据库地址，用户名和用户密码。`filePath`为自己的图片存放地址。
```yaml
spring:
  datasource:
    url: 自己的mysql数据库地址
    username: 用户名
    password: 用户密码
upload:
  filePath: 自己存放文件的地址，比如 “F:/zjBlog/uploadImg/”
  staticAccessPath: /uploadImg/**
```


## 前端技术
> vue 3.0.0 
> 
> vue-easy-lightbox 1.4.1
> 
> axios 0.17.0 
> 
> element-plus 2.0.4
> 
> highlight.js 11.4.0

前端项目为 `frontend`，部署方式如下: 

### 项目安装
```
npm install
```

#### Compiles and hot-reloads for development
```
npm run serve
```

#### Compiles and minifies for production
```
npm run build
```

#### Lints and fixes files
```
npm run lint
```

## Reference:
<a href="https://github.com/"></a>
