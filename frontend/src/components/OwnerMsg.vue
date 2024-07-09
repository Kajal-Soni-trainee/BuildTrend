<template>
  <v-sheet class="scroll" :elevation="12" style="height: 1000px; width: 1000px">
    <v-card
      class="scroll bg-teal-accent-1"
      :elevation="12"
      width="1000px"
      style="height: 1000px; width: 1000px"
    >
      <v-toolbar
        ><v-icon size="50px"> mdi-account</v-icon>
        <v-toolbar-title>{{ display_name }}</v-toolbar-title>
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
const store = useStore();
const route = useRoute();
const job_id = ref(route.query.job_id);
const sender_id = ref(route.query.sender_id);
const receiver_id = ref(route.query.receiver_id);
const sender_name = ref(route.query.sender_name);
const receiver_name = ref(route.query.receiver_name);
const message = ref(null);
const owner_id = computed(() => {
  return store.state.property.owner_id;
});
const display_name = computed(() => {
  if (sender_id.value == owner_id.value) {
    return receiver_name.value;
  } else {
    return sender_name.value;
  }
});

const msgReceiver = computed(() => {
  if (sender_id.value == owner_id.value) {
    return receiver_id.value;
  } else {
    return sender_id.value;
  }
});

const allMsgs = computed(() => {
  return store.state.property.msgsByJobId;
});

async function sendMsg() {
  const result = await axiosPost("/sendMsgByCon", {
    job_id: job_id.value,
    receiver_id: msgReceiver.value,
    message: message.value,
  });
  if (result.status == 200) {
    console.log(result);
  }
}
onMounted(async () => {
  await store.dispatch("triggerSetMsgsByJobId", {
    job_id: job_id.value,
    sender_id: sender_id.value,
    receiver_id: receiver_id.value,
  });
  console.log(
    sender_name.value,
    receiver_name.value,
    owner_id.value,
    allMsgs.value
  );
});
</script>
<style scoped></style>
