<template>
  <n-config-provider :theme-overrides="themeOverrides">
    <router-view></router-view>
  </n-config-provider>
</template>

<script setup>
import { NConfigProvider } from "naive-ui";
const themeOverrides = {
  common: {
    primaryColor: "#61BCFF", //方法一：总体设置
  },
  Button: {
    textColor: "#61BCFF",
  },
};
</script>

<style scoped>
</style>
