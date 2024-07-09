const mutations = {
  SET_PROPERITES(state, payload) {
    state.properties = payload.property;
  },
  SET_JOBS(state, payload) {
    state.allJobs = payload.data;
  },
  SET_ESTIMATES(state, payload) {
    state.estimates = payload.data;
  },
  SET_CONTACTS(state, payload) {
    state.contacts = payload.data;
  },
  SET_OWNER_ID(state, payload) {
    state.owner_id = payload.data;
  },
  SET_MSGS_BY_JOB_ID(state, payload) {
    state.msgsByJobId = payload.data;
  },
  SET_WORK_PROOF_DETAILS(state, payload) {
    state.workProofDetails = payload.data;
  },
  SET_WORK_PROOF_IMAGES(state, payload) {
    state.workProofImages = payload.data;
  },
};
export default mutations;
