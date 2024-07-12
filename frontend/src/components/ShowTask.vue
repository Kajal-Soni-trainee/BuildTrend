<template>
  <v-card
    :elevation="12"
    class="border rounded-xl pa-5 outline-teal-darken-4"
    style="width: 1000px"
  >
    <v-btn class="float-right bg-teal-darken-4 ma-2" @click="back">back</v-btn>
    <v-card-item v-for="item in categories" :key="item.job_category_id">
      <v-card-title class="text-h4 text-teal-darken-4"
        ><b>Task Name: </b>{{ item.title }}</v-card-title
      >
      <div
        style="max-width: 800px"
        class="scroll d-flex flex-row justify-start align-center ma-5 pa-5 ga-5"
      >
        <template v-for="image in images" :key="image.image_id">
          <v-img
            v-if="image.job_category_id == item.job_category_id"
            :src="'http://localhost:8000' + image.image"
            :alt="item.image"
            height="300"
            width="300"
          ></v-img>
        </template>
      </div>
      <v-card-subtitle class="text-h5"
        ><b>Description: </b>{{ item.description }}</v-card-subtitle
      >
    </v-card-item>
    <div
      v-if="showEstimate"
      style="width: 500px"
      class="d-flex flex-row justify-center align-center ma-2 ga-2"
    >
      <v-text-field
        variant="solo-filled"
        v-model="cost"
        label="Estimate Cost"
      ></v-text-field>
      <v-btn
        size="x-large"
        class="text-teal-darken-4"
        @click="sendEstimate(categories[0].job_id)"
        >Send</v-btn
      >
    </div>

    <div
      v-if="contractor_id == null && estimateCount == 0"
      class="d-flex flex-row justify-end align-center"
    >
      <v-btn class="bg-teal-darken-4 ma-2" @click="showEstimate = !showEstimate"
        >Add Estimate</v-btn
      >
    </div>
  </v-card>
  <v-dialog v-model="alert" width="auto">
    <v-card class="pa-6" style="width: 400px">
      <v-card-title>Estimate Submitted Successfully</v-card-title>
      <v-btn class="float-right ma-5" @click="alert = false">Ok</v-btn>
    </v-card>
  </v-dialog>
</template>
<script setup>
import { useRoute, useRouter } from "vue-router";
import { ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { axiosPost } from "../services/service";
const store = useStore();
const route = useRoute();
const router = useRouter();
const job_id = ref(route.query.job_id);
const contractor_id = ref(route.query.contractor_id);
const showEstimate = ref(false);
const alert = ref(false);
const categories = computed(() => {
  return store.state.contractor.categoriesByJobId;
});
const images = computed(() => {
  return store.state.contractor.imagesByJobId;
});
const estimateCount = computed(() => {
  return store.state.contractor.estimateCount;
});
const cost = ref(null);
onMounted(async () => {
  await store.dispatch("triggerSetTask", { job_id: job_id.value });
  console.log(categories.value);
  console.log(images.value);
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
    alert.value = true;
    showEstimate.value = false;
    await store.dispatch("triggerSetTask", { job_id: job_id.value });
  }
}
</script>
<style scoped>
.scroll {
  overflow-x: scroll;
}
</style>
