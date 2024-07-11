<template>
  <v-sheet :elevation="12" style="height: 1000px; width: 1000px">
    <v-card
      class="scroll bg-teal-accent-1"
      :elevation="12"
      width="1000px"
      style="height: 1000px; width: 1000px"
    >
      <v-toolbar
        ><v-icon size="50px"> mdi-account</v-icon>
        <v-toolbar-title>{{ u_name }}</v-toolbar-title>
      </v-toolbar>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <template v-for="item in allMsgs" :key="item.message_id">
        <div
          v-if="item.sender_id != owner_id"
          style="clear: both"
          class="float-left border-lg bg-yellow-lighten-5 rounded-xl pa-5 mt-2"
        >
          <p>{{ item.message }}</p>
        </div>
        <div
          v-else
          style="clear: both"
          class="float-right border-lg bg-teal-darken-4 rounded-xl pa-5 mt-2"
        >
          <p class="text-h5" style="width: 400px">
            {{ item.message }}
          </p>
        </div>
      </template>
    </v-card>
    <div class="d-flex flex-row justify-center align-center ga-3">
      <v-text-field
        variant="solo-filled"
        label="Message"
        v-model="message"
      ></v-text-field>
      <v-btn class="bg-teal-darken-4" size="x-large" @click="sendMsg"
        >send</v-btn
      >
    </div>
  </v-sheet>
</template>
<script setup>
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import { ref, onMounted, computed } from "vue";
import { axiosPost } from "../services/service";
import { io } from "socket.io-client";
const socket = io("http://localhost:8000");
const store = useStore();
const route = useRoute();
const job_id = ref(route.query.job_id);
const contractor_id = ref(route.query.contractor_id);
const owner_id = ref(route.query.owner_id);
const u_name = ref(route.query.u_name);
const message = ref(null);

const allMsgs = computed(() => {
  return store.state.property.msgsByJobId;
});

async function sendMsg() {
  const result = await axiosPost("/sendMsgByCon", {
    job_id: job_id.value,
    receiver_id: contractor_id.value,
    message: message.value,
  });
  if (result.status == 200) {
    message.value = null;
    socket.emit("sendMsgOwner", 1);
    await store.dispatch("triggerSetMsgsByJobId", {
      job_id: job_id.value,
      sender_id: owner_id.value,
      receiver_id: contractor_id.value,
    });
  }
}
onMounted(async () => {
  await store.dispatch("triggerSetMsgsByJobId", {
    job_id: job_id.value,
    sender_id: owner_id.value,
    receiver_id: contractor_id.value,
  });
  socket.on("receiveMsgContractor", (msg) => {
    console.log("receiving contractor messge", msg);
    // await store.dispatch("triggerSetMsgsByJobId", {
    //   job_id: job_id.value,
    //   sender_id: owner_id.value,
    //   receiver_id: contractor_id.value,
    // });
  });
});
</script>
<style scoped>
.scroll {
  overflow-y: scroll;
}
</style>
