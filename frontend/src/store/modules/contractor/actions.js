import { axiosGet } from "@/services/service";
const actions = {
  async triggerSetTask({ commit }, payload) {
    const result = await axiosGet(`showTask/?job_id=${payload.job_id}`);
    console.log(result.data);
    commit("SET_CATEGORIES_BY_JOB_ID", { data: result.data.categories });
    commit("SET_IMAGES_BY_JOB_ID", { data: result.data.images });
    commit("SET_ESTIMATECOUNT_BY_JOB_ID", { data: result.data.estimateCount });
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

    await commit("SET_MESSAGES", { data: result.data });
  },
  async triggerSetWorkProofsCon({ commit }) {
    const result = await axiosGet(`/getAllWorkProofs`);

    await commit("SET_WORK_PROOF_DETAILS_CON", { data: result.data.result1 });
    await commit("SET_WORK_PROOF_IMAGES_CON", { data: result.data.result2 });
    await commit("SET_JOB", { data: result.data.result3 });
    await commit("SET_WORK_PROOF_COMMENTS_CON", { data: result.data.result4 });
  },
  async triggerSetSelectedJobs({ commit }) {
    const result = await axiosGet("/selectedJobs");
    commit("SET_SELECTED_JOBS", { data: result.data });
  },
  async triggerUnSelectedJobs({ commit }) {
    const result = await axiosGet("/unSelectedJobs");
    console.log(result.data);
    commit("SET_UNSELECTED_JOBS", { data: result.data });
  },
};
export default actions;
