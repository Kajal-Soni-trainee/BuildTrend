<template>
  <v-container class="d-flex flex-row justify-center align-center">
    <p v-if="properties.length == 0" class="text-red text-h2 text-center">
      No Property Added
    </p>

    <template v-else>
      <v-card
        style="width: 1000px"
        class="pa-5 ma-5"
        :elevation="12"
        v-for="item in properties"
        :key="item.property_id"
      >
        <v-card-title class="text-teal-darken-4 text-h4">
          {{ item.property_name }}</v-card-title
        >
        <v-card-subtitle class="text-h5">{{
          item.property_address
        }}</v-card-subtitle>
        <div class="d-flex flex-row align-center justify-end ma-5 ga-2">
          <v-btn class="bg-teal-darken-4" @click="addJob(item.property_id)"
            >Add Job</v-btn
          >
          <v-btn class="bg-teal-darken-4" @click="editProperty">Edit</v-btn>
          <v-btn
            class="bg-teal-darken-4"
            @click="deleteProperty(item.property_id)"
            >Delete</v-btn
          >
        </div>
      </v-card>
    </template>
  </v-container>
</template>
<script setup>
import { useStore } from "vuex";
import { onMounted, computed } from "vue";
import { axiosGet } from "../services/service";
import { useRouter } from "vue-router";
const router = useRouter();
const store = useStore();
const properties = computed(() => {
  console.log(store.state.property.properties);
  return store.state.property.properties;
});
function editProperty() {}
async function deleteProperty(id) {
  const result = await axiosGet(`/deleteProperty?id=${id}`);
  console.log(result);
}

function addJob(id) {
  router.push({ name: "JobForm", params: { id: id } });
}

onMounted(() => {
  store.dispatch("getProperites");
});
</script>
<style scoped></style>
