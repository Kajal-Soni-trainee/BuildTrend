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
</template>
<script setup>
import { reactive, computed } from "vue";
import { useVuelidate } from "@vuelidate/core";
import { required } from "@vuelidate/validators";
import { axiosPost } from "../services/service";

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

const v$ = useVuelidate(rules, propertyData);
async function addProperty() {
  const isValide = await v$.value.$validate();
  if (isValide) {
    const res = await axiosPost("/addProperty", propertyData);
    console.log(res);
  }
}
</script>
<style scoped></style>
