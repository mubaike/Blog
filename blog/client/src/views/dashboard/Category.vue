<template>
  <div>
    <n-button @click="showAddModal = true">添加分类</n-button>
    <n-table :bordered="false" :single-line="false">
      <thead>
        <tr>
          <th>编号</th>
          <th>名称</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(category, index) in categoryList">
          <td>{{ category.id }}</td>
          <td>{{ category.name }}</td>
          <td>
            <n-space>
              <n-button @click="toUpdata(category)">修改</n-button>
              <n-button @click="deleteCategory(category)">删除</n-button>
            </n-space>
          </td>
        </tr>
      </tbody>
    </n-table>

    <n-modal v-model:show="showAddModal">
      <n-card
        style="width: 600px"
        title="添加分类"
        :bordered="false"
        size="huge"
        role="dialog"
        aria-modal="true"
      >
        <div>
          <n-input
            v-model:value="addCategory.name"
            type="text"
            placeholder="请输入名称"
          />
        </div>
        <template #footer>
          <n-button @click="add">提交</n-button>
        </template>
      </n-card>
    </n-modal>

    <n-modal v-model:show="showUpdataModal">
      <n-card
        style="width: 600px"
        title="修改分类"
        :bordered="false"
        size="huge"
        role="dialog"
        aria-modal="true"
      >
        <div>
          <n-input
            v-model:value="updataCategory.name"
            type="text"
            placeholder="请输入名称"
          />
        </div>
        <template #footer>
          <n-button @click="updata">提交</n-button>
        </template>
      </n-card>
    </n-modal>
  </div>
</template>

<script setup>
import { AdminStore } from "../../stores/AdminStore";
import { ref, reactive, inject, onMounted } from "vue";
import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute();

const message = inject("message");
const dialog = inject("dialog");
const axios = inject("axios");

const adminStore = AdminStore();

const showAddModal = ref(false);
const showUpdataModal = ref(false);

const categoryList = ref([]);

const addCategory = reactive({
  name: "",
});
const updataCategory = reactive({
  id: 0,
  name: ""
});

onMounted(() => {
  loadDatas();
});

const loadDatas = async () => {
  let res = await axios.get("/category/list");
  categoryList.value = res.data.rows;
};

const add = async () => {
  let res = await axios.post("/category/_token/add", {
    name: addCategory.name,
  });
  if (res.data.code == 200) {
    loadDatas();
    message.info(res.data.msg);
  } else {
    message.error(res.data.msg);
  }
  showAddModal.value = false;
};

const toUpdata = async (category) => {
  showUpdataModal.value = true;
  updataCategory.id = category.id;
  updataCategory.name = category.name;
};

const updata = async () => {
  let res = await axios.put("/category/_token/update", {
    id: updataCategory.id,
    name: updataCategory.name
  });
  if (res.data.code == 200) {
    loadDatas();
    message.info(res.data.msg);
  } else {
    message.error(res.data.msg);
  }
  showUpdataModal.value = false;
};

const deleteCategory = async (category) => {
  dialog.warning({
    title: "警告",
    content: "你确定？",
    positiveText: "确定",
    negativeText: "不确定",
    onPositiveClick: async () => {
      let res = await axios.delete(`/category/_token/delete?id=${category.id}`);
      if (res.data.code == 200) {
        loadDatas();
        message.info(res.data.msg);
      } else {
        message.error(res.data.msg);
      }
    },
    onNegativeClick: () => {},
  });
};
</script>

<style>
</style>