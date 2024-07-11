<template>
  <v-card style="width: 1000px" :elevation="12" class="pa-5 rounded-xl">
    <v-card-title class="text-teal-darken-4 text-h4 text-center py-5"
      >Registeration From</v-card-title
    >
    <v-form>
      <v-row>
        <v-col md="6">
          <v-text-field
            v-model="userData.name"
            variant="solo-filled"
            label="Name"
            :error-messages="v$.name.$errors.map((e) => e.$message)"
            @blur="v$.name.$touch"
          ></v-text-field>
        </v-col>
        <v-col md="6">
          <v-text-field
            v-model="userData.email"
            variant="solo-filled"
            label="Email"
            :error-messages="v$.email.$errors.map((e) => e.$message)"
            @blur="v$.email.$touch"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col md="6">
          <v-text-field
            variant="solo-filled"
            v-model="userData.contact"
            label="Contact"
            :error-messages="v$.contact.$errors.map((e) => e.$message)"
            @blur="v$.contact.$touch"
          ></v-text-field>
        </v-col>
        <v-col md="6">
          <v-select
            variant="solo-filled"
            label="Role"
            v-model="userData.role"
            :items="[0, 1]"
            :error-messages="v$.role.$errors.map((e) => e.$message)"
            @blur="v$.role.$touch"
          >
          </v-select>
        </v-col>
      </v-row>
      <v-row>
        <v-col md="6">
          <v-text-field
            variant="solo-filled"
            :type="showPass ? 'text' : 'password'"
            label="Password"
            v-model="userData.password"
            :append-inner-icon="showPass ? 'mdi-eye-off' : 'mdi-eye'"
            :error-messages="v$.password.$errors.map((e) => e.$message)"
            @blur="v$.password.$touch"
            @click:append-inner="showPass = !showPass"
          ></v-text-field>
        </v-col>
        <v-col md="6">
          <v-text-field
            variant="solo-filled"
            label="Confirm Password"
            :type="showConfirmPass ? 'text' : 'password'"
            v-model="userData.cpassword"
            :append-inner-icon="showConfirmPass ? 'mdi-eye-off' : 'mdi-eye'"
            :error-messages="v$.cpassword.$errors.map((e) => e.$message)"
            @blur="v$.cpassword.$touch"
            @click:append-inner="showConfirmPass = !showConfirmPass"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-textarea
            v-model="userData.address"
            variant="solo-filled"
            label="Address"
            :error-messages="v$.address.$errors.map((e) => e.$message)"
            @blur="v$.address.$touch"
          >
          </v-textarea>
        </v-col>
      </v-row>

      <div class="d-flex flex-row justify-center align-center">
        <v-btn class="bg-teal-darken-4 text-h5" @click="submit">Submit</v-btn>
      </div>
    </v-form>
    <div class="d-flex justify-center align-center pa-5">
      <p>Already Register?</p>
      <p class="text-teal-darken-4" @click="login">Login</p>
    </div>
  </v-card>
</template>
<script setup>
import { useRouter } from "vue-router";
import { reactive, computed, ref } from "vue";
import { useVuelidate } from "@vuelidate/core";
import { required, sameAs, helpers, email } from "@vuelidate/validators";
import { axiosPost } from "../services/service";
import {
  onlyChar,
  isNumber,
  isCapAlpha,
  isSpecialChar,
  isPhone,
} from "../../public/scripts/validation";
const showPass = ref(false);
const showConfirmPass = ref(false);
const router = useRouter();
// const roleItem = ref([
//   { label: "Contractor", value: 1 },
//   { label: "Property Owner", value: 0 },
// ]);
const userData = reactive({
  name: null,
  email: null,
  address: null,
  contact: null,
  role: null,
  password: null,
  cpassword: null,
});

const rules = computed(() => {
  return {
    name: {
      required,
      onlyChar: helpers.withMessage(
        "name should only contain characters",
        onlyChar
      ),
    },
    email: { required, email: helpers.withMessage("invalide email", email) },
    address: { required },
    contact: {
      required,
      isPhone: helpers.withMessage(
        "contact number should be of 10 digits",
        isPhone
      ),
    },
    role: { required },
    password: {
      required,
      isNumber: helpers.withMessage(
        "Password should contain some digits",
        isNumber
      ),
      isCapAlpha: helpers.withMessage(
        "Password should contain some capital letters ",
        isCapAlpha
      ),
      isSpecialChar: helpers.withMessage(
        "Password should contain some specia charaters",
        isSpecialChar
      ),
    },
    cpassword: { required, sameAs: sameAs(userData.password) },
  };
});
const v$ = useVuelidate(rules, userData);

async function submit() {
  const result = await v$.value.$validate();
  if (result) {
    const result = await axiosPost("/register", {
      name: userData.name,
      email: userData.email,
      password: userData.password,
      address: userData.address,
      contact: userData.contact,
      role: userData.role,
    });
    if (result) {
      console.log(result);
      router.push({ name: "Login" });
    }
  }
}
function login() {
  router.push({ name: "Login" });
}
</script>
<style scoped></style>
