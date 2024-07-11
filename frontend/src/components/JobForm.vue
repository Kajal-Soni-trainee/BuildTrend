<template>
  <v-card
    style="width: 1000px; max-height: 800px"
    class="pa-5 rounded-xl scroll"
    :elevation="12"
  >
    <v-card-title class="text-center text-h4 text-teal-darken-4"
      >Add Task Form</v-card-title
    >
    <tempalte v-for="job in jobDetails" :key="job.id">
      <Form
        v-model:title="job.title"
        v-model:description="job.description"
        v-model:images="job.images"
      />
    </tempalte>
    <v-btn variant="outlined" color="teal-darken-3" @click="addJob"
      >Add Job</v-btn
    >
    <div class="d-flex flex-row justify-center align-center">
      <v-btn @click="submitJob" class="bg-teal-darken-4">Submit</v-btn>
    </div>
    <v-dialog v-model="alert" width="auto">
      <v-card height="100px" width="400px" class="pa-5"
        ><div class="d-flex flex-column justify-center align-center">
          <p>Job Added Successfully</p>
          <v-btn variant="outlined" @click="redirect">Ok</v-btn>
        </div></v-card
      >
    </v-dialog>
  </v-card>
</template>
<script setup>
import { reactive, ref } from "vue";
import Form from "./Form.vue";
import { axiosPost } from "../services/service";
import { useRoute } from "vue-router";
import router from "@/routes/route";
const route = useRoute();
const alert = ref(false);
const property_id = ref(route.params.id);
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
  console.log(route.params.id);
  console.log(property_id.value);
  const formData = new FormData();
  formData.append("property_id", property_id.value);
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
  const result = await axiosPost("/addJob", formData);
  console.log(result.data, result.status);
  if (result.status == 200) {
    alert.value = true;
  }
}
function redirect() {
  router.push({ name: "Property" });
  alert.value = false;
}
</script>
<style scoped>
.scroll {
  overflow-y: scroll;
}
</style>
