import { createStore } from "vuex";
import users from "./modules/users";
import contractor from "./modules/contractor";
import property from "./modules/property";
import archiveJobs from "./modules/archiveJobs";
const store = createStore({
  modules: {
    users,
    contractor,
    property,
    archiveJobs,
  },
});

export default store;
