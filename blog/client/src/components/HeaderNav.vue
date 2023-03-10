<template>
  <div class="navbar-custom">
    <div class="container-fluid">
      <!--loge-->
      <span class="topnav-logo" @click="homePage">
        <img src="../assets/picture/logo.png" alt="" height="60" />
      </span>

      <!--搜索-->
      <form>
        <div class="input-group">
          <input
            type="text"
            class="form-control iconfont iconriqi"
            v-model="keyword"
            placeholder=" &#xe752; 请输入关键字..."
          />
          <button
            class="input-group-text"
            type="submit"
            @click.prevent="handleSubmit"
            @click="toSearch"
          >
            搜索
          </button>
        </div>
      </form>
      <span class="iconfont iconriqi user" @click="dashboard">&#xe620;</span>
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

const keyword = ref([]);

const emit = defineEmits(["listRouter"]);

const homePage = () => {
  router.push("/");
};
const toSearch = () => {
  router.push({ path: "/search", query: { keyword: keyword.value } });
  emit("listRouter");
};

const dashboard = () => {
  router.push("/login");
};
</script>

<style lang="scss" scoped>
.navbar-custom {
  position: fixed;
  display: flex;
  width: 100%;
  top: 0;
  right: 0;
  box-shadow: 0 0 35px 0 rgba(154, 161, 171, 0.15);
  z-index: 1001;
  min-height: 70px;
  background-color: #ffffff;
  border: 1px solid #ffffff;
  .container-fluid {
    position: relative;
    width: 1300px;
    margin: 0 auto;
    display: flex;
    .topnav-logo {
      line-height: 70px;
      float: left;
      padding: 5px 20px 0 20px;
      height: 30px;
    }
    .input-group {
      display: flex;
      margin-top: 15px;
      width: 330px;
      .form-control {
        display: block;
        width: 200px;
        padding: 7px 14px;
        margin-left: 40px;
        font-size: 14px;
        line-height: 1.5;
        color: #6c757d;
        background-color: #f5fafe;
        border: none;
        border-radius: 3px;
        &:focus {
          color: #6c757d;
          outline: 0;
        }
      }
      .input-group-text {
        display: flex;
        padding: 7px 14px;
        font-size: 14px;
        line-height: 1.5;
        text-align: center;
        border: 1px solid #dee2e6;
        border-radius: 3px;
        color: #fff;
        background-color: #61bcff;
        border-color: #61bcff;
        &:hover {
          background-color: #43aefa;
        }
        &:active {
          box-shadow: 0 0 4px #03a9f4;
        }
      }
    }
    .user {
      position: absolute;
      font-size: 30px;
      padding-right: 10px;
      right: 0;
      color: #61bcff;
      line-height: 70px;
      cursor: pointer;
    }
  }
}
</style>