<template>
  <n-config-provider :theme-overrides="themeOverrides">
    <router-view></router-view>
  </n-config-provider>
</template>

<script >
import { NConfigProvider } from "naive-ui";

export default {
  components: {
    NConfigProvider,
  },
  setup() {
    const themeOverrides = {
      common: {
        primaryColor: "#61BCFF", //方法一：总体设置
      },
      Button: {
        textColor: "#61BCFF",
      }
    };
    return {
      themeOverrides,
    };
  },
};
</script>

<style scoped>
</style>
