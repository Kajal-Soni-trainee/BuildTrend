import { axiosGet } from "@/services/service";
const actions = {
  triggerSetTokenRole({ commit }, payload) {
    commit("SET_TOKEN_ROLE", payload);
  },
  async triggerSetUserDetails({ commit }) {
    const result = await axiosGet("/getUserDetails");
    if (result.status == 200) {
      console.log(result.data);
      commit("SET_USER_DETAILS", { data: result.data });
    }
  },
};
export default actions;
