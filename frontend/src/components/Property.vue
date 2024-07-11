<template>
  <v-container class="d-flex flex-column justify-center align-center">
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
          <v-btn
            class="bg-teal-darken-4"
            @click="editProperty(item.property_id)"
            >Edit</v-btn
          >
          <v-btn
            class="bg-teal-darken-4"
            @click="deleteProperty(item.property_id)"
            >Delete</v-btn
          >
        </div>
        <v-dialog v-model="alert" width="auto">
          <v-card width="400px" class="pa-5"
            ><v-card-item
              class="d-flex flex-column justify-center align-center ga-5"
              ><p>You already have a job on this property</p>
              <v-btn
                class="bg-teal-darken-4 float-right ma-5"
                @click="alert = false"
                >Ok</v-btn
              >
            </v-card-item></v-card
          >
        </v-dialog>
      </v-card>
    </template>
  </v-container>
</template>
<script setup>
import { useStore } from "vuex";
import { onMounted, computed, ref } from "vue";
import { axiosGet } from "../services/service";
import { useRouter } from "vue-router";
const router = useRouter();
const store = useStore();
const alert = ref(false);
const properties = computed(() => {
  console.log(store.state.property.properties);
  return store.state.property.properties;
});
function editProperty(id) {
  router.push({ name: "UpdateProperty", params: { id: id } });
}
async function deleteProperty(id) {
  const result = await axiosGet(`/getJobByPropId/?property_id=${id}`);
  console.log(result.data.length);
  if (result.data.length == 0) {
    const deleteResult = await axiosGet(`/deleteProperty?id=${id}`);
    console.log(deleteResult.data);
    store.dispatch("getProperites");
  } else {
    alert.value = true;
  }
}

async function addJob(id) {
  const result = await axiosGet(`/getJobByPropId/?property_id=${id}`);
  console.log(result.data.length);
  if (result.data.length == 0) {
    router.push({ name: "JobForm", params: { id: id } });
  } else {
    alert.value = true;
  }
}

onMounted(() => {
  store.dispatch("getProperites");
});
</script>
<style scoped></style>
