<template>
  <v-navigation-drawer :elevation="12">
    <v-list-item v-if="role == 0" link to="/property">Property</v-list-item>
    <v-list-item v-if="role == 0" link to="/addProperty"
      >Add Property</v-list-item
    >
    <v-list-item v-if="role == 0" link to="/contactList">Contacts</v-list-item>
    <v-list-item v-if="role == 0" link to="/jobs">Jobs</v-list-item>
    <v-list-item v-if="role == 1" link to="/showJobs">Show Jobs</v-list-item>
    <v-list-item v-if="role == 1" link to="/contacts">Contacts</v-list-item>
    <v-list-item v-if="role == 1" link to="/addWorkProof"
      >Add WorkProof</v-list-item
    >
    <v-list-item v-if="role == 1" link to="/workProofs"
      >Work Proofs</v-list-item
    >
    <v-list-item @click="logout">Logout</v-list-item>
  </v-navigation-drawer>
</template>
<script setup>
import { useStore } from "vuex";
import { computed } from "vue";
import { axiosGet } from "../services/service";
import router from "@/routes/route";
const store = useStore();
const role = computed(() => {
  return store.state.users.role;
});
async function logout() {
  const result = await axiosGet("/logout");
  if (result.status == 200) {
    localStorage.removeItem("token");
    localStorage.removeItem("role_id");
    store.commit("RESET_AUTH");
    router.replace({ name: "Login" });
  }
}
</script>
<style scoped></style>
