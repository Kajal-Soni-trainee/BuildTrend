<template>
  <v-navigation-drawer :elevation="12">
    <v-list-item v-if="role == 0" link to="/property">Property</v-list-item>
    <v-list-item v-if="role == 0" link to="/addProperty"
      >Add Property</v-list-item
    >
    <v-list-item v-if="role == 1" link to="/showJobs">Show Jobs</v-list-item>
  </v-navigation-drawer>
</template>
<script setup>
import { useStore } from "vuex";
import { computed } from "vue";
const store = useStore();
const role = computed(() => {
  return store.state.users.role;
});
</script>
<style scoped></style>
