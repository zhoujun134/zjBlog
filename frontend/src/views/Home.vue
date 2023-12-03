<template>
  <div id="home">
    <!-- 页头 -->
    <zj-header />

    <!-- 封面 -->
    <zj-cover
      imgUrl="assets/image/home-cover.png"
      title="✨ zhouJun Blog ✨"
      content="这个世界并没有我看上去的那么简单，人各有命，上天注定。有人天生为王，有人落草为寇。脚下的路，如果不是你自己的选择。那这旅程的终点在哪儿，也没人知道。你会走到哪儿，会碰到谁。都不一定！"
    ></zj-cover>

    <div class="container">
      <!-- 侧边栏 -->
      <div class="side-content">
        <zj-admin-card />
        <zj-tag-card />
        <zj-hot-article-card />
        <zj-category-card />
        <zj-archive-card />
      </div>

      <!-- 发表的文章 -->
      <div class="post-article-list">
        <zj-post-article-card
          v-for="(article, index) in postArticles"
          :key="article.id"
          :article="article"
          :reverse="index % 2 === 1"
        />

        <!-- 分页 -->
        <el-pagination
          background
          layout="prev, pager, next"
          :total="articleCount"
          :page-size="pageSize"
          id="pagination"
          @current-change="onCurrentPageChanged"
          v-if="articleCount > 0"
        >
        </el-pagination>
      </div>
    </div>

    <!-- 页脚 -->
    <zj-footer :adminName="$store.state.adminAbout.adminInfo.nickName" />

    <!-- 滚动到顶部按钮 -->
    <zj-back-to-top />
  </div>
</template>

<script>
import { reactive, ref } from "vue";
import { getPostArticleList } from "@/api/article";
import { defaultThumbnail } from "@/utils/thumbnail";

export default {
  name: "Home",
  setup() {
    let pageSize = 10;
    let postArticles = reactive([]);
    let articleCount = ref(0);

    onCurrentPageChanged(1);

    function onCurrentPageChanged(pageNum) {
      getPostArticleList(pageNum, pageSize).then((data) => {
        articleCount.value = parseInt(data.total);
        data.rows.forEach((article) => {
          article.createTime = article.createTime.split(" ")[0];
          article.thumbnail = article.thumbnail || defaultThumbnail;
          // article.thumbnail = "https://cdn.seovx.com/ha/?mom=302";
        });
        postArticles.splice(0, postArticles.length, ...data.rows);
      });
    }

    return {
      postArticles,
      articleCount,
      pageSize,
      onCurrentPageChanged,
    };
  },
};
</script>

<style lang="less" scoped>
#home {
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

.post-article-list {
  width: 74%;

  .post-article-card {
    margin-top: 20px;
  }

  .post-article-card:nth-child(1) {
    margin-top: 0;
  }
}

.side-content {
  width: 26%;
  margin-right: 20px;
}

:deep(#pagination) {
  margin-top: 20px;
  justify-content: center;

  & > button {
    box-shadow: var(--card-box-shadow);
    background: white;
    border-radius: 8px;
    height: 35px;
    width: 35px;
  }

  li {
    box-shadow: var(--card-box-shadow);
    background-color: white;
    border-radius: 8px;
    margin: 0 6px;
    height: 35px;
    width: 35px;
  }

  li.active {
    color: white;
    background: var(--theme-color);
    font-weight: normal;
  }
}

@media screen and (max-width: 900px) {
  .side-content {
    display: none;
  }

  .post-article-list {
    width: 100%;
  }
}

@keyframes fadeInUp {
  from {
    margin-top: 50px;
    opacity: 0;
  }

  to {
    margin-top: 0;
    opacity: 1;
  }
}
</style>
