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
  SET_MSGS_BY_JOB_ID(state, payload) {
    state.msgsByJobId = payload.data;
  },
  SET_WORK_PROOF_DETAILS(state, payload) {
    state.workProofDetails = payload.data;
  },
  SET_WORK_PROOF_IMAGES(state, payload) {
    state.workProofImages = payload.data;
  },
  SET_WORK_PROOF_COMMENTS(state, payload) {
    state.workProofComments = payload.data;
  },
  SET_CUR_JOB_CON_STATE(state, payload) {
    state.currentJobConState = payload.data;
  },
  SET_CUR_JOB_OWNER_STATE(state, payload) {
    state.currentJobOwnerState = payload.data;
  },

  SET_ALL_CONTRACTORS(state, payload) {
    state.allContractors = payload.data;
  },
};
export default mutations;
