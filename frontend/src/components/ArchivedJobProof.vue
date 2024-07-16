<template>
  <v-card
    :elevation="12"
    class="border rounded-xl pa-5 outline-teal-darken-4"
    style="width: 1000px"
  >
    <v-btn class="float-right bg-teal-darken-4 ma-2" @click="back">back</v-btn>
    <v-card-item v-for="item in allProof.data" :key="item.work_proof_id">
      <v-card-title class="text-h4 text-teal-darken-4"
        ><b>Proof Name: </b>{{ item.title }}</v-card-title
      >
      <div
        style="max-width: 800px"
        class="scroll d-flex flex-row justify-start align-center ma-5 pa-5 ga-5"
      >
        <template v-for="image in item.images" :key="image.image_id">
          <v-img
            :src="'http://localhost:8000' + image.image"
            height="300"
            width="300"
          ></v-img>
        </template>
      </div>
      <v-card-subtitle class="text-h5"
        ><b>Proof Description: </b>{{ item.description }}</v-card-subtitle
      >
    </v-card-item>
  </v-card>
</template>
<script setup>
import { useRoute, useRouter } from "vue-router";
import { axiosGet } from "../services/service";
import { ref, reactive, onMounted, computed } from "vue";
import { useStore } from "vuex";
const store = useStore();
const route = useRoute();
const router = useRouter();
const job_id = ref(route.query.job_id);
const allProof = reactive({ data: [] });
const role = computed(() => {
  return store.state.users.role;
});
function back() {
  if (role.value == 0) {
    router.push({ name: "ArchivedJobOwner" });
  } else {
    router.push({ name: "ArchivedJobContractor" });
  }
}
onMounted(async () => {
  const result = await axiosGet(`/getProof/?job_id=${job_id.value}`);
  allProof.data = result.data;
  console.log("cfvgdfgdfgfdh", allProof.data);
});
</script>
<style scoped>
.scroll {
  overflow-x: auto;
}
</style>
