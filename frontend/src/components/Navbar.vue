<template>
  <v-navigation-drawer :elevation="12">
    <v-list-item v-if="role == 0" link to="/property">Property</v-list-item>
    <v-list-item v-if="role == 0" link to="/addProperty"
      >Add Property</v-list-item
    >
    <v-list-item v-if="role == 0" link to="/jobs">Jobs</v-list-item>
    <v-list-item v-if="role == 1" link to="/showJobs">Show Jobs</v-list-item>
    <v-list-item v-if="role == 1" link to="/addWorkProof"
      >Add WorkProof</v-list-item
    >
    <v-list-item v-if="role == 1" link to="/workProofs"
      >Work Proofs</v-list-item
    >
    <v-list-item v-if="role == 0" link to="/archivedJobsOfOwner"
      >Archived Jobs</v-list-item
    >
    <v-list-item v-if="role == 1" link to="/archivedJobOfContractor"
      >Archived Jobs</v-list-item
    >
    <v-list-item @click="profile" link to="/profile">My Profile</v-list-item>
    <v-list-item @click="logout">Logout</v-list-item>
  </v-navigation-drawer>
</template>
<script setup>
import { useStore } from "vuex";
import { computed } from "vue";
//import { axiosGet } from "../services/service";
import { useRouter } from "vue-router";
const store = useStore();
const router = useRouter();
const role = computed(() => {
  return store.state.users.role;
});
async function logout() {
  router.push({ name: "Login" });
  localStorage.removeItem("token");
  localStorage.removeItem("role_id");
  localStorage.removeItem("name");
  store.commit("RESET_AUTH");
  // const result = await axiosGet("/logout");
  // console.log(result);
}
</script>
<style scoped></style>
