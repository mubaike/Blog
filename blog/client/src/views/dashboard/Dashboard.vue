<template>
  <div class="main-panel">
    <div class="menus">
      <div v-for="(menu, index) in menus" @click="toPage(menu)">
        {{ menu.name }}
      </div>
    </div>
    <div style="padding: 20px; width: 100%">
      <router-view></router-view>
    </div>
  </div>
</template>

<script setup>
import { AdminStore } from "../../stores/AdminStore";
import { ref, reactive, inject } from "vue";
import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute();

const message = inject("message");
const axios = inject("axios");

const adminStore = AdminStore();

let menus = [
  { name: "文章管理", href: "/dashboard/article" },
  { name: "分类管理", href: "/dashboard/category" },
  { name: "退出", href: "logout" },
];

const toPage = (menu) => {
  if (menu.href == "logout") {
    router.push("/")
  } else {
    router.push(menu.href)
  }
};
</script>

<style lang="scss" scoped>
.main-panel {
  display: flex;
  color: #64676a;
  max-width: 1500px;
  margin: 0 auto;
}

.menus {
  padding: 20px 0;
  box-sizing: border-box;
  line-height: 55px;
  text-align: center;
  width: 180px;
  height: 96vh;
  border-right: 1px solid #dadada;

  div {
    cursor: pointer;
    &:hover {
      color: #61BCFF;
    }
  }
}
</style>