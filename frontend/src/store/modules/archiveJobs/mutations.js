const mutations = {
  SET_ARCHIVED_JOBS_OWNER(state, payload) {
    state.archivedJobsOwner = payload.data;
  },
  SET_ARCHIVED_JOBS_CONTRACTOR(state, payload) {
    state.archivedJobsContractor = payload.data;
  },
};
export default mutations;
