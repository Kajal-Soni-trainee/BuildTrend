<template>
  <v-container>
    <tempalte v-for="job in jobDetails" :key="job.id">
      <Form
        v-model:title="job.title"
        v-model:description="job.description"
        v-model:images="job.images"
      />
    </tempalte>
    <v-btn @click="addJob">Add Job</v-btn>
    <div class="d-flex flex-row justify-center align-center">
      <v-btn @click="submitJob" class="bg-primary">Submit</v-btn>
    </div>
  </v-container>
</template>
<script setup>
import { reactive } from "vue";
import Form from "./Form.vue";
import axios from "axios";
const jobDetails = reactive([
  {
    id: 1,
    title: null,
    description: null,
    images: null,
  },
]);

function addJob() {
  console.log(jobDetails);
  jobDetails.push({
    id: jobDetails.length + 1,
    title: null,
    description: null,
    images: null,
  });
}

async function submitJob() {
  console.log(jobDetails);
  const formData = new FormData();
  jobDetails.forEach((item) => {
    console.log(item);
    formData.append("id[]", item.id);
    formData.append("title[]", item.title);
    formData.append("description[]", item.description);

    item.images.forEach((image) => {
      formData.append("files", image, item.id);
    });
  });

  console.log(formData);
  const result = await axios.post("http://localhost:8000/addJob", formData);
  console.log(result);
}
</script>
<style></style>
