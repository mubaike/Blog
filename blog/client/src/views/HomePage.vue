<template>
  <header-nav></header-nav>
  
  <div class="container">
    <side-bar @categoryId="selCategory"></side-bar>
    <div class="main">
      <div
        v-for="(blog, index) in blogListInfo"
        :key="blog.id"
        @click="toDetail(blog)"
      >
        <my-card :blog="blog"></my-card>
      </div>

      <!--分页器-->
      <n-pagination
        @update:page="loadBlogs"
        v-model:page="pageInfo.page"
        :page-count="pageInfo.pageCount"
        v-if="pageInfo.count > pageInfo.pageSize"
      />
      <n-divider />
    </div>
  </div>
  <footer-nav></footer-nav>
</template>

<script setup>
import HeaderNav from "../components/HeaderNav.vue";
import FooterNav from "../components/FooterNav.vue";
import SideBar from "../components/SideBar.vue";
import MyCard from "../components/MyCard.vue";

import { ref, reactive, inject, onMounted, computed } from "vue";
import { useRouter, useRoute } from "vue-router";

// 路由
const router = useRouter();
const route = useRoute();

const message = inject("message");
const dialog = inject("dialog");
const axios = inject("axios");

// 选中的分类
const selectedCategory = ref(0);
// 分类选项
const categortyOptions = ref([]);
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
    row.content += "...";
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
  // console.log(res)
};

/**
 * 选中分类
 */
const selCategory = (i) => {
  pageInfo.categoryId = i;
  document.documentElement.scrollTop = 0;
  loadBlogs();
};

//页面跳转
const toDetail = (blog) => {
  let routeUrl = router.resolve({ path: "/detail", query: { id: blog.id } });
  window.open(routeUrl.href, "_blank");
};
</script>

<style lang="scss" scoped>
.container {
  position: relative;
  display: flex;
  // top: 75px;
  width: 1300px;
  margin: 75px auto 0;
  min-height: 900px;
  align-items: flex-start;
}

.main {
  padding-top: 15px;
  margin-left: 20px;
}
</style>