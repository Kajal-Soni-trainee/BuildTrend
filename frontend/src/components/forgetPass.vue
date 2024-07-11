<template>
  <v-card style="width: 600px" :elevation="12" class="pa-5 rounded-xl">
    <v-card-title class="text-teal-darken-4 text-h4 text-center py-5"
      >Login From</v-card-title
    >
    <v-form>
      <v-text-field
        variant="solo-filled"
        label="email"
        v-model="userData.email"
        :error-messages="v$.email.$errors.map((e) => e.$message)"
        @blur="v$.email.$touch"
      ></v-text-field>
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
      <v-text-field
        variant="solo-filled"
        :type="showCPass ? 'text' : 'password'"
        label="Confirm Password"
        v-model="userData.cpassword"
        :append-inner-icon="showCPass ? 'mdi-eye-off' : 'mdi-eye'"
        :error-messages="v$.cpassword.$errors.map((e) => e.$message)"
        @blur="v$.cpassword.$touch"
        @click:append-inner="showCPass = !showCPass"
      ></v-text-field>
      <div class="d-flex flex-row justify-center align-center">
        <v-btn class="bg-teal-darken-4 text-h5" @click="setPassword"
          >Set Password</v-btn
        >
      </div>
    </v-form>
  </v-card>
</template>
<script setup>
import { reactive, computed, ref } from "vue";
import { useVuelidate } from "@vuelidate/core";
import { required, helpers, email, sameAs } from "@vuelidate/validators";
import { useRouter } from "vue-router";
import { axiosPost } from "../services/service";
import {
  isNumber,
  isCapAlpha,
  isSpecialChar,
} from "../../public/scripts/validation";
const router = useRouter();
const showPass = ref(false);
const showCPass = ref(false);
const userData = reactive({
  email: null,
  password: null,
  cpassword: null,
});

const rules = computed(() => {
  return {
    email: { required, email },
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
async function setPassword() {
  const isValide = await v$.value.$validate();
  if (isValide) {
    const res = await axiosPost("/forgetPass", userData);
    if (res) {
      router.push({ name: "Login" });
    }
  }
}
</script>
<style scoped></style>
