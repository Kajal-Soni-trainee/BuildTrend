<template>
  <v-container class="d-flex flex-column justify-center align-center">
    <p
      v-if="propertyData.data.length == 0"
      class="text-red text-h2 text-center"
    >
      No Property Added
    </p>
    <div v-else class="d-flex flex-column justify-center align-center ga-5">
      <v-card
        style="width: 1000px"
        v-for="item in propertyData.data"
        :key="item.job_id"
        :elevation="12"
      >
        <v-card-title class="text-h4">{{ item.u_name }}</v-card-title>
        <v-card-subtitle class="text-h6">{{ item.u_email }}</v-card-subtitle>
        <v-card-item class="text-h5">{{ item.property_name }}</v-card-item>
        <v-card-item class="text-h5">{{ item.property_address }}</v-card-item>
        <v-card-item class="d-flex flex-row justify-end"
          ><v-btn class="bg-teal-darken-4 mx-2" @click="viewTask(item.job_id)"
            >View Task</v-btn
          >
          <v-btn class="bg-teal-darken-4 mx-2" @click="dialog = true"
            >Send Message</v-btn
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
        </v-card-item>
      </v-card>
    </div>
  </v-container>
</template>
<script setup>
import { axiosGet } from "../services/service";
import { onMounted, reactive, ref } from "vue";
import { useRouter } from "vue-router";
import { axiosPost } from "../services/service";
const router = useRouter();
const dialog = ref(false);
const propertyData = reactive({ data: [] });
const message = ref(null);
function viewTask(job_id) {
  router.push({ name: "ShowTask", params: { job_id: job_id } });
}
async function sendMsg(job_id, receiver_id) {
  console.log(job_id, receiver_id);
  const result = await axiosPost("/sendMsgByCon", {
    job_id: job_id,
    receiver_id: receiver_id,
    message: message.value,
  });
  if (result.status == 200) {
    console.log(result);
  }
}
onMounted(async () => {
  const result = await axiosGet("/showJobs");
  if (result.status == 200) {
    console.log(result.data);
    propertyData.data = result.data;
  }
});
</script>
<style scoped></style>
