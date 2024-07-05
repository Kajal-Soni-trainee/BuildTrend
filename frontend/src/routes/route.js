import { createWebHistory, createRouter } from "vue-router";
const routes = [
  {
    name: "Register",
    component: () => import("../components/Register.vue"),
    path: "/",
  },
  {
    name: "Login",
    component: () => import("../components/Login.vue"),
    path: "/login",
  },
  {
    name: "ForgetPassword",
    component: () => import("../components/forgetPass.vue"),
    path: "/forgetPass",
  },
  {
    name: "Property",
    component: () => import("../components/Property.vue"),
    path: "/property",
    meta: { requiredAuth: true },
  },
  {
    name: "AddProperty",
    component: () => import("../components/AddProperty.vue"),
    path: "/addProperty",
    meta: { requiredAuth: true },
  },
  {
    name: "JobForm",
    component: () => import("../components/JobForm.vue"),
    path: "/addJob",
    meta: { requiredAuth: true },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
