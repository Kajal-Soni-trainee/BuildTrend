<template>
  <v-card class="pa-8 rounded-xl" :elevation="16" width="1000px">
    <v-card-title class="text-h4 text-center text-teal-darken-4"
      >Profile Details</v-card-title
    >
    <v-row>
      <v-col md="4" class="pa-5">
        <div>
          <v-img
            v-if="userDetail.data.u_img == null"
            src="../../public/images/unKownUser.svg"
          ></v-img>
          <v-img
            v-else
            class="rounded-circle"
            :src="'http://localhost:8000' + userDetail.data.u_img"
            heigth="300px"
            width="300px"
          ></v-img>
        </div>
        <div class="d-flex flex-row justify-center ma-5">
          <v-btn class="bg-teal-darken-4" @click="imgInput = true"
            >Edit Image</v-btn
          >
        </div>
      </v-col>
      <v-col md="8">
        <div class="d-flex flex-row justify-center align-center ga-5">
          <v-text-field
            variant="solo-filled"
            :disabled="disableName"
            label="Name"
            v-model="userDetail.data.u_name"
          ></v-text-field>
          <v-icon
            @click="disableName = !disableName"
            :color="disableName ? 'teal-darken-4' : 'red'"
            size="x-large"
            >mdi-pencil</v-icon
          >
        </div>
        <div class="d-flex flex-row justify-center align-center ga-5">
          <v-text-field
            variant="solo-filled"
            :disabled="disableEmail"
            label="Email"
            v-model="userDetail.data.u_email"
          ></v-text-field>
          <v-icon
            @click="disableEmail = !disableEmail"
            :color="disableEmail ? 'teal-darken-4' : 'red'"
            size="x-large"
            >mdi-pencil</v-icon
          >
        </div>
        <div class="d-flex flex-row justify-center align-center ga-5">
          <v-text-field
            variant="solo-filled"
            :disabled="disableContact"
            label="Contact"
            v-model="userDetail.data.u_contact"
          ></v-text-field>
          <v-icon
            @click="disableContact = !disableContact"
            :color="disableContact ? 'teal-darken-4' : 'red'"
            size="x-large"
            >mdi-pencil</v-icon
          >
        </div>
        <div class="d-flex flex-row justify-center align-center ga-5">
          <v-select
            variant="solo-filled"
            disabled="true"
            label="Role"
            :items="roleItems"
            item-title="roleText"
            item-value="roleValue"
            v-model="userDetail.data.u_role"
          ></v-select>
        </div>
        <div class="d-flex flex-row justify-center align-center ga-5">
          <v-textarea
            variant="solo-filled"
            :disabled="disableAddress"
            label="Address"
            v-model="userDetail.data.u_address"
          ></v-textarea>
          <v-icon
            @click="disableAddress = !disableAddress"
            :color="disableAddress ? 'teal-darken-4' : 'red'"
            size="x-large"
            >mdi-pencil</v-icon
          >
        </div>
        <div
          v-if="
            disableName == false ||
            disableEmail == false ||
            disableContact == false ||
            disableAddress == false
          "
          class="d-flex flex-row justify-center align-center"
        >
          <v-btn class="bg-teal-darken-4" @click="updateUser">Submit</v-btn>
        </div>
      </v-col>
      <v-dialog v-model="imgInput" width="auto">
        <v-card width="500px" class="pa-5">
          <v-card-title>Select your Image</v-card-title>
          <v-file-input
            :elevation="12"
            variant="solo-filled"
            label="Image"
            v-model="image"
          ></v-file-input>
          <div class="d-flex flex-row justify-center align-center">
            <v-btn variant="outlined" @click="addImg">Add</v-btn>
          </div>
        </v-card>
      </v-dialog>
    </v-row>
  </v-card>
</template>
<script setup>
import { onMounted, ref, reactive } from "vue";
import { axiosGet } from "@/services/service";
import { axiosPost } from "../services/service";
const disableName = ref(true);
const disableEmail = ref(true);
const disableContact = ref(true);
const disableAddress = ref(true);
const roleItems = ref([
  { roleText: "Contractor", roleValue: 1 },
  { roleText: "Property Owner", roleValue: 0 },
]);
const image = ref(null);
const imgInput = ref(false);
const userDetail = reactive({ data: {} });

async function addImg() {
  const formData = new FormData();
  formData.append("image", image.value);
  formData.append("user_id", userDetail.data.u_id);
  const result = await axiosPost("/addImg", formData);
  if (result.status == 200) {
    imgInput.value = false;
    const result = await axiosGet("/getUserDetails");
    if (result.status == 200) {
      userDetail.data = result.data[0];
    }
  }
}
async function updateUser() {
  const result = await axiosPost("/updateUser", userDetail.data);
  if (result.status == 200) {
    const userData = await axiosGet("/getUserDetails");
    if (userData.status == 200) {
      userDetail.data = userData.data[0];
    }
  }
}
onMounted(async () => {
  console.log("calling trigger");
  const result = await axiosGet("/getUserDetails");
  if (result.status == 200) {
    userDetail.data = result.data[0];
  }
});
</script>
<style scoped></style>
