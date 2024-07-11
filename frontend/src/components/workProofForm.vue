<template>
  <v-container class="d-flex flex-row justify-center align-center">
    <p v-if="selectedJobs.length == 0" class="text-red text-h2 text-center">
      No Job Available
    </p>
    <div class="d-flex flex-column justify-center align-center ga-5" v-else>
      <v-card
        style="width: 1000px"
        v-for="item in selectedJobs"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5">{{ item.property_name }}</v-card-item>
        <v-card-item class="text-h5">{{ item.property_address }}</v-card-item>
        <v-card-item class="text-h5" v-if="item.state == 0"
          ><p>
            <b>Job Status: </b
            ><span class="text-primary">Estimate Submitted</span>
          </p></v-card-item
        >
        <v-card-item class="text-h5" v-if="item.state == 1"
          ><p>
            <b>Job Status: </b><span class="text-warning">In Progress</span>
          </p></v-card-item
        >
        <v-card-item class="text-h5" v-if="item.state == 2"
          ><p>
            <b>Job Status: </b><span class="text-success">Completed</span>
          </p></v-card-item
        >
        <v-btn class="bg-teal-darken-4 ma-5" @click="getCategories(item.job_id)"
          >Add Proof</v-btn
        >
        <v-dialog v-model="dialog" width="auto">
          <v-card width="600px" class="pa-5">
            <v-textarea
              v-model="workProofData.description"
              variant="solo-filled"
              label="Description"
            ></v-textarea>
            <v-select
              variant="solo-filled"
              label="Categories"
              v-model="workProofData.job_category_id"
              :items="jobCatogories"
              item-title="title"
              item-value="job_category_id"
            >
            </v-select>
            <v-file-input
              label="Images"
              variant="solo-filled"
              multiple
              prepend-inner-icon="mdi-camera"
              v-model="workProofData.images"
            ></v-file-input>
            <template v-slot:actions>
              <v-btn class="bg-teal-darken-4" @click="dialog = false"
                >close</v-btn
              >
              <v-btn class="bg-teal-darken-4" @click="submit(item.job_id)"
                >Submit</v-btn
              >
            </template>
          </v-card>
        </v-dialog>
      </v-card>
    </div>
    <v-dialog width="auto" v-model="alert">
      <v-card
        class="pa-5"
        prepend-icon="mdi-check-circle"
        text="Work Proof Added"
      >
        <v-btn @click="alert = false" variant="outlined">Ok</v-btn>
      </v-card></v-dialog
    >
  </v-container>
</template>
<script setup>
import { useStore } from "vuex";
import { computed, onMounted, ref, reactive } from "vue";
import { axiosGet, axiosPost } from "@/services/service";
const store = useStore();
const alert = ref(false);
const selectedJobs = computed(() => {
  console.log(store.state.contractor.selectedJobs);
  return store.state.contractor.selectedJobs;
});
const workProofData = reactive({
  description: null,
  images: null,
  job_category_id: null,
});
const jobCatogories = ref([]);
const dialog = ref(false);
async function getCategories(job_id) {
  const result = await axiosGet(`/getCategories/?job_id=${job_id}`);
  jobCatogories.value = result.data;
  dialog.value = true;
}

async function submit(job_id) {
  const formData = new FormData();
  workProofData.images.forEach((image) => {
    formData.append("files", image);
  });
  formData.append("job_id", job_id);
  formData.append("job_category_id", workProofData.job_category_id);
  formData.append("description", workProofData.description);
  const result = await axiosPost("/addWorkProof", formData);
  if (result.status == 200) {
    dialog.value = false;
    alert.value = true;
  }
}

onMounted(async () => {
  store.dispatch("triggerSetSelectedJobs");
  console.log("asffcggbngnfgn", selectedJobs.value);
});
</script>
<style scoped></style>
