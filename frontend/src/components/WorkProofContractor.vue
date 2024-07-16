<template>
  <p v-if="jobs.length == 0" class="text-h2 text-red">No Jobs Available</p>
  <div class="d-flex flex-column justify-center align-center ga-5 ma-8" v-else>
    <v-card
      v-for="proof in workProofDetails"
      :key="proof.id"
      :elevation="12"
      class="border rounded-xl outline-teal-darken-4"
      style="width: 1000px"
    >
      <v-card-text
        v-if="proof.length == 0"
        class="text-red text-h4 text-center"
      >
        No work Proofs Available
      </v-card-text>
      <template v-else>
        <v-card-item v-for="item in proof" :key="item.work_proof_id">
          <v-card-item>
            <v-card-title class="text-h4 text-teal-darken-4"
              ><b>Name: </b>{{ item.title }}</v-card-title
            >
            <div
              max-width="800px"
              class="ma-8 d-flex flex-row justify-start scroll"
            >
              <template
                v-for="image in workProofImages"
                :key="image.work_image_id"
              >
                <div
                  v-if="image.work_proof_id == item.work_proof_id"
                  class="d-flex flex-column align-center ma-5"
                >
                  <v-img
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
              item.description
            }}</v-card-subtitle>
          </v-card-item>

          <v-dialog v-model="alert" width="auto">
            <v-card
              width="300px"
              class="pa-5"
              prepend-icon="mdi-help-circle"
              title="Are you sure you have complted the Job"
            >
              <div class="d-flex flex-row justify-center align-center ga-5">
                <v-btn @click="completedTask" variant="outlined">Yes</v-btn>
                <v-btn @click="alert = false" variant="outlined">No</v-btn>
              </div>
            </v-card>
          </v-dialog>
        </v-card-item>
      </template>

      <div
        v-if="proof.length != 0"
        class="d-flex flex-row justify-center align-center"
      >
        <v-btn
          v-if="proof[0].contractor_state != 2"
          class="text-h5 bg-teal-darken-4 rounded-xl ma-5"
          @click="setJob(proof[0].job_id)"
          >Have completed ?</v-btn
        >
      </div>

      <div
        v-if="proof.length != 0"
        class="d-flex flex-row justify-center align-center"
      >
        <v-btn
          v-if="proof[0].contractor_state == 2 && proof[0].state == 2"
          class="text-h5 bg-teal-darken-4 rounded-xl ma-5"
          @click="showAlert(proof[0].job_id)"
          >Payment Received</v-btn
        >
      </div>
      <v-dialog v-model="paymentAlert" width="auto">
        <v-card
          width="400px"
          class="pa-8"
          prepend-icon="mdi-check-circle"
          colior="green"
          title="You Have successfully receive payment from contractor"
        >
          <div class="d-flex flex-row justify-center align-center ma-5">
            <v-btn variant="outlined" @click="archiveJob">Ok</v-btn>
          </div>
        </v-card>
      </v-dialog>
    </v-card>
  </div>
</template>
<script setup>
import { useStore } from "vuex";
import { onMounted, computed, ref } from "vue";
import { axiosPost } from "../services/service";
const store = useStore();
const alert = ref(false);
const paymentAlert = ref(false);
const archiveJobId = ref(null);
const workProofDetails = computed(() => {
  return store.getters.getWorkProofDetails;
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
const currentJobId = ref(null);
function setJob(job_id) {
  currentJobId.value = job_id;
  alert.value = true;
}
async function completedTask() {
  console.log(currentJobId.value);
  const result = await axiosPost("/workCompletedReq", {
    job_id: currentJobId.value,
  });
  if (result.status == 200) {
    alert.value = false;
    await store.dispatch("triggerSetWorkProofsCon");
  }
}
function showAlert(job_id) {
  archiveJobId.value = job_id;
  paymentAlert.value = true;
}
async function archiveJob() {
  const result = await axiosPost("/archiveJob", { job_id: archiveJobId.value });
  if (result.status == 200) {
    await store.dispatch("triggerSetWorkProofsCon");
    paymentAlert.value = false;
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
