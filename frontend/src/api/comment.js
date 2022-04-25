import request from "../utils/request";

/**
 * 获取评论信息列表
 * @returns promise
 */
function getCommentList(params) {
  return request({
    url: "/comment/commentList",
    params: params,
    method: "get",
  });
}

/**
 * 添加评论信息
 * @param data
 * @returns {AxiosPromise}
 */
function addComment(data) {
  return request({
    url: "/comment",
    method: "post",
    data: data,
    needAuthentication: true,
  });
}

/**
 * 点赞喜欢
 * @param id
 * @returns {AxiosPromise<any>}
 */
function addCommentLike(id) {
  return request({
    url: "/comment/like/" + id,
    method: "put",
    needAuthentication: false,
  });
}

export { getCommentList, addComment, addCommentLike };
