import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import naive from 'naive-ui'
import { createDiscreteApi } from 'naive-ui'
import { router } from './common/router'
import { createPinia } from "pinia"
import axios from 'axios'

import { AdminStore } from "./stores/AdminStore";

import hljs from 'highlight.js' //导入代码高亮文件
import 'highlight.js/styles/mono-blue.css'  //导入代码高亮样式

import './assets/styles/iconfont.css'

axios.defaults.baseURL = "http://mubais.love:82"
// axios.defaults.baseURL = "http://localhost:8080/"
const { message, notification, dialog } = createDiscreteApi(["message", "notification", "dialog"])

//创建app实例
const app = createApp(App)

app.provide("axios", axios)
app.provide("message", message)
app.provide("notification", notification)
app.provide("dialog", dialog)
app.provide("server_url", axios.defaults.baseURL)

app.use(naive)
app.use(createPinia())

app.use(router)

router.beforeEach((to,from,next) => {
    if(to.meta.istoken){
        //需要token才能过去
        if(AdminStore().token){
            next()
        }else{
            router.push('/login')
        }
    }else{
        next();
    }
})

router.afterEach((to, from, next) => {
    window.scrollTo(0, 0)
  })


const adminStore = AdminStore();
axios.interceptors.request.use((config) => {
    config.headers.token = adminStore.token
    return config
})




app.directive('highlight', function (el) {
    const blocks = el.querySelectorAll('pre code' && 'code');
    blocks.forEach((block) => {
        hljs.highlightBlock(block)
    })
})

//将实例在页面中挂载
app.mount('#app')
