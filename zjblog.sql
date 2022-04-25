/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : zjblog

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 25/04/2022 15:36:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `access_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名',
  `permission` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限标识',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '权限状态（0正常 1停用）',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (1, '发表博客', 'article:add', '0', NULL, NULL, NULL, NULL, 0, 'NULL');
INSERT INTO `access` VALUES (2, '删除博客', 'article:delete', '0', NULL, NULL, NULL, NULL, 0, 'NULL');
INSERT INTO `access` VALUES (3, '编辑博客', 'article:edit', '0', NULL, NULL, NULL, NULL, 0, 'NULL');
INSERT INTO `access` VALUES (4, '查看博客', 'article:view', '0', NULL, NULL, NULL, NULL, 0, 'NULL');
INSERT INTO `access` VALUES (5, '评论博客', 'comment:add', '0', NULL, NULL, NULL, NULL, 0, '评论权限');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章内容',
  `summary` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章摘要',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '所属分类id',
  `thumbnail` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `is_top` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否置顶（0否，1是）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '状态（0已发布，1草稿）',
  `view_count` bigint(20) NULL DEFAULT 0 COMMENT '访问量',
  `is_comment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否允许评论 1是，0否',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '如何在 pyqt 中解决国际化 tr() 函数不管用的问题', '# 前言\n\n有些时候我们在父类中使用了 `self.tr(\'XXX\')`，使用 Qt Linguist 完成翻译并导出 qm 文件后，发现子类中仍然是英文原文。比如下面这段代码：\n\n```python\nclass AlbumCardBase(QWidget):\n    \"\"\" 专辑卡基类 \"\"\"\n\n    def __init__(self, parent=None):\n        super().__init__(parent=parent)\n        self.playButton = BlurButton(\n            self,\n            (30, 65),\n            \":/images/album_tab_interface/Play.png\",\n            self.coverPath,\n            self.tr(\'Play\')\n        )\n        self.addToButton = BlurButton(\n            self,\n            (100, 65),\n            \":/images/album_tab_interface/Add.png\",\n            self.coverPath,\n            self.tr(\'Add to\')\n        )\n```\n\n父类 `AlbumCardBase` 中有两处使用了 `tr` 函数，分别翻译为 `播放` 和 `添加到`，但是在子类中这些文本仍然会显示为 `Play` 和 `Add to`，下面来看看如何解决这个问题。\n\n# 解决过程\n\n生成的 ts 文件中，有这样一段代码：\n\n```xml\n<context>\n    <name>AlbumCardBase</name>\n    <message>\n        <location filename=\"../../components/album_card/album_card_base.py\" line=\"50\"/>\n        <source>Add to</source>\n        <translation>添加到</translation>\n    </message>\n    <message>\n        <location filename=\"../../components/album_card/album_card_base.py\" line=\"43\"/>\n        <source>Play</source>\n        <translation>播放</translation>\n    </message>\n</context>\n```\n\n可以看到上述代码描述了源文的位置和内容以及译文，但是只对父类 `AlbumCardBase` 起作用。要想对子类应用上述规则，只需复制粘贴再修改 `<name>` 标签中的类名即可，比如 `AlbumCard` 为子类，那么只需添加下述代码：\n\n```xml\n<context>\n    <name>AlbumCard</name>\n    <message>\n        <location filename=\"../../components/album_card/album_card_base.py\" line=\"50\"/>\n        <source>Add to</source>\n        <translation>添加到</translation>\n    </message>\n    <message>\n        <location filename=\"../../components/album_card/album_card_base.py\" line=\"43\"/>\n        <source>Play</source>\n        <translation>播放</translation>\n    </message>\n</context>\n```\n\n完成上述步骤后导出 qm 文件即可。\n', '前言\n有些时候我们在父类中使用了 self.tr(\'XXX\')，使用 Qt Linguist 完成翻译并导出 qm 文件后，发现子类中仍然是英文原文。比如下面这段代码：\nclass AlbumCardBase(QWidget):\n    &quot;&quot;&quot; 专辑卡基类 &quot;', 2, 'https://i.niupic.com/images/2022/03/14/9Ws2.png', '0', '0', 154, '1', 1, '2022-03-14 00:27:57', 1, '2022-03-14 00:27:57', 0);
