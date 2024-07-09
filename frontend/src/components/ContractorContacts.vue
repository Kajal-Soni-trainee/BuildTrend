<template>
  <v-sheet style="width: 1700; height: 1700">
    <v-card
      :elevation="12"
      style="width: 800px"
      v-for="item in contacts"
      :key="item.job_id"
      class="pa-5 ma-5"
      @click="clicked(item.job_id, item.owner_id, item.u_name)"
    >
      <div class="d-flex flex-row align-center ga-3">
        <v-icon style="width: 80; height: 80" icon="mdi-account-circle" />
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
      </div>
      <v-card-subtitle class="text-h6">{{ item.message }}</v-card-subtitle>
    </v-card>
  </v-sheet>
</template>
<script setup>
import { useStore } from "vuex";
import { computed, onMounted } from "vue";
import { useRouter } from "vue-router";
const router = useRouter();
const store = useStore();
const contacts = computed(() => {
  return store.state.contractor.contacts;
});
function clicked(job_id, owner_id, u_name) {
  router.push({
    name: "ContractorMsg",
    query: { job_id: job_id, owner_id: owner_id, u_name: u_name },
  });
}
onMounted(() => {
  store.dispatch("triggerSetContacts");
});
</script>
<style scoped></style>
