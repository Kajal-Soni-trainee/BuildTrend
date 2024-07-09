<template>
  <v-sheet style="width: 1700; height: 1700">
    <v-card
      :elevation="12"
      style="width: 800px"
      v-for="item in contacts"
      :key="item.job_id"
      class="pa-5 ma-5"
      @click="
        showAllMsgs(
          item.job_id,
          item.sender_id,
          item.receiver_id,
          item.sender_name,
          item.u_name
        )
      "
    >
      <div class="d-flex flex-row align-center">
        <v-icon style="width: 80; height: 80" icon="mdi-account-circle" />

        <v-card-title v-if="item.sender_id != user_id" class="text-h4">{{
          item.sender_name
        }}</v-card-title>
        <v-card-title v-if="item.receiver_id != user_id" class="text-h4">{{
          item.u_name
        }}</v-card-title>
      </div>
      <v-card-subtitle class="text-h6">{{ item.message }}</v-card-subtitle>
    </v-card>
  </v-sheet>
</template>
<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { onMounted, computed } from "vue";
const store = useStore();
const router = useRouter();
const contacts = computed(() => {
  return store.state.property.contacts;
});
const user_id = computed(() => {
  return store.state.property.owner_id;
});

function showAllMsgs(job_id, sender_id, receiver_id, sender_name, u_name) {
  router.push({
    name: "OwnerMsg",
    query: {
      job_id: job_id,
      sender_id: sender_id,
      receiver_id: receiver_id,
      sender_name: sender_name,
      receiver_name: u_name,
    },
  });
}

onMounted(async () => {
  await store.dispatch("triggerSetContacts");
  console.log(contacts.value);
  console.log(user_id.value);
});
</script>
<style scoped></style>
