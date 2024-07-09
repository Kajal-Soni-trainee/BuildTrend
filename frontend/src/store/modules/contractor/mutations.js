const mutations = {
  SET_TASK(state, payload) {
    state.tasksByJobId = payload.data;
  },
  SET_JOBS(state, payload) {
    state.allJobs = payload.data;
  },
  SET_CONTACTS(state, payload) {
    state.contacts = payload.data;
  },
  SET_MESSAGES(state, payload) {
    state.messages = payload.data;
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
};
export default mutations;
