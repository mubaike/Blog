<template>
  <header-nav @listRouter="listRouter"></header-nav>
  <div class="container">
    <div v-for="(blog, index) in blogListInfo" :key="blog.id">
      <my-card :blog="blog" @click="toDetail(blog)"></my-card>
    </div>
    <n-pagination
      v-if="pageInfo.count > pageInfo.pageSize"
      @update:page="loadBlogs"
      v-model:page="pageInfo.page"
      :page-count="pageInfo.pageCount"
    />
    <div v-if="pageInfo.count == 0">找不到更多啦</div>
    <!--分页-->
  </div>
</template> 

<script setup>
import HeaderNav from "../components/HeaderNav.vue";
import MyCard from "../components/MyCard.vue";

import { ref, reactive, inject, onMounted } from "vue";
import { useRouter, useRoute } from "vue-router";

// 路由
const router = useRouter();
const route = useRoute();

const message = inject("message");
const dialog = inject("dialog");
const axios = inject("axios");
// 文章列表
const blogListInfo = ref([]);

// 查询和分页数据
const pageInfo = reactive({
  page: 1,
  pageSize: 10,
  pageCount: 0,
  count: 0,
  keyword: "",
  categoryId: 0,
});

onMounted(() => {
  pageInfo.keyword = router.currentRoute.value.query.keyword || "";
  loadBlogs();
});

/**
 * 获取博客列表
 */
const loadBlogs = async (page = 0) => {
  if (page != 0) {
    pageInfo.page = page;
  }
  let res = await axios.get(
    `/blog/search?keyword=${pageInfo.keyword}&page=${pageInfo.page}&pageSize=${pageInfo.pageSize}&categoryId=${pageInfo.categoryId}`
  );
  let temp_rows = res.data.data.rows;
  // 处理获取的文章列表数据
  for (let row of temp_rows) {
    // row.content += "...";
    // 把时间戳转换为年月日
    let d = new Date(row.create_time);
    row.create_time = `${d.getFullYear()}年${
      d.getMonth() + 1
    }月${d.getDate()}日`;
  }
  blogListInfo.value = temp_rows;
  pageInfo.count = res.data.data.count;
  //计算分页大小
  pageInfo.pageCount =
    parseInt(pageInfo.count / pageInfo.pageSize) +
    (pageInfo.count % pageInfo.pageSize > 0 ? 1 : 0);
};

//页面跳转
const toDetail = (blog) => {
  let routeUrl = router.resolve({ path: "/detail", query: { id: blog.id } });
  window.open(routeUrl.href, "_blank");
};

//接收头部组件传来的数据
const listRouter = () => {
  setTimeout(() => {
    pageInfo.keyword = router.currentRoute.value.query.keyword || "";
    loadBlogs();
  });
};
</script>

<style lang="scss">
.container {
  width: 900px;
  margin: 100px auto;
  min-height: 800px;
}

</style>