<template>
  <v-container class="d-flex flex-column justify-center align-center">
    <p v-if="allJobs.length == 0" class="text-red text-h2 text-center">
      No Jobs Archived
    </p>

    <template v-else>
      <v-card
        style="width: 1000px"
        class="pa-5 ma-5"
        :elevation="12"
        v-for="item in allJobs"
        :key="item.job_id"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5"
          ><b>Title:- </b> {{ item.property_name }}</v-card-item
        >
        <v-card-item class="text-h5"
          ><b>Address:- </b>{{ item.property_address }}</v-card-item
        >
        <v-card-item class="text-h5"
          ><b>Amount:- </b>${{ item.cost }}</v-card-item
        >
        <v-card-item class="float-right">
          <v-btn class="bg-teal-darken-4 ma-2" @click="showTask(item.job_id)"
            >Show Task</v-btn
          >
          <v-btn
            class="text-teal-darken-4 border-thick border-success ma-2"
            @click="showProof(item.job_id)"
            >Show Proof</v-btn
          >
        </v-card-item>
      </v-card>
    </template>
  </v-container>
</template>
<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { onMounted, computed } from "vue";
const store = useStore();
const router = useRouter();
const allJobs = computed(() => {
  return store.state.archiveJobs.archivedJobsContractor;
});

function showTask(job_id) {
  router.push({ name: "ArchivedJobTask", query: { job_id: job_id } });
}

function showProof(job_id) {
  router.push({ name: "ArchivedJobProof", query: { job_id: job_id } });
}
onMounted(async () => {
  await store.dispatch("triggerSetArchivedJobContractor");
});
</script>
<style scoped></style>
