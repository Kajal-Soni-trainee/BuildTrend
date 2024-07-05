import { axiosGet } from "../../../services/service";

const actions = {
  async getProperites({ commit }) {
    const property = await axiosGet("/getProperty");
    commit("SET_PROPERITES", { property: property.data });
  },
};
export default actions;
