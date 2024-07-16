<template>
  <v-card
    :elevation="12"
    class="border rounded-xl pa-5 outline-teal-darken-4"
    style="width: 1000px"
  >
    <v-btn class="float-right bg-teal-darken-4 ma-2" @click="back">back</v-btn>
    <v-card-item v-for="item in allTask.data" :key="item.job_category_id">
      <v-card-title class="text-h4 text-teal-darken-4"
        ><b>Task Name: </b>{{ item.title }}</v-card-title
      >
      <div
        style="max-width: 800px"
        class="scroll d-flex flex-row justify-start align-center ma-5 pa-5 ga-5"
      >
        <template v-for="image in item.images" :key="image.image_id">
          <v-img
            :src="'http://localhost:8000' + image.image"
            height="300"
            width="300"
          ></v-img>
        </template>
      </div>
      <v-card-subtitle class="text-h5"
        ><b>Description: </b>{{ item.description }}</v-card-subtitle
      >
    </v-card-item>
  </v-card>
</template>
<script setup>
import { axiosGet } from "../services/service";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
import { ref, reactive, onMounted, computed } from "vue";
const store = useStore();
const router = useRouter();
const route = useRoute();
const job_id = ref(route.query.job_id);
const allTask = reactive({ data: [] });
const role = computed(() => {
  return store.state.users.role;
});
function back() {
  if (role.value == 0) {
    router.push({ name: "ArchivedJobOwner" });
  } else {
    router.push({ name: "ArchivedJobContractor" });
  }
}
onMounted(async () => {
  const result = await axiosGet(`/getTask/?job_id=${job_id.value}`);
  if (result.status == 200) {
    allTask.data = result.data;
    console.log(allTask.data);
  }
});
</script>
<style scoped>
.scroll {
  overflow-x: auto;
}
</style>
