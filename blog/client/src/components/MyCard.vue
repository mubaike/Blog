<template>
  <div class="mycard">
    <div class="title">{{ blog.title }}</div>
    <div class="content">{{ blog.content }}</div>
    <div class="footer">发布时间：{{ blog.create_time }}</div>
  </div>
</template>

<script setup>
const props = defineProps(['blog'])
</script>

<style lang="scss" scoped>
.mycard {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: auto;
  height: 150px;
  padding: 10px 20px;
  margin-bottom: 15px;
  box-shadow: 0 0 35px 0 rgba(154, 161, 171, 0.15);
  background-color: #ffffff;
  border-radius: 5px;
  color: #666666;
  .title {
    font-size: 20px;
  }
  .content {
  }
  .footer {
    font-size: 13px;
  }
}
</style>