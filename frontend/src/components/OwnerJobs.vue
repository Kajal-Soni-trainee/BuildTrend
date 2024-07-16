<template>
  <v-container class="d-flex flex-row justify-center align-center">
    <p v-if="propertyData.length == 0" class="text-red text-h2 text-center">
      No Jobs Added
    </p>
    <div class="d-flex flex-column justify-center align-center ga-5" v-else>
      <v-card
        style="width: 1000px"
        v-for="item in propertyData"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5"
          ><b>Title:- </b> {{ item.property_name }}</v-card-item
        >
        <v-card-item class="text-h5"
          ><b>Address:- </b>{{ item.property_address }}</v-card-item
        >
        <div class="float-right d-flex flex-row align-center">
          <v-btn
            class="ma-5 bg-teal-darken-4"
            @click="showEstimates(item.job_id)"
          >
            Show Estimates</v-btn
          >
          <v-btn
            v-if="item.contractor_id != null"
            class="ma-5 bg-teal-darken-4"
            @click="showWorkProofs(item.job_id)"
          >
            WorkProofs</v-btn
          >
          <v-btn
            @click="showContacts(item.job_id, item.owner_id)"
            class="ma-5 bg-teal-darken-4"
            >Open Chat</v-btn
          >
        </div>
        <v-card-item v-if="item.state == 0"
          ><p>
            <b>Status:</b>
            <span class="text-h6 text-primary">Job Submitted</span>
          </p></v-card-item
        >
        <v-card-item v-if="item.state == 1"
          ><p>
            <b>Status:</b>
            <span class="text-h6 text-warning">In Progress</span>
          </p></v-card-item
        >
        <v-card-item v-if="item.state == 2"
          ><p>
            <b>Status:</b>
            <span class="text-h6 text-success">Completed</span>
          </p></v-card-item
        >
      </v-card>
    </div>
  </v-container>
</template>
<script setup>
import { onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
const store = useStore();
const router = useRouter();
const propertyData = computed(() => {
  return store.state.property.allJobs;
});

onMounted(async () => {
  store.dispatch("triggerSetJobs");
  console.log(propertyData.value);
});

function showWorkProofs(job_id) {
  router.push({ name: "WorkProofs", params: { job_id: job_id } });
}
function showEstimates(job_id) {
  router.push({ name: "Estimates", params: { job_id: job_id } });
}
function showContacts(job_id, owner_id) {
  router.push({
    name: "OwnerContacts",
    query: { job_id: job_id, owner_id: owner_id },
  });
}
</script>
<style scoped></style>
