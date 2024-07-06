<template>
  <v-card style="width: 800px" :elevation="12" class="rounded-xl pa-5">
    <v-card-title class="text-h4 text-center text-teal-darken-4"
      >Update Property Form</v-card-title
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
        <v-btn class="bg-teal-darken-4" @click="updateProperty">Update</v-btn>
      </div>
    </v-form>
  </v-card>
</template>
<script setup>
import { axiosGet, axiosPost } from "@/services/service";
import { ref, reactive, computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useVuelidate } from "@vuelidate/core";
import { required } from "@vuelidate/validators";
const route = useRoute();
const router = useRouter();
const property_id = ref(route.params.id);
const propertyData = reactive({
  id: property_id.value,
  name: null,
  address: null,
});

const rules = computed(() => {
  return {
    name: { required },
    address: { required },
  };
});

async function updateProperty() {
  const result = await axiosPost("/editProperty", propertyData);
  if (result.status == 200) {
    router.push({ name: "Property" });
  }
}
const v$ = useVuelidate(rules, propertyData);
onMounted(async () => {
  const result = await axiosGet(`/getPropertyById?id=${property_id.value}`);
  propertyData.name = result.data[0].property_name;
  propertyData.address = result.data[0].property_address;
});
</script>
<style scoped></style>
