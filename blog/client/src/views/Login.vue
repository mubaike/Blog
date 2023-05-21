<template>
  <div class="body">
    <div class="box">
      <div class="left"></div>
      <div class="right">
        <h4>登 录</h4>
        <form :rules="rules" :model="admin">
          <input
            class="acc"
            type="text"
            v-model="admin.account"
            placeholder="用户名"
          />
          <input
            class="acc"
            type="password"
            v-model="admin.password"
            placeholder="密码"
          />
          <div class="remember">
            <input type="checkbox" v-model="admin.rember" />
            <label>记住我</label>
          </div>
          <input class="but" type="button" value="Login" @click="login" />
          <input class="but" type="button" value="cancel" @click="cancel" />
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, inject } from "vue";
import { AdminStore } from "../stores/AdminStore";

import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute();

const message = inject("message");
const axios = inject("axios");
const adminStore = AdminStore();

const admin = reactive({
  account: localStorage.getItem("account") || "",
  password: localStorage.getItem("password") || "",
  rember: localStorage.getItem("rember") == 1 || false,
});

const login = async () => {
  let result = await axios.post("admin/login", {
    account: admin.account,
    password: admin.password,
  });
  if (result.data.code == 200) {
    adminStore.token = result.data.data.token;
    sessionStorage.setItem("TOKEN", result.data.data.token);
    adminStore.account = result.data.data.account;
    adminStore.id = result.data.data.id;

    if (admin.rember) {
      localStorage.setItem("account", admin.account);
      localStorage.setItem("password", admin.password);
      localStorage.setItem("rember", admin.rember ? 1 : 0);
    } else {
      localStorage.clear();
    }
    router.push("/dashboard/article");
    message.info("登录成功");
  } else {
    message.error("登录失败");
  }
};

const cancel = async () => {
  router.push("/");
};
</script>

<style lang="scss" scoped>
.body {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  position: fixed;
  z-index: -1;
  display: flex;
  // background: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%) no-repeat;
  background: linear-gradient(120deg, #8ec5fc 0%, #b3cee9 100%) no-repeat;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;

  .box {
    display: flex;
    overflow: hidden;
    width: 900px;
    height: 550px;
    color: #fff;
    background-color: rgba(255, 255, 255, 60%);
    border-radius: 10px;
    // margin: 10% auto;
    margin: auto;
    box-shadow: 0 0 10 2 rgb(0 0 0 / 10%);
    .left {
      position: relative;
      width: 35%;
      height: 100%;
      background-color: skyblue;
      background-image: url(../../public/left.jpg);
      background-size: cover;
      opacity: 70%;
    }
    .right {
      display: flex;
      width: 65%;
      flex-direction: column;
      align-items: center;
      h4 {
        color: #8ec5fc;
        font-size: 30px;
        margin: 50px 0 0 0;
      }

      form {
        display: flex;
        flex-wrap: wrap;
        flex-direction: column;
        // justify-content: center;
        align-items: center;
        width: 100%;
        .acc {
          outline: none;
          width: 50%;
          height: 50px;
          font-size: 16px;
          margin-top: 40px;
          padding: 10 0 0 16;
          border: none;
          border-bottom: 1px solid #8ec5fc;
          color: #8ec5fc;
          background-color: rgba(0, 0, 0, 0);
          padding: 1px 0 0 16px;
        }
        .remember {
          border: none;
          // margin: 15px 230px 0 0;
          margin-top: 15px;
          font-size: 15px;
          color: #8ec5fc;
        }
        .but {
          width: 40%;
          height: 50px;
          color: #f6f6f6;
          background-image: linear-gradient(120deg, #8ec5fc 0%, #b3cee9 100%);
          font-size: 14px;
          border: none;
          border-radius: 5px;
          margin: 15px auto;
          // margin-top: 30px;
          :hover {
            box-shadow: 0 0 20 -5 rgb(0 0 0 / 15%);
          }
        }
      }
      
    }
  }
}
</style>