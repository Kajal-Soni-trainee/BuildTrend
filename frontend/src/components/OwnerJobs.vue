<template>
  <v-container class="d-flex flex-row justify-center align-center">
    <p v-if="propertyData.length == 0" class="text-red text-h2 text-center">
      No Property Added
    </p>
    <div class="d-flex flex-column justify-center align-center ga-5" v-else>
      <v-card
        style="width: 1000px"
        v-for="item in propertyData"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5">{{ item.property_name }}</v-card-item>
        <v-card-item class="text-h5">{{ item.property_address }}</v-card-item>
        <div class="float-right d-flex flex-row align-center">
          <v-btn
            class="ma-5 bg-teal-darken-4"
            @click="showEstimates(item.job_id)"
          >
            Show Estimates</v-btn
          >
          <v-btn
            class="ma-5 bg-teal-darken-4"
            @click="showWorkProofs(item.job_id)"
          >
            WorkProofs</v-btn
          >
        </div>
      </v-card>
    </div>
  </v-container>
</template>
<script setup>
import { onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
const store = useStore();
const router = useRouter();
const propertyData = computed(() => {
  return store.state.property.allJobs;
});

onMounted(async () => {
  store.dispatch("triggerSetJobs");
  console.log(propertyData);
});

function showWorkProofs(job_id) {
  router.push({ name: "WorkProofs", params: { job_id: job_id } });
}
function showEstimates(job_id) {
  router.push({ name: "Estimates", params: { job_id: job_id } });
}
</script>
<style scoped></style>
