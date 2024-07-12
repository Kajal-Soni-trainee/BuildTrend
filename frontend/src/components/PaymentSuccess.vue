<template>
  <v-card :elevation="12" width="600px" height="200px" class="pa-8">
    <div class="d-flex flex-row justify-center align-center">
      <v-icon size="x-large" color="green">mdi-check-circle</v-icon>
    </div>

    <v-card-title class="text-h4 text-success"
      >Payment Done Successfully</v-card-title
    >
  </v-card>
</template>
<script setup>
import { useRoute } from "vue-router";
import { onMounted, ref } from "vue";
import { axiosPost } from "../services/service";
const route = useRoute();
const job_id = ref(route.query.job_id);
onMounted(async () => {
  const result = await axiosPost("/paymentSuccess", { job_id: job_id.value });
  if (result.status == 200) {
    console.log(result.data);
  }
});
</script>
<style scoped></style>
