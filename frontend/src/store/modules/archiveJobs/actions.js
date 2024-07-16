import { axiosGet } from "@/services/service";
const actions = {
  async triggerSetArchivedJobOwner({ commit }) {
    console.log("object");
    const result = await axiosGet("/getArchiveJobsOwner",);
    console.log(result);
    console.log("fgdfgdfg",result.data);
    commit("SET_ARCHIVED_JOBS_OWNER", { data: result.data });
  },
  async triggerSetArchivedJobContractor({ commit }) {
    console.log("object");
    const result = await axiosGet("/getArchiveJobsContractor");
    console.log(result.data);
    commit("SET_ARCHIVED_JOBS_CONTRACTOR", { data: result.data });
  },
};
export default actions;
