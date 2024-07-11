<template>
  <p v-if="workProofData.length == 0" class="text-h2 text-red">
    No Work Proof Added
  </p>
  <v-card
    v-else
    :elevation="12"
    class="border rounded-xl outline-teal-darken-4"
    style="width: 1000px"
  >
    <v-card-item v-for="item in workProofData" :key="item.job_category_id">
      <v-card-title class="text-h4 text-teal-darken-4"
        ><b>Category Name: </b>{{ item.title }}</v-card-title
      >
      <div max-width="800px" class="scroll d-flex flex-row justify-start ma-5">
        <template v-for="image in workProofImage" :key="image.work_image_id">
          <div class="d-flex flex-column align-center pa-5 ma-5">
            <v-img
              v-if="image.work_proof_id == item.work_proof_id"
              :src="'http://localhost:8000' + image.image"
              :alt="image.image"
              height="200"
              width="200"
              @click="displayForm(image.work_proof_id, image.work_image_id)"
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

      <v-dialog v-model="dialog" width="auto">
        <v-card width="600px" class="pa-5">
          <v-text-field
            variant="solo-filled"
            v-model="comment"
            label="Comment"
          ></v-text-field>
          <template v-slot:actions>
            <v-btn class="bg-teal-darken-4" @click="dialog = false"
              >close</v-btn
            >
            <v-btn class="bg-teal-darken-4" @click="addComment()"
              >Add Comment</v-btn
            >
          </template>
        </v-card>
      </v-dialog>
      <v-card-title class="text-h5">Description:</v-card-title
      ><v-card-subtitle class="text-h6">{{ item.description }}</v-card-subtitle>
    </v-card-item>

    <div
      class="d-flex flex-column justify-center align-center"
      v-if="contractorState == 2 && ownerState != 2"
    >
      <P class="text-teal-darken-4">Job Done From Contractor Side</P>
      <v-btn @click="popup = true">Do you agree?</v-btn>
    </div>
    <div class="d-flex flex-row justify-end align-center">
      <v-btn class="bg-teal-darken-4 ma-2" @click="back">back</v-btn>
    </div>
    <v-dialog v-model="popup" width="auto">
      <v-card style="width: 400px; height: 150px" class="pa-6">
        <div class="d-flex flex-column justify-center align-center">
          <p>Do you agree that job is Done ?</p>
          <v-card-item class="d-flex flex-row justify-center align-center">
            <v-btn class="ma-2" @click="accepted">Yes</v-btn>
            <v-btn class="ma-2" @click="rejected">No</v-btn>
          </v-card-item>
        </div>
      </v-card>
    </v-dialog>
  </v-card>
</template>
<script setup>
import { useStore } from "vuex";
import { useRoute, useRouter } from "vue-router";
import { computed, onMounted, ref } from "vue";
import { axiosPost } from "@/services/service";
const store = useStore();
const route = useRoute();
const router = useRouter();
const dialog = ref(false);
const comment = ref(null);
const work_proof_id = ref(null);
const work_image_id = ref(null);
const popup = ref(false);
const job_id = ref(route.params.job_id);
const workProofData = computed(() => {
  return store.state.property.workProofDetails;
});
const workProofImage = computed(() => {
  return store.state.property.workProofImages;
});
const workProofComments = computed(() => {
  return store.state.property.workProofComments;
});
const contractorState = computed(() => {
  return store.state.property.currentJobConState;
});
const ownerState = computed(() => {
  return store.state.property.currentJobOwnerState;
});
async function accepted() {
  const result = await axiosPost("/jobDoneAccepted", { job_id: job_id.value });
  console.log(result.data);
  if (result.status == 200) {
    await store.dispatch("triggerSetWorkProofs", { job_id: job_id.value });
    popup.value = false;
  }
}
async function rejected() {
  const result = await axiosPost("/jobDoneRejected", { job_id: job_id.value });
  console.log(result.data);
  if (result.status == 200) {
    await store.dispatch("triggerSetWorkProofs", { job_id: job_id.value });
    popup.value = false;
  }
}
onMounted(async () => {
  await store.dispatch("triggerSetWorkProofs", { job_id: job_id.value });
  console.log(workProofData.value);
  console.log(workProofImage.value);
});
function displayForm(proof_id, image_id) {
  work_proof_id.value = proof_id;
  work_image_id.value = image_id;
  console.log(ownerState.value);
  if (ownerState.value != 2) {
    dialog.value = true;
  }
}
function back() {
  router.push({ name: "OwnerJobs" });
}
async function addComment() {
  const result = await axiosPost("/addComment", {
    comment: comment.value,
    work_proof_id: work_proof_id.value,
    work_image_id: work_image_id.value,
  });
  if (result.status == 200) {
    await store.dispatch("triggerSetWorkProofs", { job_id: job_id.value });
  }
}
</script>
<style scoped>
.scroll {
  overflow-x: scroll;
}
</style>
