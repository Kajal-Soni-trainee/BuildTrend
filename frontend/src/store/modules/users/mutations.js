const mutations = {
  SET_TOKEN_ROLE(state, payload) {
    localStorage.setItem("token", payload.token);
    localStorage.setItem("role_id", payload.role);
    localStorage.setItem("name", payload.name);
    localStorage.setItem("img", payload.img);
    state.token = payload.token;
    state.role = payload.role;
    state.isLoggedIn = true;
    state.name = payload.name;
    state.img = payload.img;
  },
  SET_AUTH(state, payload) {
    state.token = payload.token;
    state.role = payload.role;
    state.name = payload.name;
    state.img = payload.img;
    state.isLoggedIn = true;
  },
  RESET_AUTH(state) {
    state.token = null;
    state.role = null;
    state.name = null;
    state.img = null;
    state.isLoggedIn = false;
  },
  SET_USER_DETAILS(state, payload) {
    console.log(payload.data);
    state.userDetail = payload.data;
  },
};
export default mutations;
