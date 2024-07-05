import { createApp } from "vue";
import App from "./App.vue";
import vuetify from "./plugins/vuetify";
import router from "./routes/route";
import { loadFonts } from "./plugins/webfontloader";
import store from "./store";
loadFonts();
router.beforeEach((to, from, next) => {
  if (
    to.name == "Login" ||
    to.name == "Register" ||
    to.name == "ForgetPassword"
  ) {
    next();
  } else {
    if (!store.state.users.isLoggedIn) {
      console.log(store.state.users.isLoggedIn);
      next({ path: "/login" });
    } else {
      next();
    }
  }
});
createApp(App).use(vuetify).use(store).use(router).mount("#app");
