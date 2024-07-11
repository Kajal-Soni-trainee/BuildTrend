<template>
  <v-sheet style="width: 1700; height: 1700">
    <v-card
      :elevation="12"
      style="width: 800px"
      v-for="item in contacts"
      :key="item.job_id"
      class="pa-5 ma-5"
      @click="showAllMsgs(item.sender_id, item.u_name)"
    >
      <div class="d-flex flex-row align-center pa-5">
        <v-icon size="50" icon="mdi-account-circle" />
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
      </div>
      <v-card-subtitle class="text-h5 pl-16">{{
        item.message
      }}</v-card-subtitle>
    </v-card>
  </v-sheet>
</template>
<script setup>
import { useStore } from "vuex";
import { useRouter, useRoute } from "vue-router";
import { onMounted, computed, ref } from "vue";
const store = useStore();
const router = useRouter();
const route = useRoute();
const contacts = computed(() => {
  return store.state.property.contacts;
});
const job_id = ref(route.query.job_id);
const owner_id = ref(route.query.owner_id);
function showAllMsgs(contractor_id, u_name) {
  router.push({
    name: "OwnerMsg",
    query: {
      job_id: job_id.value,
      owner_id: owner_id.value,
      contractor_id :contractor_id,
      u_name: u_name,
    },
  });
}

onMounted(async () => {
  await store.dispatch("triggerSetContacts", {
    job_id: job_id.value,
    owner_id: owner_id.value,
  });
  console.log(contacts.value);
});
</script>
<style scoped></style>