INSERT INTO `article` VALUES (2, '如何在 Vue3 中处理 img 标签图片加载错误的问题', '# 前言\n\n有时因为图片路径错误等问题，`<img>` 标签中的图片无法正确加载，就会呈现出图裂的模样，很影响界面的美观。这时候我们可以使用默认的图片来替换掉无法加载的图片，下面就来看下如何实现这个过程。\n\n# 实现方式\n\n`<img>` 标签中的图片无法正常加载时，会触发 `onerror` 事件，所以我们可以给这个事件绑定一个回调 `useDefaultImage`，下面是实现代码：\n\n```html\n<template>\n    <img\n        :src=\"data.thumbnail\"\n        @error.once=\"useDefaultImage\"\n        alt=\"缩略图\"\n    />\n</template>\n\n<script>\nexport default {\n    setup() {\n        let defaultThumbnail = require(\"@/assets/image/article-thumbnail.jpg\");\n\n        function useDefaultImage(event) {\n            event.target.src = defaultThumbnail;\n        }\n\n        return { useDefaultImage };\n    },\n};\n</script>\n```\n\n正常情况下用了上述代码之后就能加载默认图片了，但是有一种情况下仍然无法触发 `onerror` 事件：服务器返回的数据 `data` 没有 `thumbnail` 属性（比如在响应结果类上使用了 Jackson 的  `@JsonInclude(JsonInclude.Include.NON_NULL)` 注解），此时为 `data.thumbnail` 就会是 `undefined`，无法触发 `onerror` 事件，所以可以在拿到响应数据的时候处理一下为空的情况，用默认图片路径来替换。\n', '前言\n有时因为图片路径错误等问题，&lt;img&gt; 标签中的图片无法正确加载，就会呈现出图裂的模样，很影响界面的美观。这时候我们可以使用默认的图片来替换掉无法加载的图片，下面就来看下如何实现这个过程。\n实现方式\n&lt;img&gt; 标签中的图片无法正常加载时，会触发 onerror 事件，', 4, 'https://i.niupic.com/images/2022/03/12/9Wma.png ', '0', '0', 161, '1', 1, '2022-03-13 23:59:15', 1, '2022-03-13 23:59:15', 0);
INSERT INTO `article` VALUES (3, '对 python 中 @property 装饰器的一点思考', '# 前言\npython 中提供了 `@property` 装饰器，可以将一个成员函数变为成员变量来访问，之前只是觉得这东西应该就只是为了 `setter` 和 `getter` 而存在的，但是学了 Vue 的计算属性后对这个装饰器有了新的见解。\n\n# 计算属性\n在 Vue 中提供了计算属性 `computed`，避免在模板中写出很长的表达式。仔细想想，用了 `@property` 装饰器的方法不就是计算属性的 `get()` 吗，然后 `@property.setter` 不就是 `set()` 吗？有了 `get()` 之后，当一个变量发生变化时，计算属性也随之发生变化，这样在更新变量时没必要手动在代码中更新计算属性的值，代码看起来就更加简洁了。比如，有以下代码：\n```python\nclass ImageViewer:\n\n    def __init__(self):\n        self.imagePaths = [\'キラキラ.png\', \'恋をしたのは.png\']\n        self.index = 0\n\n    def next(self):\n        if self.index >= len(self.imagePaths)-1:\n            return\n\n        self.index += 1\n\n    def previous(self):\n        if self.index <= 0\n            return\n\n        self.index -= 1\n\n    @property\n    def imagePath(self):\n        return self.imagePaths[self.index]\n```\n有了 `@property` 之后，每次访问到的 `imagePath` 都会是最新的，没必要在 `next()` 方法和 `previous()` 中再写一行更新 `imagePath` 的代码，我们只需维护好 `index` 即可，以上~', 'python 中提供了 `@property` 装饰器，可以将一个成员函数变为成员变量来访问，之前只是觉得这东西应该就只是为了 `setter` 和 `getter` 而存在的，但是学了 Vue 的计算属性后对这个装饰器有了新的见解。', 2, 'https://i.niupic.com/images/2022/03/12/9Wme.jpg', '0', '0', 129, '1', 1, '2022-02-12 22:32:45', 1, '2022-03-12 22:32:45', 0);
INSERT INTO `article` VALUES (4, '测试 Kila Kila Blog 的博客样式', '# 字符效果\n\n* ~~删除线~~ <s>删除线（开启识别HTML标签时）</s>\n\n* *斜体字* _斜体字_\n* **粗体** __粗体__\n* ***粗斜体*** ___粗斜体___\n\n* 上标：X<sub>2</sub>，下标：O<sup>2</sup>\n\n* ==高亮==\n\n* `Inline Code`\n\n> 引用：如果想要插入空白换行（即 `<br>` 标签），在插入处先键入两个以上的空格然后回车即可\n\n\n#  超链接\n* [普通链接](https://www.cnblogs.com/zhiyiYo/)\n* [*斜体链接*](https://www.cnblogs.com/zhiyiYo/)\n* [**粗体链接**](https://www.cnblogs.com/zhiyiYo/)\n\n# 脚注\n这是一个简单的脚注 [^1] 而这是一个更长的脚注 [^bignote].\n\n[^1]: 这是第一个脚注.\n\n[^bignote]: 这是一个非常长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长的脚注.\n\n\n# 图像\n下面是一张我家硝子的壁纸?:\n![硝子1](https://i.niupic.com/images/2022/03/11/9Wl7.jpg)\n再来一张好了?：\n![硝子2](https://i.niupic.com/images/2022/03/12/9Wme.jpg)\n\n# 代码\n\n## 行内代码\n在 VS Code 中按下 <kbd>Alt</kbd> + <kbd>T</kbd> + <kbd>R</kbd> 执行命令：`npm install marked`\n\n## 代码片\n\n### Python 代码\n```python\nclass Animal:\n    \"\"\" 动物类 \"\"\"\n\n    def __init__(self, age: int, name: str):\n        self.age = age\n        self.name = name\n\n    def getInfo(self) -> str:\n        \"\"\" 返回信息 \"\"\"\n        return f\'age: {self.age}; name: {self.name}\'\n\n\nclass Dog(Animal):\n    \"\"\" 狗狗类 \"\"\"\n\n    def __init__(self, age: int, name: str, gender=\'female\', color=\'white\'):\n        super().__init__(age, name)\n        self.gender = gender\n        self.__color = color\n\n    def bark(self):\n        \"\"\" 狗叫 \"\"\"\n        print(\'lololo\')\n\n    @property\n    def color(self):\n        return self.__color\n\n    @color.setter\n    def color(self, color: str):\n        if color not in [\'red\', \'white\', \'black\']:\n            raise ValueError(\'颜色不符合要求\')\n        self.__color = color\n\n\nif __name__ == \'__main__\':\n    dog = Dog(16, \'啸天\', gender=\'male\')\n    # 狗叫\n    dog.bark()\n    # 设置狗狗毛色\n    dog.color = \'blue\'\n```\n\n### HTML 代码\n\n```html\n<!DOCTYPE html>\n<html>\n    <head>\n        <mate charest=\"utf-8\" />\n        <title>Hello world!</title>\n    </head>\n    <body>\n        <h1>Hello world!</h1>\n    </body>\n</html>\n```\n\n\n\n# 列表\n\n## 无序列表\n\n* 福建\n  * 厦门\n  * 福州\n* 浙江\n* 江苏\n## 有序列表\n\n1. 动物\n   1. 人类\n   2. 犬类\n2. 植物\n3. 微生物\n\n## 任务列表\n\n- [x] 预习计算机网络\n- [ ] 复习现代控制理论\n- [ ] 刷现代控制理论历年卷\n    - [ ] 2019 年期末试卷\n    - [ ] 2020 年期末试卷\n\n\n\n# 表格\n\n| 项目   |  价格 | 数量  |\n| ------ | ----: | :---: |\n| 计算机 | $1600 |   5   |\n| 手机   |   $12 |  12   |\n| 管线   |    $1 |  234  |\n\n----\n\n# 特殊符号\n\n&copy; &  &uml; &trade; &iexcl; &pound;\n&amp; &lt; &gt; &yen; &euro; &reg; &plusmn; &para; &sect; &brvbar; &macr; &laquo; &middot;\n\nX&sup2; Y&sup3; &frac34; &frac14;  &times;  &divide;   &raquo;\n\n18&ordm;C  &quot;  &apos;\n\n# Emoji表情 :satisfied:\n* 马：:horse:\n* 星星：:star2:\n* 笑脸：:smile:\n* 跑步：:running:\n\n# 数学公式\n\n行间公式：\n$$\\sin(\\alpha)^{\\theta}=\\sum_{i=0}^{n}(x^i + \\cos(f))$$\n行内公式 $E=mc^2$\n\n# 绘图\n## 时序图\n\n```mermaid\nsequenceDiagram\n\n  Alice->>John: Hello John, how are you?\n  loop Healthcheck\n      John->>John: Fight against hypochondria\n  end\n  Note right of John: Rational thoughts!\n       John-->>Alice: Great!\n       John->>Bob   : How about you?\n       Bob-->>John  : Jolly good!\n```\n\n\n## 状态图\n\n```mermaid\nstateDiagram\n\n    [*]-->Active\n    state Active {\n        [*]-->NumLockOff\n        NumLockOff-->NumLockOn : EvNumLockPressed\n        NumLockOn-->NumLockOff : EvNumLockPressed\n        --\n        [*]-->CapsLockOff\n        CapsLockOff-->CapsLockOn : EvCapsLockPressed\n        CapsLockOn-->CapsLockOff : EvCapsLockPressed\n        --\n        [*]-->ScrollLockOff\n        ScrollLockOff-->ScrollLockOn : EvCapsLockPressed\n        ScrollLockOn-->ScrollLockOff : EvCapsLockPressed\n            }\n```', '这篇博客用来测试 Kila Kila Blog 的正文样式', 1, 'https://i.niupic.com/images/2022/03/11/9Wl7.jpg', '1', '0', 165, '1', 1, '2022-01-12 21:16:07', 1, '2022-03-12 21:16:07', 0);
INSERT INTO `article` VALUES (5, '如何在 IDEA 中配置 Easy Code 的 MybatisPlus 实体类模板', '# 前言\nEasy Code 是一个很强大的插件，可以根据数据库的表结构生成对应的实体类、Mapper 接口等代码，省去了编写没有技术含量的代码的工作，极大提升敲代码的效率。但是如果仅仅使用预置的模板可能无法满足我们的需求，这时候就可以自己去定制模板。下面给出实体类的模板。\n\n# 实现流程\n\n我们希望实体类满足以下需求：\n\n* 使用 Lombok 的 `@Data`、`@NoArgsConstructor` 和 `@AllArgsConstructor` 注解\n* 使用 `@TableName` 注解让实体类应该和数据库的表名对应\n* 实现 `Serializable` 接口\n* 在主键字段上使用 `@TableId` 注解\n\n对应的模板如下所示：\n\n```java\n##导入宏定义\n$!{define.vm}\n\n##保存文件（宏定义）\n#save(\"/entity\", \".java\")\n\n##包路径（宏定义）\n#setPackageSuffix(\"entity\")\n\n##自动导入包（全局变量）\n$!{autoImport.vm}\nimport java.io.Serializable;\n\nimport com.baomidou.mybatisplus.annotation.IdType;\nimport com.baomidou.mybatisplus.annotation.TableId;\nimport com.baomidou.mybatisplus.annotation.TableName;\nimport lombok.Data;\nimport lombok.AllArgsConstructor;\nimport lombok.NoArgsConstructor;\n\n##表注释（宏定义）\n#tableComment(\"表实体类\")\n@SuppressWarnings(\"serial\")\n@Data\n@AllArgsConstructor\n@NoArgsConstructor\n@TableName(\"$!{tableInfo.obj.name}\")\npublic class $!{tableInfo.name} implements Serializable {\n\n    private static final long serialVersionUID = $!tool.serial();\n\n#foreach($column in $tableInfo.fullColumn)\n    #if(${column.comment})/**\n     * ${column.comment}\n     */#end\n    \n  #if($column.name.equals(\'id\'))\n  @TableId(type = IdType.AUTO)\n  #end\n  private $!{tool.getClsNameByFullName($column.type)} $!{column.name}; \n    \n#end\n\n}\n\n```\n\n', '前言\nEasy Code 是一个很强大的插件，可以根据数据库的表结构生成对应的实体类、Mapper 接口等代码，省去了编写没有技术含量的代码的工作，极大提升敲代码的效率。但是如果仅仅使用预置的模板可能无法满足我们的需求，这时候就可以自己去定制模板。下面给出实体类的模板。\n实现流程\n我们希望实体类满足', 3, 'https://i.niupic.com/images/2022/03/11/9Wl4.jpg', '0', '0', 65, '1', 1, '2021-12-13 13:24:53', 1, '2022-03-13 13:24:53', 0);
INSERT INTO `article` VALUES (6, '如何处理 SSD 神经网络在小目标检测数据集上 mAP 和置信度较低的问题', '# 前言\nSSD 的神经网络结构很简洁，可以较好的实现多尺度的目标检测，但是对小目标物体的检测效果并不是很好。虽然有很多 SSD 的魔改版本，比如 FSSD 和 DSSD，提高了 SSD 在小目标检测上的表现，但是这里我们只讨论怎么使用 SSD 来更好地检测小目标，尤其是那些特征非常简单的目标。\n\n# YOLO 的启发\n在 Yolo V3 中使用了先验框聚类的方式来决定先验框的尺寸，而在 SSD 的原始版本中是通过公式来决定先验框的尺寸，最小的先验框尺寸都有 30。如果我们的目标很小，比如只有十几像素，那么使用这些先验框训练出来的 SSD 模型的表现大概率是差强人意的。所以我们可以在自己的数据集上对先验框进行聚类，下面给出聚类的代码：\n```python\n# coding:utf-8\nfrom pathlib import Path\nfrom xml.etree import ElementTree as ET\n\nimport numpy as np\n\n\n\ndef iou(box: np.ndarray, boxes: np.ndarray):\n    \"\"\" 计算一个边界框和其他边界框的交并比\n    Parameters\n    ----------\n    box: `~np.ndarray` of shape `(4, )`\n        边界框\n    boxes: `~np.ndarray` of shape `(n, 4)`\n        其他边界框\n\n    Returns\n    -------\n    iou: `~np.ndarray` of shape `(n, )`\n        交并比\n    \"\"\"\n    # 计算交集\n    xy_max = np.minimum(boxes[:, 2:], box[2:])\n    xy_min = np.maximum(boxes[:, :2], box[:2])\n    inter = np.clip(xy_max-xy_min, a_min=0, a_max=np.inf)\n    inter = inter[:, 0]*inter[:, 1]\n\n    # 计算并集\n    area_boxes = (boxes[:, 2]-boxes[:, 0])*(boxes[:, 3]-boxes[:, 1])\n    area_box = (box[2]-box[0])*(box[3]-box[1])\n\n    # 计算 iou\n    iou = inter/(area_box+area_boxes-inter)  # type: np.ndarray\n    return iou\n\n\nclass AnchorKmeans:\n    \"\"\" 先验框聚类 \"\"\"\n\n    def __init__(self, annotation_dir: str):\n        self.annotation_dir = Path(annotation_dir)\n        if not self.annotation_dir.exists():\n            raise ValueError(f\'标签文件夹 `{annotation_dir}` 不存在\')\n\n        self.bbox = self.get_bbox()\n\n    def get_bbox(self) -> np.ndarray:\n        \"\"\" 获取所有的边界框 \"\"\"\n        bbox = []\n\n        for path in self.annotation_dir.glob(\'*.xml\'):\n            root = ET.parse(path).getroot()\n\n            # 图像的宽度和高度\n            w = int(root.find(\'size/width\').text)\n            h = int(root.find(\'size/height\').text)\n\n            # 获取所有边界框\n            for obj in root.iter(\'object\'):\n                box = obj.find(\'bndbox\')\n\n                # 归一化坐标\n                xmin = int(box.find(\'xmin\').text)/w\n                ymin = int(box.find(\'ymin\').text)/h\n                xmax = int(box.find(\'xmax\').text)/w\n                ymax = int(box.find(\'ymax\').text)/h\n\n                bbox.append([0, 0, xmax-xmin, ymax-ymin])\n\n        return np.array(bbox)\n\n    def get_cluster(self, n_clusters=9, metric=np.median):\n        \"\"\" 获取聚类结果\n\n        Parameters\n        ----------\n        n_clusters: int\n            聚类数\n\n        metric: callable\n            选取聚类中心点的方式\n        \"\"\"\n        rows = self.bbox.shape[0]\n\n        if rows < n_clusters:\n            raise ValueError(\"n_clusters 不能大于边界框样本数\")\n\n        last_clusters = np.zeros(rows)\n        clusters = np.ones((n_clusters, 2))\n        distances = np.zeros((rows, n_clusters))  # type:np.ndarray\n\n        # 随机选取出几个点作为聚类中心\n        np.random.seed(1)\n        clusters = self.bbox[np.random.choice(rows, n_clusters, replace=False)]\n\n        # 开始聚类\n        while True:\n            # 计算距离\n            distances = 1-self.iou(clusters)\n\n            # 将每一个边界框划到一个聚类中\n            nearest_clusters = distances.argmin(axis=1)\n\n            # 如果聚类中心不再变化就退出\n            if np.array_equal(nearest_clusters, last_clusters):\n                break\n\n            # 重新选取聚类中心\n            for i in range(n_clusters):\n                clusters[i] = metric(self.bbox[nearest_clusters == i], axis=0)\n\n            last_clusters = nearest_clusters\n\n        return clusters[:, 2:]\n\n    def average_iou(self, clusters: np.ndarray):\n        \"\"\" 计算 IOU 均值\n\n        Parameters\n        ----------\n        clusters: `~np.ndarray` of shape `(n_clusters, 2)`\n            聚类中心\n        \"\"\"\n        clusters = np.hstack((np.zeros((clusters.shape[0], 2)), clusters))\n        return np.mean([np.max(iou(bbox, clusters)) for bbox in self.bbox])\n\n    def iou(self, clusters: np.ndarray):\n        \"\"\" 计算所有边界框和所有聚类中心的交并比\n\n        Parameters\n        ----------\n        clusters: `~np.ndarray` of shape `(n_clusters, 4)`\n            聚类中心\n\n        Returns\n        -------\n        iou: `~np.ndarray` of shape `(n_bbox, n_clusters)`\n            交并比\n        \"\"\"\n        bbox = self.bbox\n        A = self.bbox.shape[0]\n        B = clusters.shape[0]\n\n        xy_max = np.minimum(bbox[:, np.newaxis, 2:].repeat(B, axis=1),\n                            np.broadcast_to(clusters[:, 2:], (A, B, 2)))\n        xy_min = np.maximum(bbox[:, np.newaxis, :2].repeat(B, axis=1),\n                            np.broadcast_to(clusters[:, :2], (A, B, 2)))\n\n        # 计算交集面积\n        inter = np.clip(xy_max-xy_min, a_min=0, a_max=np.inf)\n        inter = inter[:, :, 0]*inter[:, :, 1]\n\n        # 计算每个矩阵的面积\n        area_bbox = ((bbox[:, 2]-bbox[:, 0])*(bbox[:, 3] -\n                     bbox[:, 1]))[:, np.newaxis].repeat(B, axis=1)\n        area_clusters = ((clusters[:, 2] - clusters[:, 0])*(\n            clusters[:, 3] - clusters[:, 1]))[np.newaxis, :].repeat(A, axis=0)\n\n        return inter/(area_bbox+area_clusters-inter)\n\n\nif __name__ == \'__main__\':\n    # 标签文件夹\n    root = \'data/Hotspot/Annotations\'\n    model = AnchorKmeans(root)\n    clusters = model.get_cluster(9)\n\n    # 将先验框还原为原本的大小\n    print(\'聚类结果:\\n\', clusters*300)\n    print(\'平均 IOU:\', model.average_iou(clusters))\n```\n\n将代码中的先验框尺寸参照聚类的结果进行修改，不出意外的话是可以提升 mAP 和置信度的，以上~~\n', '前言\nSSD 的神经网络结构很简洁，可以较好的实现多尺度的目标检测，但是对小目标物体的检测效果并不是很好。虽然有很多 SSD 的魔改版本，比如 FSSD 和 DSSD，提高了 SSD 在小目标检测上的表现，但是这里我们只讨论怎么使用 SSD 来更好地检测小目标，尤其是那些特征非常简单的目标。\nYOL', 2, 'https://i.niupic.com/images/2022/03/11/9Wl0.png ', '0', '0', 14, '1', 1, '2021-11-09 00:30:14', 1, '2022-03-14 00:30:14', 0);
INSERT INTO `article` VALUES (26, 'VUE3 制作评论信息模块', '## 1. 注意事项\n制作 VUE3 评论模块\n## 2. 代码\n\n```javascript\n<template>\n  <div class=\"commentContainer\">\n    <div class=\"commentListMain\">\n      <el-card class=\"el-card \" v-for=\"comment in commentList\" :key=\"comment.id\">\n        <el-row>\n          <el-col span=\"6\">\n            <el-avatar :size=\"50\" :src=\"comment.user.avatar\" />\n          </el-col>\n          <el-col span=\"18\" class=\"commentContent\">\n            <div><span> {{ comment.createAt }}</span></div>\n            <div style=\"margin-top: 10px;\">\n              {{ comment.content }}\n            </div>\n            <div>\n              <span>\n\n              <el-button @click=\"comment\" class=\"el-button--warning\" style=\"margin-top: 10px;\">\n                <font-awesome-icon :icon=\"[\'fas\', \'heart\']\"  id=\"faHeart\" />\n                <span style=\"margin-left: 5px\">{{ comment.likes }}</span>\n              </el-button>\n\n              </span>\n              <span>\n              <el-button @click=\"comment\" class=\"el-button--primary replyButton\">\n                <font-awesome-icon :icon=\"[\'fas\', \'pen\']\"  id=\"faPen\" /></el-button>\n              </span>\n            </div>\n          </el-col>\n        </el-row>\n        <el-row\n          class=\"commentChildrenMain\"\n          v-if=\"comment.children.length !== 0\"\n          v-for=\"children in comment.children\">\n          <el-card class=\"el-card\" style=\"width: 100%\">\n            <el-row>\n              <el-col span=\"6\">\n                <el-avatar :size=\"50\" style=\"align-items: center\" :src=\"children.user.avatar\" />\n              </el-col>\n              <el-col span=\"18\" class=\"commentContent\">\n                <div><span> {{ children.createAt }}</span></div>\n                <div>\n                  {{ children.content }}\n                </div>\n              </el-col>\n            </el-row>\n          </el-card>\n        </el-row>\n\n      </el-card>\n    </div>\n\n\n  </div>\n</template>\n\n<script>\nimport { getCommentList } from \"@/api/comment\";\nimport { ref } from \"vue\";\n\nexport default {\n  name: \"zjComment\",\n  setup: function(props) {\n    let currentUser = {\n      name: \"周君\",\n      avatar: \"https://i.niupic.com/images/2022/03/11/9WkX.jpg\",\n      author: false\n    };\n\n    let commentProps = {\n      id: \"\", // 唯一 id，必需\n      content: \"\", // 评论内容，必需\n      imgSrc: \"\", // 评论中的图片地址，非必需\n      children: [], // 子评论（回复），非必需\n      likes: 0, // 点赞数，非必需\n      liked: false, // 是否已点赞，非必需\n      reply: null, // 子评论（回复）人信息，非必需\n      createAt: null, // 评论时间，必需\n      user: {\n        // 评论人信息，必需\n        author: false // 是否为作者，类型为 Boolean，非必需\n      }\n    };\n\n    let commentList = ref([]);\n    getCommentList({ articleId: 1, pageNum: 1, pageSize: 10 }).then((data) => {\n      commentList.value = data.rows;\n    });\n\n    function addComment(comment, parent, add) {\n      // ...\n      console.log(comment + parent);\n\n      // 需调用 add 函数，并传入 newComment 对象\n      add(props.newComment);\n    }\n\n    function deleteComment(comment, parent) {\n      // ...\n      console.log(comment + parent);\n    }\n\n    function likeComment(comment) {\n      // ...\n      console.log(comment);\n    }\n\n    // =========================  评论信息列表获取 ==========================\n    // function getCommentListInfo(pageNum, pageSize){\n    //\n    // }\n    return {\n      currentUser,\n      addComment,\n      deleteComment,\n      likeComment,\n      commentProps,\n      commentList\n    };\n  }\n};\n</script>\n\n<style scoped lang=\"css\">\n.commentContainer {\n  width: 100%;\n}\n\n.commentListMain {\n  width: 100%;\n}\n\n.commentContent {\n  /*width: 100%;*/\n  padding-left: 20px;\n}\n\n.replyButton{\n  margin-top: 10px;\n  margin-left: 10px;\n}\n\n.commentChildrenMain{\n  margin-top: 10px;\n}\n</style>\n\n```\n', 'VUE3 制作评论信息模块', 4, 'http://localhost:8081/uploadImg/2022/04/21/c9e6c162-086b-4d9f-b0cc-89a64efecb0e.jpg', '0', '0', 26, '1', 1, '2022-04-21 00:07:48', 1, '2022-04-21 00:07:48', 0);
INSERT INTO `article` VALUES (27, '这是我的一个测试信息', 'd asa sdas das a\n测试内容![测试图片信息](https://cdn.jsdelivr.net/gh/520ck/cdnseovx/1/I/l/1/I/l/seovx-com-2018%20(218).jpg)', '测测测测', 3, 'http://localhost:8081/uploadImg/2022/04/24/ea2fdd28-9c13-46bd-9150-9d99d97eed0d.jpg', '0', '0', 1, '1', 1, '2022-04-24 09:57:25', 1, '2022-04-24 09:57:25', 0);
INSERT INTO `article` VALUES (28, '这是我的一个测试信息', 'd asa sdas das a\n测试内容![测试图片信息](https://cdn.jsdelivr.net/gh/520ck/cdnseovx/1/I/l/1/I/l/seovx-com-2018%20(218).jpg)', '测测测测', 3, 'http://localhost:8081/uploadImg/2022/04/24/ea2fdd28-9c13-46bd-9150-9d99d97eed0d.jpg', '0', '0', 3, '1', 1, '2022-04-24 09:58:48', 1, '2022-04-24 09:58:48', 0);
INSERT INTO `article` VALUES (29, '这是我的一个测试信息', 'd asa sdas das a\n测试内容![测试图片信息](https://cdn.jsdelivr.net/gh/520ck/cdnseovx/1/I/l/1/I/l/seovx-com-2018%20(218).jpg)', '测测测测', 3, 'http://localhost:8081/uploadImg/2022/04/24/ea2fdd28-9c13-46bd-9150-9d99d97eed0d.jpg', '0', '0', 7, '1', 1, '2022-04-24 09:59:26', 1, '2022-04-24 09:59:26', 0);

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag`  (
  `article_id` bigint(20) NOT NULL COMMENT '文章 ID',
  `tag_id` bigint(20) NOT NULL COMMENT '标签 ID',
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章-标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tag
-- ----------------------------
INSERT INTO `article_tag` VALUES (1, 2);
INSERT INTO `article_tag` VALUES (1, 8);
INSERT INTO `article_tag` VALUES (2, 6);
INSERT INTO `article_tag` VALUES (2, 7);
INSERT INTO `article_tag` VALUES (3, 2);
INSERT INTO `article_tag` VALUES (3, 3);
INSERT INTO `article_tag` VALUES (3, 4);
INSERT INTO `article_tag` VALUES (4, 1);
INSERT INTO `article_tag` VALUES (4, 7);
INSERT INTO `article_tag` VALUES (5, 5);
INSERT INTO `article_tag` VALUES (6, 2);
INSERT INTO `article_tag` VALUES (6, 9);
INSERT INTO `article_tag` VALUES (6, 10);
INSERT INTO `article_tag` VALUES (26, 32);
INSERT INTO `article_tag` VALUES (26, 33);
INSERT INTO `article_tag` VALUES (29, 34);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `pid` bigint(20) NULL DEFAULT -1 COMMENT '父分类id，如果没有父分类为-1',
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态0:正常,1禁用',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'markdown', -1, 'Markdown 是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档。', '0', 1, '2022-03-12 14:51:53', NULL, '2022-01-12 14:51:53', 0);
INSERT INTO `category` VALUES (2, 'python', -1, 'Python 是世界上最好的语言', '0', 1, '2022-03-12 22:32:45', NULL, '2022-02-12 14:51:53', 0);
INSERT INTO `category` VALUES (3, 'java', -1, 'java 是由 Sun Microsystems 公司于 1995 年 5 月推出的 Java 面向对象程序设计语言和 Java 平台的总称。', '0', 1, '2022-03-12 22:56:36', NULL, '2022-03-12 22:56:36', 0);
INSERT INTO `category` VALUES (4, 'vue3', -1, NULL, '0', 1, '2022-03-13 23:59:15', 1, '2022-03-13 23:59:15', 0);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) NULL DEFAULT NULL COMMENT '文章id',
  `root_id` bigint(20) NULL DEFAULT -1 COMMENT '根评论id',
  `content` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `to_comment_user_id` bigint(20) NULL DEFAULT -1 COMMENT '所回复的目标评论的userid',
  `to_comment_id` bigint(20) NULL DEFAULT -1 COMMENT '回复目标评论id',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `like_count` bigint(20) NULL DEFAULT 0,
  `reply_count` bigint(20) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, -1, '吃到了一颗好吃的糖，想跟你的嘴巴分享', -1, -1, 1, '2022-01-29 07:59:22', 1, '2022-04-23 21:43:44', 0, 22, 0);
INSERT INTO `comment` VALUES (2, 1, -1, '抱歉不如抱我', -1, -1, 1, '2022-01-29 08:01:24', 1, '2022-04-23 21:43:45', 0, 17, 0);
INSERT INTO `comment` VALUES (3, 1, -1, '躲得过初一躲不过你', -1, -1, 1, '2022-01-29 16:07:24', 1, '2022-04-23 20:37:22', 0, 5, 0);
INSERT INTO `comment` VALUES (4, 1, -1, '打算搬家，搬到你心里', -1, -1, 1, '2022-01-29 16:12:09', 1, '2022-04-24 09:39:13', 0, 8, 0);
INSERT INTO `comment` VALUES (5, 1, -1, '黑虎掠过秃鹰', -1, -1, 1, '2022-01-29 18:19:56', 1, '2022-04-24 09:39:15', 0, 6, 0);
INSERT INTO `comment` VALUES (6, 1, -1, '龙卷风摧毁停车场', -1, -1, 1, '2022-01-29 22:13:52', 1, '2022-04-24 10:22:01', 0, 17, 0);
INSERT INTO `comment` VALUES (7, 1, 2, '马尾甩苍蝇', 1, 2, 1, '2022-01-29 22:18:40', 1, '2022-01-29 22:18:40', 0, 0, 0);
INSERT INTO `comment` VALUES (8, 1, 2, '哈哈哈哈', 1, 2, 1, '2022-01-29 22:29:15', 1, '2022-01-29 22:29:15', 0, 0, 0);
INSERT INTO `comment` VALUES (9, 1, 2, '不愧是你', 1, 10, 3, '2022-01-29 22:29:55', 1, '2022-01-29 22:29:55', 0, 0, 0);
INSERT INTO `comment` VALUES (57, 4, -1, '12爱仕达大所的', 14787164048664, -1, 14787164048664, '2022-04-23 20:16:33', 14787164048664, '2022-04-23 20:16:33', 0, 0, 0);
INSERT INTO `comment` VALUES (58, 4, -1, '这是一条测试评论信息', 14787164048664, -1, 14787164048664, '2022-04-23 20:22:54', 14787164048664, '2022-04-23 20:22:54', 0, 0, 0);
INSERT INTO `comment` VALUES (59, 6, -1, 'as阿萨德阿打算', 14787164048664, -1, 14787164048664, '2022-04-24 08:43:44', 14787164048664, '2022-04-24 08:44:03', 0, 4, 0);
INSERT INTO `comment` VALUES (60, 6, -1, 'as阿萨德阿打算', 14787164048664, -1, 14787164048664, '2022-04-24 08:43:55', 14787164048664, '2022-04-24 10:20:33', 0, 4, 0);
INSERT INTO `comment` VALUES (61, 6, -1, 'as阿萨德阿打算', 14787164048664, -1, 14787164048664, '2022-04-24 08:43:57', 14787164048664, '2022-04-24 08:44:00', 0, 6, 0);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色权限字符串',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '角色状态（0正常 1停用）',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT 'del_flag',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', 'admin', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `role` VALUES (2, '普通用户', 'normal_user', '0', 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `access_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '权限id',
  PRIMARY KEY (`role_id`, `access_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES (1, 1);
INSERT INTO `role_access` VALUES (1, 2);
INSERT INTO `role_access` VALUES (1, 3);
INSERT INTO `role_access` VALUES (1, 4);
INSERT INTO `role_access` VALUES (1, 5);
INSERT INTO `role_access` VALUES (2, 4);
INSERT INTO `role_access` VALUES (2, 5);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, 'markdown', 1, '2022-01-12 14:51:53', NULL, '2022-01-12 14:51:53', 0);
INSERT INTO `tag` VALUES (2, 'python', 1, '2022-02-12 22:32:45', NULL, '2022-02-12 22:32:45', 0);
INSERT INTO `tag` VALUES (3, '装饰器', 1, '2022-02-12 22:32:45', NULL, '2022-02-12 22:32:45', 0);
INSERT INTO `tag` VALUES (4, '计算属性', 1, '2022-02-12 22:32:45', NULL, '2022-02-12 22:32:45', 0);
INSERT INTO `tag` VALUES (5, 'IDEA', 1, '2022-03-12 22:56:36', NULL, '2022-03-12 22:56:36', 0);
INSERT INTO `tag` VALUES (6, 'vue', 1, '2022-03-13 23:59:15', 1, '2022-03-13 23:59:15', 0);
INSERT INTO `tag` VALUES (7, '前端', 1, '2022-03-13 23:59:15', 1, '2022-03-13 23:59:15', 0);
INSERT INTO `tag` VALUES (8, 'pyqt', 1, '2022-03-14 00:27:57', 1, '2022-03-14 00:27:57', 0);
INSERT INTO `tag` VALUES (9, 'deep-learning', 1, '2022-03-14 00:30:14', 1, '2022-03-14 00:30:14', 0);
INSERT INTO `tag` VALUES (10, 'SSD', 1, '2022-03-14 00:30:14', 1, '2022-03-14 00:30:14', 0);
INSERT INTO `tag` VALUES (32, 'vue3', 1, '2022-04-21 00:07:48', 1, '2022-04-21 00:07:48', 0);
INSERT INTO `tag` VALUES (33, 'vue3 评论', 1, '2022-04-21 00:07:48', 1, '2022-04-21 00:07:48', 0);
INSERT INTO `tag` VALUES (34, 'java', 1, '2022-04-24 09:57:25', 1, '2022-04-24 09:57:25', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'NULL' COMMENT '用户名',
  `nick_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'NULL' COMMENT '昵称',
  `signature` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '用一句话来介绍自己' COMMENT '个性签名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'NULL' COMMENT '密码',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户类型：0 代表普通用户，1 代表管理员(只能有一个)',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phonenumber` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户性别（0男，1女，2未知）',
  `avatar` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人的用户id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14787164048665 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'zhoujun134', 'zhoujun134', 'そうやって悲しい日を越えてきた', '$2a$10$85O7itxkvpWpxevQstpDguKN4ZUivWhXQJKhtgg7w/vzyQ7nIGFv6', '1', '0', '1319158137@qq.com', '18888888888', '0', 'https://img1.baidu.com/it/u=3257266420,40463730&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', NULL, '2022-01-05 09:01:56', 1, '2022-01-30 15:37:03', 0);
INSERT INTO `user` VALUES (2, 'shoko', '西宫硝子', '我稀饭你', '$2a$10$85O7itxkvpWpxevQstpDguKN4ZUivWhXQJKhtgg7w/vzyQ7nIGFv6', '0', '0', 'shoko@qq.com', NULL, '1', 'https://img1.baidu.com/it/u=3257266420,40463730&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', NULL, '2022-01-05 13:28:43', NULL, '2022-01-05 13:28:43', 0);
INSERT INTO `user` VALUES (3, 'aiko', '柳井爱子', '恋爱教主', '$2a$10$85O7itxkvpWpxevQstpDguKN4ZUivWhXQJKhtgg7w/vzyQ7nIGFv6', '0', '0', 'aiko@qq.com', '19098790742', '1', 'https://p2.music.126.net/mskP_5EAxxEuRlIL9u36UA==/109951165339187641.jpg?param=130y130', NULL, NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (4, 'sana', '鎖那', 'シュガーナイフに聞いてみる', '$2a$10$85O7itxkvpWpxevQstpDguKN4ZUivWhXQJKhtgg7w/vzyQ7nIGFv6', '0', '0', 'sana@qq.com', '18246845873', '1', 'https://p1.music.126.net/Hj-D_3AO9XLIzhREgoGtFw==/109951166584238723.jpg?param=130y130', NULL, '2022-01-06 03:51:13', NULL, '2022-01-06 07:00:50', 0);
INSERT INTO `user` VALUES (5, 'RADWIMPS', 'RADWIMPS', '君の前前前世から僕は君を探し始めたよ', '$2a$10$85O7itxkvpWpxevQstpDguKN4ZUivWhXQJKhtgg7w/vzyQ7nIGFv6', '0', '0', 'RADWIMPS@qq.com', '17777777777', '0', 'https://p1.music.126.net/LnBs-T-dIvDpQjTkLh1umw==/109951166202952894.jpg?param=130y130', NULL, '2022-01-16 06:54:26', NULL, '2022-01-16 07:06:34', 0);
INSERT INTO `user` VALUES (14787164048664, 'tomzhou', '测试账号', '用一句话来介绍自己', '$2a$10$OWNd67l5wD/TUFSVgJSG2.6vF9iOt.nNhYZIzUfsqw1n.9K7LqlJy', '0', '0', '1543190168@qq.com', NULL, NULL, NULL, NULL, '2022-04-23 09:19:24', NULL, '2022-04-23 09:19:24', 0);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `role_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14787164048665 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1);
INSERT INTO `user_role` VALUES (2, 2);
INSERT INTO `user_role` VALUES (3, 2);
INSERT INTO `user_role` VALUES (4, 2);
INSERT INTO `user_role` VALUES (5, 2);
INSERT INTO `user_role` VALUES (14787164048664, 2);

SET FOREIGN_KEY_CHECKS = 1;
