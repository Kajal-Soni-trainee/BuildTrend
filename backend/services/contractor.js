const { execute } = require("../dbConnections/executeQuery");
const createEstimate = async (obj, contractor_id) => {
  const { job_id, cost } = obj;
  console.log(job_id, cost);
  const query =
    "insert into estimates (job_id, contractor_id, cost) values (?,?,?);";
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
  const { job_id, job_category_id, description } = dataObj;
  try {
    const query1 =
      "insert into work_proofs (job_id, job_category_id, description) values (?,?,?)";
    const result = await execute(query1, [
      job_id,
      job_category_id,
      description,
    ]);
    const work_proof_id = result.insertId;
    files.forEach(async (element) => {
      const imageQuery =
        "insert into work_proof_images (work_proof_id, image) values (?,?);";
      const img_path = "/uploads/" + element.filename;
      const imageResult = await execute(imageQuery, [work_proof_id, img_path]);
    });
    const updateStateQuery =
      "update contractor_state set state=2 where job_id=?;";
    const stateUpdated = await execute(updateStateQuery, [job_id[0]]);
    return true;
  } catch (err) {
    console.log(err);
  }
};

const showTaskByJobId = async (job_id) => {
  const query =
    "select * from jobs_categories join job_category_images on jobs_categories.job_category_id=job_category_images.job_category_id where jobs_categories.job_id=?;";
  const result = await execute(query, [job_id]);
  return result;
};

const createState = async (job_id, contractor_id) => {
  const query =
    "insert into contractor_state (job_id,contractor_id,state) values (?,?,0);";
  const result = await execute(query, [job_id, contractor_id]);
  return result;
};
module.exports = {
  createEstimate,
  insertWorkProof,
  showTaskByJobId,
  createState,
};
