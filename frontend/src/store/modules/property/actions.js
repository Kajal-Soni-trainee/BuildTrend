import { axiosGet } from "../../../services/service";

const actions = {
  async getProperites({ commit }) {
    const property = await axiosGet("/getProperty");
    commit("SET_PROPERITES", { property: property.data });
  },
  async triggerSetJobs({ commit }) {
    const result = await axiosGet("/showJobs");
    commit("SET_JOBS", { data: result.data });
  },
  async triggerSetEstimates({ commit }, payload) {
    const result = await axiosGet(`/showEstimates/?job_id=${payload.job_id}`);
    commit("SET_ESTIMATES", { data: result.data });
  },
  async triggerSetContacts({ commit }, payload) {
    const result = await axiosGet(
      `/getMessageOwner/?job_id=${payload.job_id}&owner_id=${payload.owner_id}`
    );
    commit("SET_CONTACTS", { data: result.data });
  },
  async triggerSetMsgsByJobId({ commit }, payload) {
    console.log(payload);
    const result = await axiosGet(
      `/getAllMsgs/?job_id=${payload.job_id}&sender_id=${payload.sender_id}&receiver_id=${payload.receiver_id}`
    );
    console.log(result.data);
    commit("SET_MSGS_BY_JOB_ID", { data: result.data });
  },
  async triggerSetWorkProofs({ commit }, payload) {
    const result = await axiosGet(`/getWorkProof/?job_id=${payload.job_id}`);
    console.log(result);
    commit("SET_WORK_PROOF_DETAILS", { data: result.data.result1 });
    commit("SET_WORK_PROOF_IMAGES", { data: result.data.result2 });
    commit("SET_WORK_PROOF_COMMENTS", { data: result.data.result3 });
    commit("SET_CUR_JOB_CON_STATE", { data: result.data.conState });
    commit("SET_CUR_JOB_OWNER_STATE", { data: result.data.ownerState });
  },
};
export default actions;
