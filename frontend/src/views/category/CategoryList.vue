<template>
  <div id="category-list">
    <!-- 页头 -->
    <zj-header />

    <!-- 二次元封面 -->
    <zj-wife-cover>
      <h1>分类</h1>
    </zj-wife-cover>

    <div class="container">
      <!-- 侧边栏 -->
      <div class="side-content">
        <zj-admin-card />
        <zj-tag-card />
        <zj-archive-card />
        <zj-hot-article-card />
      </div>

      <zj-word-cloud-card :words="categoryCounts" baseUrl="/category" />
    </div>

    <!-- 页脚 -->
    <zj-footer />

    <!-- 回到顶部 -->
    <zj-back-to-top />
  </div>
</template>

<script>
import { mapState } from "../../store/map";

export default {
  name: "CategoryList",
  setup() {
    window.scrollTo({ top: 0 });
    let { categoryCounts } = mapState("categoryAbout");

    return { categoryCounts };
  }
};
</script>

<style lang="less" scoped>
#category-list {
  height: 100%;
  width: 100%;
}

.container {
  padding: 40px 15px;
  max-width: 1300px;
  margin: 0 auto;
  display: flex;
  animation: fadeInUp 1s;
}

.wife-cover {
  display: flex;
  align-items: center;
  justify-content: center;

  h1 {
    width: 100%;
    text-align: center;
    position: absolute;
    text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
    font-size: 40px;
    color: white;
    line-height: 1.5;
    margin-bottom: 15px;
    padding: 0 30px;
    box-sizing: border-box;
  }
}

.side-content {
  width: 26%;
  margin-right: 20px;
}

.cloud-card {
  width: 74%;
  margin: 0;
}

@media screen and (max-width: 900px) {
  .side-content {
    display: none;
  }

  .cloud-card {
    width: 100%;
  }
}
</style>
