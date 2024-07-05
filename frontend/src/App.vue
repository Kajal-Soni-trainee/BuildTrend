<template>
  <v-app v-if="isLoggedIn">
    <v-app-bar class="bg-teal-darken-4" prepend-icon="" title="Build Trend">
      <template v-slot:prepend>
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
      </template>
      <template v-slot:append>
        <v-btn icon="mdi-dots-vertical"></v-btn>
      </template>
    </v-app-bar>
    <Navbar />
    <v-main class="d-flex flex-row justify-center align-center">
      <router-view></router-view>
    </v-main>
  </v-app>
  <v-app class="bg-teal-darken-4" v-else>
    <v-main class="d-flex flex-row justify-center align-center">
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script setup>
import Navbar from "./components/Navbar.vue";
import { useStore } from "vuex";
import { computed, onMounted } from "vue";
const store = useStore();
const isLoggedIn = computed(() => {
  return store.state.users.isLoggedIn;
});
onMounted(() => {
  console.log(isLoggedIn.value);
});
</script>
