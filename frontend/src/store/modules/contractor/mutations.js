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
  SET_WORK_PROOF_DETAILS_CON(state, payload) {
    state.workProofDetailsCon = payload.data;
  },
  SET_WORK_PROOF_IMAGES_CON(state, payload) {
    state.workProofImagesCon = payload.data;
  },
  SET_WORK_PROOF_COMMENTS_CON(state, payload) {
    state.workProofCommentsCon = payload.data;
  },
  SET_JOB(state, payload) {
    state.jobsCon = payload.data;
  },
  SET_SELECTED_JOBS(state, payload) {
    state.selectedJobs = payload.data;
  },
  SET_UNSELECTED_JOBS(state, payload) {
    state.unSelectedJobs = payload.data;
  },
  SET_CATEGORIES_BY_JOB_ID(state, payload) {
    state.categoriesByJobId = payload.data;
  },
  SET_IMAGES_BY_JOB_ID(state, payload) {
    state.imagesByJobId = payload.data;
  },
  SET_ESTIMATECOUNT_BY_JOB_ID(state, payload) {
    state.estimateCount = payload.data;
  },
};
export default mutations;
