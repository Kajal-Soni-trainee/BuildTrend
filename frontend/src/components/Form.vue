<template>
  <v-form class="form">
    <v-text-field
      label="Title"
      v-model="title"
      variant="solo-filled"
    ></v-text-field>
    <v-file-input
      label="Images"
      variant="solo-filled"
      multiple
      prepend-inner-icon="mdi-camera"
      v-model="images"
    ></v-file-input>
    <v-textarea
      v-model="descripton"
      label="Description"
      variant="solo-filled"
    ></v-textarea>
  </v-form>
</template>
<script setup>
import { defineModel } from "vue";
const title = defineModel("title");
const descripton = defineModel("description");
const images = defineModel("images");
</script>
<style></style>
