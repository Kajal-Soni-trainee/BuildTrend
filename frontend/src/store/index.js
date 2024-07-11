import { createStore } from "vuex";
import users from "./modules/users";
import contractor from "./modules/contractor";
import property from "./modules/property";
const store = createStore({
  modules: {
    users,
    contractor,
    property,
  },
});

export default store;
