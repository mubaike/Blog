<template>
  <div class="sidebar">
    <div class="header">
      <img class="header-back" />
      <img class="header-pic" src="../../public/nahida.png" />
      <p class="name">木白</p>
    </div>
    <div class="size-main">
      <div class="nav">导航</div>
      <p class="iconfont iconriqi" @click="homePage">
        &#xe64f;&nbsp;&nbsp;&nbsp;首页
      </p>
      <p class="iconfont iconriqi" @click="toSearch">
        &#xe752;&nbsp;&nbsp;&nbsp;搜索
      </p>
      <n-popselect
        @update:value="searchByCategory"
        v-model:value="selectedCategory"
        :options="categortyOptions"
        trigger="click"
      >
        <p class="iconfont iconriqi">&#xe71b;&nbsp;&nbsp;&nbsp;分类</p>
      </n-popselect>
    </div>
  </div>
</template>

<script setup>
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

onMounted(() => {
  loadCategorys();
});

const homePage = () => {
  router.push("/");
};

const toSearch = () => {
  router.push("/search");
};


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

const emit = defineEmits(['categoryId']);
/**
 * 选中分类
 */
 const searchByCategory = (categoryId) => {
  emit('categoryId',categoryId)
};

</script>

<style lang="scss" scoped>
.sidebar {
  width: 230px;
  height: 350px;
  margin-top: 15px;
  margin-right: 20px;
  box-shadow: 0 0 35px 0 rgba(154, 161, 171, 0.15);
  background-color: #ffffff;
  border-radius: 5px;
  color: #666666;

  .header {
    position: relative;
    background-image: url("../../public/waves.png");
    background-repeat: no-repeat;
    .header-back {
      width: 230px;
    }

    .header-pic {
      display: block;
      margin: 0 auto;
      width: 50px;
      margin-top: 20px;
      border: 5px solid #ffffff;
      box-shadow: 0 0 35px 0 rgba(154, 161, 171, 0.15);
      overflow: hidden;
      border-radius: 100%;
    }

    .name {
      text-align: center;
      font-weight: bold;
      font-size: 12px;
    }
  }

  .size-main {
    margin-left: 40px;
    margin-top: 40px;

    .nav {
      font-size: 12px;
      font-weight: bold;
    }

    p {
      margin-top: 20px;
      font-size: 15px;

      &:hover {
        color: #61bcff;
      }
    }
  }
}
</style>