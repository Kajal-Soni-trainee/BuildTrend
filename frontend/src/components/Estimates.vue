<template>
  <p v-if="estimates.length == 0" class="text-h4 text-red">
    No Estimates Submitted
  </p>
  <template v-else>
    <div class="d-flex flex-column justify-center align-center ga-8">
      <v-card
        style="width: 1000px"
        :elevation="12"
        v-for="item in estimates"
        :key="item.estimate_id"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h5">{{ item.u_email }}</v-card-subtitle>
        <v-card-title class="text-h3 text-teal-darken-4"
          >${{ item.cost }}</v-card-title
        >
        <v-card-item
          v-if="item.contractor_id == null"
          class="d-flex flex-row justify-end align-center gx-4"
        >
          <v-btn
            class="mx-2 bg-teal-darken-4"
            @click="accept(item.estimate_id, item.con_id, item.job_id)"
            >Accept</v-btn
          >
        </v-card-item>
        <v-dialog v-model="acceptAlert" width="auto">
          <v-card>
            <v-card-title
              >You accepted {{ item.u_name }} estimation</v-card-title
            >
            <v-btn
              @click="acceptAlert = false"
              class="float-right"
              variant="outlined"
              >Ok</v-btn
            >
          </v-card>
        </v-dialog>
      </v-card>
    </div>
  </template>
</template>
<script setup>
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import { ref, computed, onMounted } from "vue";
import { axiosPost } from "../services/service";
const route = useRoute();
const store = useStore();
const job_id = ref(route.params.job_id);
const acceptAlert = ref(false);
const estimates = computed(() => {
  return store.state.property.estimates;
});
async function accept(estimate_id, contractor_id, job_id) {
  console.log("accept", estimate_id);
  const result = await axiosPost("/selectEstimate", {
    job_id: job_id,
    contractor_id: contractor_id,
    estimate_id: estimate_id,
  });
  if (result.status == 200) {
    console.log(result.data);
    await store.dispatch("triggerSetEstimates", { job_id: job_id.value });
    acceptAlert.value = true;
  }
}

onMounted(async () => {
  await store.dispatch("triggerSetEstimates", { job_id: job_id.value });
  console.log(estimates.value);
});
</script>
<style scoped></style>
