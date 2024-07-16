<template>
  <v-container class="d-flex flex-column justify-center align-center">
    <p v-if="propertyData.length == 0" class="text-red text-h2 text-center">
      No Jobs Available
    </p>
    <div v-else class="d-flex flex-column justify-center align-center ga-5">
      <v-card
        style="width: 1000px"
        v-for="item in propertyData"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5">{{ item.property_name }}</v-card-item>
        <v-card-item class="text-h5">{{ item.property_address }}</v-card-item>
        <v-card-item class="d-flex flex-row justify-end"
          ><v-btn
            class="bg-teal-darken-4 mx-2"
            @click="viewTask(item.job_id, item.contractor_id)"
            >View Task</v-btn
          >
          <!-- <v-btn class="bg-teal-darken-4 mx-2" @click="dialog = true"
            >Send Message</v-btn
          > -->
          <v-btn
            class="bg-teal-darken-4 mx-2"
            @click="
              openChat(item.job_id, item.owner_id, item.u_name, item.u_img)
            "
            >Open Chat</v-btn
          >
          <v-dialog v-model="dialog" width="auto">
            <v-card width="600px" class="pa-5">
              <div class="d-flex flex-row justify-center align-center">
                <v-text-field
                  variant="solo-filled"
                  label="Message"
                  v-model="message"
                ></v-text-field>
                <v-btn
                  size="x-large"
                  class="bg-teal-darken-4"
                  @click="sendMsg(item.job_id, item.owner_id)"
                  >send</v-btn
                >
              </div>
              <template v-slot:actions>
                <v-btn class="bg-teal-darken-4" @click="dialog = false"
                  >close</v-btn
                >
              </template>
            </v-card>
          </v-dialog>
          <v-dialog v-model="alert" width="auto">
            <v-card
              style="width: 400px"
              prepend-icon=""
              title="Message Sent Successfully"
              class="pa-5"
            >
              <v-btn variant="outlined" @click="alert = false">OK</v-btn>
            </v-card></v-dialog
          >
        </v-card-item>
      </v-card>
    </div>
  </v-container>
</template>
<script setup>
import { onMounted, computed, ref } from "vue";
import { useRouter } from "vue-router";
import { axiosPost } from "../services/service";
import { useStore } from "vuex";
const store = useStore();
const router = useRouter();
const dialog = ref(false);
const message = ref(null);
const alert = ref(false);
function viewTask(job_id, contractor_id) {
  router.push({
    name: "ShowTask",
    query: { job_id: job_id, contractor_id: contractor_id },
  });
}
async function sendMsg(job_id, receiver_id) {
  console.log(job_id, receiver_id);
  const result = await axiosPost("/sendMsgByCon", {
    job_id: job_id,
    receiver_id: receiver_id,
    message: message.value,
  });
  console.log(result.data);
  if (result.status == 200) {
    console.log("dfgdfhfghb");
    dialog.value = false;
    alert.value = true;
  }
}

function openChat(job_id, owner_id, u_name, u_img) {
  router.push({
    name: "ContractorMsg",
    query: { job_id: job_id, owner_id: owner_id, u_name: u_name, u_img: u_img },
  });
}
const propertyData = computed(() => {
  return store.state.contractor.unSelectedJobs;
});
onMounted(async () => {
  await store.dispatch("triggerUnSelectedJobs");
  console.log(propertyData.value);
});
</script>
<style scoped></style>
