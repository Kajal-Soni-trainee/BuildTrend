const mutations = {
  SET_TOKEN_ROLE(state, payload) {
    state.token = payload.token;
    state.role = payload.role;
    state.isLoggedIn = true;
  },
};
export default mutations;
