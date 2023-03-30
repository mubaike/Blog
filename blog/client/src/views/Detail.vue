<template>
  <header-nav></header-nav>
  <div class="container">
    <div class="body">
      <!-- 标题 -->
      <h1>{{ blogInfo.title }}</h1>
      <!--文本标签-->
      <div class="textlabel">
        来自分类：<span class="textcategory">{{ blogInfo.name }}</span>
        创建时间：<span>{{ blogInfo.create_time }}</span>
      </div>
      <!-- 文章内容 -->
      <div class="blog-content">
        <p v-highlight v-html="blogInfo.content"></p>
      </div>
    </div>
  </div>
</template>

<script setup>
import HeaderNav from "../components/HeaderNav.vue";

import { ref, reactive, inject, onMounted, computed } from "vue";
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();
const blogInfo = ref({});
const axios = inject("axios");

onMounted(() => {
  loadBlog();
});

/**
 * 读取文章详情
 */
const loadBlog = async () => {
  let res = await axios.get("/blog/detail?id=" + route.query.id);
  blogInfo.value = res.data.rows[0];

  //时间转换
  let d = new Date(blogInfo.value.create_time);
  blogInfo.value.create_time = `${d.getFullYear()}年${
    d.getMonth() + 1
  }月${d.getDate()}日`;
};
</script>

<style lang="scss" scoped>
.container {
  .body {
    width: 50%;
    min-width: 500px;
    padding: 15px 30px 5px 30px;
    margin-top: 85px;
    margin-bottom: 20px;
    margin-right: auto;
    margin-left: auto;
    box-shadow: 0 0 35px 0 rgba(154, 161, 171, 0.15);
    background-color: #ffffff;
    border-radius: 5px;
    color: #666666;

    .textlabel {
      display: block;
      height: 40px;
      line-height: 40px;
      padding-left: 20px;
      font-size: 13px;
      border-radius: 5px;
      color: #999999;
      background-color: #f7f8fc;
      overflow: hidden;
      .textcategory {
        color: #ffaa00;
        margin-right: 50px;
      }
    }

    .blog-content {
      // img {
      //   max-width: 100% !important;
      // }

      /* table 样式 */
      :deep(table) {
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
      }
      :deep(table td), :deep(table th) {
        border-bottom: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 3px 5px;
      }
      :deep(table th) {
        border-bottom: 2px solid #ccc;
        text-align: center;
      }

      //   /* blockquote 样式 引用样式 */
      blockquote {
        display: block;
        border-left: 8px solid #d0e5f2;
        padding: 5px 10px;
        margin: 10px 0;
        line-height: 1.4;
        font-size: 100%;
        background-color: #f1f1f1;
      }

      blockquote p {
        padding: 10px 0;
      }

      /* ul ol 样式 */
      ul, ol {
        margin: 10px 0 10px 20px;
      }
    }
  }
}
</style>