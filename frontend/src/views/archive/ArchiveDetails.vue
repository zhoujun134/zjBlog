<template>
  <div id="archive-details">
    <!-- 页头 -->
    <zj-header />

    <!-- 二次元封面 -->
    <zj-wife-cover>
      <div class="archive-info">
        <h1 class="archive-date">{{ year }} 年 {{ month }} 月</h1>
      </div>
    </zj-wife-cover>

    <div class="container">
      <!-- 侧边栏 -->
      <div class="side-content">
        <zj-admin-card />
        <zj-hot-article-card />
        <zj-category-card />
        <zj-tag-card />
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
    <zj-footer />

    <!-- 回到顶部 -->
    <zj-back-to-top />
  </div>
</template>

<script>
import { reactive, ref } from "vue";
import { getPostArticleList } from "@/api/article";
import { defaultThumbnail } from "@/utils/thumbnail";
import ZjAdminCard from "@/components/zjAdminCard.vue";
import ZjHotArticleCard from "@/components/zjHotArticleCard.vue";
import ZjCategoryCard from "@/components/zjCategoryCard.vue";
import ZjTagCard from "@/components/zjTagCard.vue";
import ZjArchiveCard from "@/components/zjArchiveCard.vue";
import ZjWifeCover from "@/components/zjWifeCover.vue";
import ZjHeader from "@/components/zjHeader.vue";

export default {
  name: "ArchiveDetails",
  components: { ZjHeader, ZjWifeCover, ZjArchiveCard, ZjTagCard, ZjCategoryCard, ZjHotArticleCard, ZjAdminCard },
  setup(props) {
    let pageSize = 10;
    let postArticles = reactive([]);
    let articleCount = ref(0);

    onCurrentPageChanged(1);

    function onCurrentPageChanged(pageNum) {
      getPostArticleList(
        pageNum,
        pageSize,
        null,
        null,
        props.year + "/" + props.month
      ).then((data) => {
        articleCount.value = parseInt(data.total);
        data.rows.forEach((article) => {
          article.createTime = article.createTime.split(" ")[0];
          article.thumbnail = article.thumbnail || defaultThumbnail;
        });

        postArticles.splice(0, postArticles.length, ...data.rows);
      });
    }

    window.scrollTo({ top: 0 });

    return {
      postArticles,
      articleCount,
      pageSize,
      onCurrentPageChanged,
    };
  },
  props: ["year", "month"],
};
</script>

<style lang="less" scoped>
#archive-details {
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

  .archive-info {
    text-align: center;
    position: absolute;
    width: 100%;
    text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);

    .archive-date {
      font-size: 40px;
      color: white;
      line-height: 1.5;
      margin-bottom: 15px;
      padding: 0 30px;
      overflow: hidden;
      display: -webkit-box;
      text-overflow: ellipsis;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
    }
  }
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
