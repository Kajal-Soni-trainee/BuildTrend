<template>
  <v-card
    :elevation="12"
    class="border rounded-xl outline-teal-darken-4"
    style="width: 1000px"
  >
    <v-card-item v-for="item in task" :key="item.job_category_id">
      <v-card-title class="text-h4 text-teal-darken-4">{{
        item.title
      }}</v-card-title>
      <div class="d-flex flex-row justify-start align-center ga-5">
        <v-img
          :src="'http://localhost:8000' + item.image"
          :alt="item.image"
          height="200"
          width="200"
        ></v-img>
      </div>
      <v-card-subtitle class="text-h6">{{ item.description }}</v-card-subtitle>
    </v-card-item>
    <div
      :v-show="showEstimate"
      style="width: 500px"
      class="d-flex flex-row justify-center align-center ma-3 ga-2"
    >
      <v-text-field
        variant="solo-filled"
        v-model="cost"
        label="Estimate Cost"
      ></v-text-field>
      <v-btn color="text-teat-darken-4" @click="sendEstimate(task[0].job_id)"
        >Send</v-btn
      >
    </div>
    <div class="d-flex flex-row justify-end align-center">
      <v-btn class="bg-teal-darken-4 ma-2" @click="back">back</v-btn>
      <v-btn class="bg-teal-darken-4 ma-2" @click="showEstimate = !showEstimate"
        >Add Estimate</v-btn
      >
    </div>
  </v-card>
</template>
<script setup>
import { useRoute, useRouter } from "vue-router";
import { ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { axiosPost } from "../services/service";
const store = useStore();
const route = useRoute();
const router = useRouter();
const job_id = ref(route.params.job_id);
const showEstimate = ref(false);
const task = computed(() => {
  return store.state.contractor.tasksByJobId;
});
const cost = ref(null);
onMounted(async () => {
  await store.dispatch("triggerSetTask", { job_id: job_id.value });
  console.log(store.state.contractor.tasksByJobId);
});
function back() {
  router.push({ name: "ShowJob" });
}
async function sendEstimate(job_id) {
  console.log(job_id);
  const result = await axiosPost("/addEstimate", {
    job_id: job_id,
    cost: cost.value,
  });
  if (result.status == 200) {
    console.log(result.data);
  }
}
</script>
<style scoped></style>
