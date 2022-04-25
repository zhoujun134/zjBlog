<template>
  <div class="commentContainer">
    <div class="commentListMain">
      <!-- 编辑部分！-->
      <el-card v-show="!commentEditorShow">
        未登陆,请
        <router-link :to="loginUrl">登录</router-link>
        后评论
      </el-card>
      <el-card v-show="commentEditorShow">
        <el-form style="width: 100%" :model="newComment">
          <el-form-item>
            <el-input
              style="width: 100%"
              v-model="newComment.content"
              :rows="2"
              type="textarea"
              placeholder="请输入..."
            />
          </el-form-item>

          <el-form-item style="align-items: center">
            <el-button style="margin: 0 auto" @click="addNewComment">
              发表
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>

      <!-- ---------------------评论信息列表展示----------------------------------->
      <el-card class="el-card" v-for="comment in commentList" :key="comment.id">
        <el-row>
          <el-col :span="4" style="display: flex">
            <el-avatar
              :size="50"
              style="margin: auto auto"
              :src="comment.user.avatar"
            />
          </el-col>
          <el-col :span="20" class="commentContent">
            <div>
              <span>
                {{ comment.user.nickName }}
              </span>
              <span style="margin-left: 10px">
                发表于: {{ comment.createAt }}
              </span>
            </div>
            <div style="margin-top: 10px">
              {{ comment.content }}
            </div>
            <div style="margin-top: 10px">
              <el-button @click="addLike(comment)" class="el-button--primary">
                <font-awesome-icon :icon="['fa', 'heart']" />
                <span class="likeButton">{{ comment.likes }}</span>
              </el-button>
            </div>
          </el-col>
        </el-row>
      </el-card>
      <!-- 评论分页信息-->
      <el-pagination
        background
        layout="prev, pager, next"
        :total="commentPageQuery.commentCount"
        :page-size="commentPageQuery.pageSize"
        :current-page="commentPageQuery.currPage"
        id="pagination"
        @current-change="onCurrentPageChanged"
        v-if="commentPageQuery.commentCount > 0"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { addComment, addCommentLike, getCommentList } from "@/api/comment";
import { ref } from "vue";
import { getUserInfo } from "@/utils/storage";

export default {
  name: "zjComment",
  setup(props) {
    let commentPageQuery = ref({
      commentCount: 0,
      pageSize: 5,
      currPage: 1,
    });

    let loginUrl = "/login";

    let commentEditorShow = false;
    let newComment = ref({});
    newComment.value = { content: "" };

    let userInfo = getUserInfo();
    if (userInfo != null) {
      commentEditorShow = true;
      newComment.value["articleId"] = props.id + "";
      newComment.value["toCommentUserId"] = userInfo.id;
    }

    let commentList = ref([]);

    // ======================= 初始化评论信息 ==================================
    function initCommentList(pageNum) {
      getCommentList({
        articleId: props.id,
        pageNum: pageNum,
        pageSize: commentPageQuery.value.pageSize,
      }).then((data) => {
        commentList.value = data.rows;
        commentPageQuery.value.commentCount = parseInt(data.total);
      });
    }

    initCommentList(commentPageQuery.value.currPage);

    // ======================= 添加新评论 ==================================
    function addNewComment() {
      addComment(newComment.value).then(() => {
        // 更新评论信息
        initCommentList(commentPageQuery.value.currPage);
      });
    }

    function addLike(comment) {
      addCommentLike(comment.id).then(() => {
        comment.likes = parseInt(comment.likes) + 1;
      });
    }

    function onCurrentPageChanged(pageNum) {
      initCommentList(pageNum);
      commentPageQuery.value.currPage = pageNum;
    }

    function deleteComment(comment, parent) {
      // ...
      console.log(comment + parent);
    }

    // =========================  评论信息列表获取 ==========================
    // function getCommentListInfo(pageNum, pageSize){
    //
    // }
    return {
      addComment,
      deleteComment,
      commentList,
      addLike,
      commentEditorShow,
      newComment,
      loginUrl,
      addNewComment,
      // 分页信息
      commentPageQuery,
      onCurrentPageChanged,
    };
  },
  props: {
    id: String,
  },
};
</script>

<style lang="less" scoped>
.commentContainer {
  width: 100%;
}

.commentListMain {
  width: 100%;
}

.commentContent {
  /*width: 100%;*/
  /*padding-left: 20px;*/
  align-items: center;
}

.replyButton {
  margin-top: 10px;
  margin-left: 10px;
}

.likeButton {
  margin-left: 10px;
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
.commentChildrenMain {
  margin-top: 10px;
}

.commentEditor {
  margin-top: 10px;
  width: 100%;
}
</style>
