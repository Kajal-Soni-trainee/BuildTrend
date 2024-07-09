import { axiosGet } from "@/services/service";
const actions = {
  async triggerSetTask({ commit }, payload) {
    const result = await axiosGet(`showTask/?job_id=${payload.job_id}`);
    console.log(result.data);
    await commit("SET_TASK", { data: result.data });
  },
  async triggerSetJobs({ commit }) {
    const result = await axiosGet("/showJobs");
    console.log(result.data);
    await commit("SET_JOBS", { data: result.data });
  },
  async triggerSetContacts({ commit }) {
    const result = await axiosGet("/getContacts");
    console.log(result);
    await commit("SET_CONTACTS", { data: result.data });
  },
  async triggerSetMessages({ commit }, payload) {
    const result = await axiosGet(
      `/getMessages?job_id=${payload.job_id}&owner_id=${payload.owner_id}`
    );
    console.log(result.data);
    await commit("SET_MESSAGES", { data: result.data });
  },
  async triggerSetWorkProofs({ commit }, payload) {
    const result = await axiosGet(`/getWorkProof/?job_id=${payload.job_id}`);
    console.log(result);
    commit("SET_WORK_PROOF_DETAILS", { data: result.data.result1 });
    commit("SET_WORK_PROOF_IMAGES", { data: result.data.result2 });
    commit("SET_WORK_PROOF_COMMENTS", { data: result.data.result3 });
  },
};
export default actions;
