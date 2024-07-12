<template>
  <v-card :elevation="12" width="600px" height="200px">
    <v-card-icon large color="red">mdi-close-circle</v-card-icon>
    <v-card-title class="text-center text-h4 text-red"
      >Transaction Failed</v-card-title
    >
    <v-card-subtitle class="text-center"
      >Some issue occured in transaction Please try again later
      !</v-card-subtitle
    >
  </v-card>
</template>
<script setup>
import { useRoute } from "vue-router";
import { ref, onMounted } from "vue";
import { axiosPost } from "../services/service";
const route = useRoute();
const job_id = ref(route.query.job_id);
onMounted(async () => {
  const result = await axiosPost(`/paymentFail`, { job_id: job_id.value });
  if (result.status == 200) {
    console.log(result.data);
  }
});
</script>
<style scoped></style>
