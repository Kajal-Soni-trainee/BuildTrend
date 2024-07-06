<template>
  <v-container class="d-flex flex-row justify-center align-center">
    <p
      v-if="propertyData.data.length == 0"
      class="text-red text-h2 text-center"
    >
      No Property Added
    </p>
    <template v-else>
      <v-card
        style="width: 1000px"
        v-for="item in propertyData.data"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5">{{ item.property_name }}</v-card-item>
        <v-card-item class="text-h5">{{ item.property_address }}</v-card-item>
      </v-card>
    </template>
  </v-container>
</template>

<script setup>
import { axiosGet } from "../services/service";
import { onMounted, reactive } from "vue";
const propertyData = reactive({ data: [] });
onMounted(async () => {
  const result = await axiosGet("/showJobs");
  if (result.status == 200) {
    console.log(result.data);
    propertyData.data = result.data;
  }
});
</script>
<style scoped></style>
