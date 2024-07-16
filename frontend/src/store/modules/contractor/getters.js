const getters = {
  getWorkProofDetails(state) {
    const result = [];
    state.jobsCon.forEach((element) => {
      const temp = [];
      state.workProofDetailsCon.forEach((proof) => {
        if (element.job_id == proof.job_id) {
          temp.push(proof);
        }
      });
      result.push(temp);
    });
    return result;
  },
};
export default getters;
