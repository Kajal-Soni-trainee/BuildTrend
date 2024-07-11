<template>
  <p v-if="jobs.length == 0" class="text-h2 text-red">No Jobs Available</p>
  <div class="d-flex flex-column justify-center align-center ga-5" v-else>
    <template v-for="job in jobs" :key="job.job_id">
      <p v-if="workProofDetails.length == 0" class="ttext-red text-h4">
        No work Proofs Available
      </p>
      <template v-else>
        <v-card
          :elevation="12"
          class="border rounded-xl outline-teal-darken-4"
          style="width: 1000px"
          v-for="workproof in workProofDetails"
          :key="workproof.work_proof_id"
        >
          <v-card-item v-if="workproof.job_id == job.job_id">
            <v-card-title class="text-h4 text-teal-darken-4">{{
              workproof.title
            }}</v-card-title>
            <div
              max-width="800px"
              class="ma-8 d-flex flex-row justify-start scroll"
            >
              <template
                v-for="image in workProofImages"
                :key="image.work_image_id"
              >
                <div class="d-flex flex-column align-center ma-5">
                  <v-img
                    v-if="image.work_proof_id == workproof.work_proof_id"
                    :src="'http://localhost:8000' + image.image"
                    :alt="image.image"
                    height="200"
                    width="200"
                  ></v-img>
                  <div>
                    <p class="text-center text-h6">Comments:</p>
                    <template
                      v-for="comment in workProofComments"
                      :key="comment.comment_id"
                    >
                      <p
                        class="text-red"
                        v-if="comment.work_image_id == image.work_image_id"
                      >
                        {{ comment.comment }}
                      </p>
                    </template>
                  </div>
                </div>
              </template>
            </div>

            <v-card-title class="text-h5">Description:</v-card-title
            ><v-card-subtitle class="text-h6">{{
              workproof.description
            }}</v-card-subtitle>
          </v-card-item>
          <div class="d-flex flex-row justify-center align-center">
            <v-btn
              v-if="job.state != 2"
              class="text-h5 bg-teal-darken-4 rounded-xl ma-5"
              @click="alert = true"
              >Have completed ?</v-btn
            >
          </div>
          <v-dialog v-model="alert" width="auto">
            <v-card
              width="300px"
              class="pa-5"
              prepend-icon="mdi-help-circle"
              title="Are you sure you have complted the Job"
            >
              <div class="d-flex flex-row justify-center align-center ga-5">
                <v-btn @click="completedTask(job.job_id)" variant="outlined"
                  >Yes</v-btn
                >
                <v-btn @click="alert = false" variant="outlined">No</v-btn>
              </div>
            </v-card>
          </v-dialog>
        </v-card>
      </template>
    </template>
  </div>
</template>
<script setup>
import { useStore } from "vuex";
import { onMounted, computed, ref } from "vue";
import { axiosPost } from "../services/service";
const store = useStore();
const alert = ref(false);
const workProofDetails = computed(() => {
  return store.state.contractor.workProofDetailsCon;
});
const workProofImages = computed(() => {
  return store.state.contractor.workProofImagesCon;
});
const workProofComments = computed(() => {
  return store.state.contractor.workProofCommentsCon;
});
const jobs = computed(() => {
  return store.state.contractor.jobsCon;
});

async function completedTask(job_id) {
  const result = await axiosPost("/workCompletedReq", { job_id: job_id });
  if (result.status == 200) {
    alert.value = false;
    await store.dispatch("triggerSetWorkProofsCon");
  }
}
onMounted(async () => {
  await store.dispatch("triggerSetWorkProofsCon");
  console.log("details", workProofDetails.value);
  console.log("imaghes", workProofImages.value);
  console.log("comments", workProofComments.value);
  console.log("jobs", jobs.value);
});
</script>
<style scoped>
.scroll {
  overflow-x: scroll;
}
</style>
