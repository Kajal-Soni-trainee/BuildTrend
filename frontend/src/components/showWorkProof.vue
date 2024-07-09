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
      <v-card-title class="text-h4 text-teal-darken-4">{{
        item.title
      }}</v-card-title>
      <div
        v-for="image in workProofImage"
        :key="image.work_image_id"
        class="d-flex flex-row"
      >
        <v-img
          v-if="image.work_proof_id == item.work_proof_id"
          :src="'http://localhost:8000' + image.image"
          :alt="image.image"
          height="200"
          width="200"
          @click="displayForm(image.work_proof_id)"
        ></v-img>
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
    <div class="d-flex flex-row justify-end align-center">
      <v-btn class="bg-teal-darken-4 ma-2" @click="back">back</v-btn>
    </div>
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
const job_id = ref(route.params.job_id);
const workProofData = computed(() => {
  return store.state.property.workProofDetails;
});
const workProofImage = computed(() => {
  return store.state.property.workProofImages;
});
onMounted(async () => {
  await store.dispatch("triggerSetWorkProofs", { job_id: job_id.value });
  console.log(workProofData.value);
  console.log(workProofImage.value);
});
function displayForm(proof_id) {
  work_proof_id.value = proof_id;
  dialog.value = true;
}
function back() {
  router.push({ name: "OwnerJobs" });
}
async function addComment() {
  const result = await axiosPost("/addComment", {
    comment: comment.value,
    work_proof_id: work_proof_id.value,
  });
  console.log(result.data);
}
</script>
<style scoped></style>
