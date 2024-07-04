const { execute } = require("../dbConnections/executeQuery");
const createEstimate = async (obj, contractor_id) => {
  const { job_id, cost } = obj;
  const query =
    "insert into estimates (job_id, contractor_id, cost) values (?,?);";
  try {
    const result = await execute(query, [job_id, contractor_id, cost]);
    const stateQuery = "select * from owner_state where job_id=?;";
    const stateResult = await execute(stateQuery, [job_id]);
    if (stateResult[0].state != 1) {
      const updateStateQuery = "update owner_state set state=1 where job_id=?";
      const updateStateResult = await execute(updateStateQuery, [job_id]);
    }
    return result;
  } catch (err) {
    console.log(err);
  }
};

const insertWorkProof = async (dataObj, files) => {
  const { id, job_id, job_category_id, description } = dataObj;
  try {
    for (let i = 0; i < id.length; i++) {
      const query =
        "insert into work_proofs (job_id, job_category_id, description) values (?,?,?);";
      const result = await execute(query, [
        job_id[i],
        job_category_id[i],
        description[i],
      ]);
      const work_proof_id = result.insertId;
      files.forEach(async (element) => {
        if (element.originalname == id[i]) {
          const img_path = "/uploads/" + element.filename;
          const insertImageQuery =
            "insert into work_proof_images (work_proof_id,image) values (?,?);";
          const imageResult = await execute(insertImageQuery, [
            work_proof_id,
            img_path,
          ]);
        }
      });
    }
    const updateStateQuery =
      "update contractor_state set state=1 where job_id=?;";
    const stateUpdated = await execute(updateStateQuery, [job_id[0]]);
    return true;
  } catch (err) {
    console.log(err);
  }
};

module.exports = { createEstimate, insertWorkProof };
