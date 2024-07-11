<template>
  <v-card style="width: 800px" :elevation="12" class="rounded-xl pa-5">
    <v-card-title class="text-h4 text-center text-teal-darken-4"
      >Add Property Form</v-card-title
    >
    <v-form>
      <v-text-field
        variant="solo-filled"
        label="Property Name"
        v-model="propertyData.name"
        :error-messages="v$.name.$errors.map((e) => e.$message)"
        @blur="v$.name.$touch"
      ></v-text-field>
      <v-textarea
        variant="solo-filled"
        label="Address"
        v-model="propertyData.address"
        :error-messages="v$.address.$errors.map((e) => e.$message)"
        @blur="v$.address.$touch"
      ></v-textarea>
      <div class="d-flex flex-row justify-center align-center">
        <v-btn class="bg-teal-darken-4" @click="addProperty"
          >Add Property</v-btn
        >
      </div>
    </v-form>
  </v-card>
  <v-dialog v-model="alert" width="auto">
    <v-card height="100px" width="400px" class="pa-5"
      ><div class="d-flex flex-column justify-center align-center">
        <p>Property Add Successfully</p>
        <v-btn variant="outlined" @click="redirect">Ok</v-btn>
      </div></v-card
    >
  </v-dialog>
</template>
<script setup>
import { reactive, computed, ref } from "vue";
import { useVuelidate } from "@vuelidate/core";
import { required } from "@vuelidate/validators";
import { axiosPost } from "../services/service";
import router from "@/routes/route";
const alert = ref(false);
const propertyData = reactive({
  name: null,
  address: null,
});

const rules = computed(() => {
  return {
    name: { required },
    address: { required },
  };
});

function redirect() {
  alert.value = false;
  router.push({ name: "Property" });
}
const v$ = useVuelidate(rules, propertyData);
async function addProperty() {
  const isValide = await v$.value.$validate();
  if (isValide) {
    const res = await axiosPost("/addProperty", propertyData);
    if (res.status == 200) {
      alert.value = true;
    }
  }
}
</script>
<style scoped></style>
