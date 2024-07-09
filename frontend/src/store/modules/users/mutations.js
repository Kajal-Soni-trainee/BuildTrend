const mutations = {
  SET_TOKEN_ROLE(state, payload) {
    localStorage.setItem("token", payload.token);
    localStorage.setItem("role_id", payload.role);
    state.token = payload.token;
    state.role = payload.role;
    state.isLoggedIn = true;
  },
  SET_AUTH(state, payload) {
    state.token = payload.token;
    state.role = payload.role;
    state.isLoggedIn = true;
  },
  RESET_AUTH(state) {
    state.token = null;
    state.role = null;
    state.isLoggedIn = false;
  },
};
export default mutations;
