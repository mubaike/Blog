<template>
  <header-nav></header-nav>
  <div class="container">
    <div class="nav">
      <div>
        <n-popselect
          @update:value="searchByCategory"
          v-model:value="selectedCategory"
          :options="categortyOptions"
          trigger="click"
        >
          <div>
            分类<span>{{ categoryName }}</span>
          </div>
        </n-popselect>
      </div>
    </div>
    <div
      v-for="(blog, index) in blogListInfo"
      style="margin-bottom: 15px; cursor: pointer"
    >
      <n-card :title="blog.title" @click="toDetail(blog)">
        {{ blog.content }}

        <template #footer>
          <n-space align="center">
            <div>发布时间：{{ blog.create_time }}</div>
          </n-space>
        </template>
      </n-card>
    </div>

    <n-pagination
      @update:page="loadBlogs"
      v-model:page="pageInfo.page"
      :page-count="pageInfo.pageCount"
    />
    <n-divider />
  </div>
  <footer-nav></footer-nav>
</template>

<script setup>
import HeaderNav from "../components/HeaderNav.vue";
import FooterNav from "../components/FooterNav.vue";

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
  loadCategorys();
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

const categoryName = computed(() => {
  //获取选中的分类
  let selectedOption = categortyOptions.value.find((option) => {
    return option.value == selectedCategory.value;
  });
  //返回分类的名称
  return selectedOption ? selectedOption.label : "";
});

/**
 * 获取分类列表
 */
const loadCategorys = async () => {
  let res = await axios.get("/category/list");
  categortyOptions.value = res.data.rows.map((item) => {
    return {
      label: item.name,
      value: item.id,
    };
  });
};

/**
 * 选中分类
 */
const searchByCategory = (categoryId) => {
  pageInfo.categoryId = categoryId;
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
  top: 75px;
  width: 900px;
  margin: 75px auto;
  min-height: 800px;
}

.nav {
  display: flex;
  font-size: 20px;
  padding-top: 20px;
  color: #64676a;

  div {
    cursor: pointer;
    margin-right: 15px;

    &:hover {
      color: #f60;
    }

    span {
      font-size: 12px;
    }
  }
}

</style>