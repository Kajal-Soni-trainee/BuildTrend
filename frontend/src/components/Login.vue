<template>
  <v-card style="width: 600px" :elevation="12" class="pa-5 rounded-xl">
    <v-card-title class="text-teal-darken-4 text-h4 text-center py-5"
      >Login Form</v-card-title
    >
    <v-form>
      <v-text-field
        variant="solo-filled"
        label="email"
        v-model="loginData.email"
        :error-messages="v$.password.$errors.map((e) => e.$message)"
        @blur="v$.password.$touch"
      ></v-text-field>
      <v-text-field
        variant="solo-filled"
        :type="showPass ? 'text' : 'password'"
        label="Password"
        v-model="loginData.password"
        :append-inner-icon="showPass ? 'mdi-eye-off' : 'mdi-eye'"
        :error-messages="v$.password.$errors.map((e) => e.$message)"
        @blur="v$.password.$touch"
        @click:append-inner="showPass = !showPass"
      ></v-text-field>
      <div class="d-flex flex-row justify-center align-center">
        <v-btn class="bg-teal-darken-4 text-h5" @click="login">Login</v-btn>
      </div>
    </v-form>
    <div class="d-flex justify-center align-center pa-5">
      <p>Forget Password?</p>
      <p class="text-teal-darken-4" @click="forgetPassword">reset password</p>
    </div>
  </v-card>
</template>
<script setup>
import { reactive, computed, ref } from "vue";
import { useVuelidate } from "@vuelidate/core";
import { required, helpers, email } from "@vuelidate/validators";
import { useRouter } from "vue-router";
import { axiosPost } from "../services/service";
import { useStore } from "vuex";
const store = useStore();
import {
  isNumber,
  isCapAlpha,
  isSpecialChar,
} from "../../public/scripts/validation";
const loginData = reactive({
  email: null,
  password: null,
});
const showPass = ref(false);
const router = useRouter();
const rules = computed(() => {
  return {
    email: { required, email },
    password: {
      required,
      isNumber: helpers.withMessage(
        "Password must include some deigits",
        isNumber
      ),
      isCapAlpha: helpers.withMessage(
        "Password must contain some capital letters",
        isCapAlpha
      ),
      isSpecialChar: helpers.withMessage(
        "Password must include some special character",
        isSpecialChar
      ),
    },
  };
});
const v$ = useVuelidate(rules, loginData);
async function login() {
  const result = await v$.value.$validate();
  if (result) {
    const res = await axiosPost("/login", loginData);
    console.log(res.data);
    store.dispatch("triggerSetTokenRole", res.data);
    if (res.data.role == 0) {
      router.push({ name: "Property" });
    }
    if (res.data.role == 1) {
      router.push({ name: "ShowJob" });
    }
  }
}
async function forgetPassword() {
  router.push({ name: "ForgetPassword" });
}
</script>
<style scoped></style>
