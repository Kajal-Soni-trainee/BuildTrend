<template>
  <v-app v-if="isLoggedIn">
    <v-app-bar class="bg-teal-darken-4 " title="Build Trend">
      <p class="text-h5">
        <b>{{ name }}</b>
      </p>
      <v-img
        class="ma-3"
        max-height="60"
        max-width="60"
        contain
        v-if="img == null"
        src="../public/images/unKownUser.svg"
      ></v-img>
      <v-img
        max-height="60"
        max-width="60"
        contain
        class="rounded-circle ma-3"
        v-else
        :src="'http://localhost:8000' + img"
      >
      </v-img>

      <template v-slot:prepend>
        <v-app-bar-nav-icon
          @click.stop="showNavbar = !showNavbar"
        ></v-app-bar-nav-icon>
      </template>
    </v-app-bar>
    <template v-if="showNavbar">
      <Navbar />
    </template>

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
import { computed, onMounted, ref } from "vue";
const store = useStore();
const showNavbar = ref(true);
const isLoggedIn = computed(() => {
  return store.state.users.isLoggedIn;
});
const name = computed(() => {
  return store.state.users.name;
});
const img = computed(() => {
  return store.state.users.img;
});
onMounted(() => {
  if (localStorage.getItem("token")) {
    store.commit("SET_AUTH", {
      token: localStorage.getItem("token"),
      role: localStorage.getItem("role_id"),
      name: localStorage.getItem("name"),
      img: localStorage.getItem("img"),
    });
  }
});
</script>
