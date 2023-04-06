<template>
  <div class="mycard">
    <div class="title">{{ blog.title }}</div>
    <div class="content">{{ newconst }}</div>
    <div class="footer">发布时间：{{ blog.create_time }}</div>
  </div>
</template>

<script setup>
import { computed } from "vue"

const props = defineProps(['blog'])
const newconst = computed(() => {
  let a = true;
  let arr = [];
  const s = props.blog.content
  for(let i=0;i<s.length;i++){
    if(s[i] == '<'){
      a = false;
    }else if(s[i-1] == '>'){
      a = true
    }
    if(a){
      arr.push(s[i])
    }
  }
  
  return arr.length ? arr.join('') + '...' : ''
}
)
</script>

<style lang="scss" scoped>
.mycard {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: 600px;
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