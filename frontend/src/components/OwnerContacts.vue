<template>
  <v-sheet :evelation="16" style="width: 1700; height: 1700">
    <div class="d-flex flex-row justify-start align-center pa-5 ma-5">
      <v-btn
        v-if="!back && contractor_id == null"
        class="bg-teal-darken-4"
        @click="
          showAllContactFlag = true;
          back = true;
        "
        >Show ALL Contacts</v-btn
      >
      <v-icon
        v-if="back"
        size="50"
        color="green"
        @click="
          showAllContactFlag = false;
          back = false;
        "
        icon="mdi-arrow-left-thick"
      />
    </div>
    <template v-if="!showAllContactFlag">
      <v-card
        :elevation="12"
        style="width: 800px"
        v-for="item in contacts"
        :key="item.job_id"
        class="pa-5 ma-5"
        @click="showAllMsgs(item.sender_id, item.u_name, item.u_img)"
      >
        <div class="d-flex flex-row align-center pa-5">
          <v-icon
            v-if="item.u_img == null"
            size="60"
            color="grey"
            icon="mdi-account-circle"
          />
          <v-img
            v-else
            class="rounded-circle ma-0 pa-0"
            max-height="55px"
            max-width="55px"
            contain
            :src="'http://localhost:8000' + item.u_img"
          ></v-img>

          <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        </div>
        <v-card-subtitle class="text-h5 pl-16">{{
          item.message
        }}</v-card-subtitle>
      </v-card>
    </template>
    <template v-else>
      <v-card
        :elevation="12"
        style="width: 800px"
        v-for="item in allContractors"
        :key="item.u_id"
        class="pa-5 ma-5"
        @click="showAllMsgs(item.u_id, item.u_name, item.u_img)"
      >
        <v-row class="d-flex flex-row align-center pa-5">
          <v-col md="1">
            <v-icon
              v-if="item.u_img == null"
              size="50"
              color="grey"
              icon="mdi-account-circle"
            />
            <v-img
              v-else
              class="rounded-circle ma-0 pa-0"
              height="80px"
              width="80px"
              :src="'http://localhost:8000' + item.u_img"
            ></v-img>
          </v-col>
          <v-col md="11">
            <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
          </v-col>
        </v-row>
      </v-card>
    </template>
  </v-sheet>
</template>
<script setup>
import { useStore } from "vuex";
import { useRouter, useRoute } from "vue-router";
import { onMounted, computed, ref } from "vue";
import { axiosGet } from "../services/service";
const store = useStore();
const router = useRouter();
const route = useRoute();
const showAllContactFlag = ref(false);
const back = ref(false);
const contacts = computed(() => {
  return store.state.property.contacts;
});
const allContractors = computed(() => {
  return store.state.property.allContractors;
});
const contractor_id = ref(null);
const job_id = ref(route.query.job_id);
const owner_id = ref(route.query.owner_id);
function showAllMsgs(contractor_id, u_name, u_img) {
  router.push({
    name: "OwnerMsg",
    query: {
      job_id: job_id.value,
      owner_id: owner_id.value,
      contractor_id: contractor_id,
      u_name: u_name,
      u_img: u_img,
    },
  });
}

onMounted(async () => {
  await store.dispatch("triggerSetContacts", {
    job_id: job_id.value,
    owner_id: owner_id.value,
  });
  await store.dispatch("triggerSetAllContractors", { job_id: job_id.value });
  console.log(allContractors.value);

  const result = await axiosGet(`/getContractorId/?job_id=${job_id.value}`);
  if (result.status == 200) {
    contractor_id.value = result.data.contractor_id;
  }
});
</script>
<style scoped></style>
