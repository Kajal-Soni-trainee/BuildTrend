const { execute } = require("../dbConnections/executeQuery");
const createEstimate = async (obj, contractor_id) => {
  const { job_id, cost } = obj;
  console.log(job_id, cost);
  const query =
    "insert into estimates (job_id, contractor_id, cost) values (?,?,?);";
  try {
    const result = await execute(query, [job_id, contractor_id, cost]);
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
  const categoriesQuery =
    "select * from jobs inner join jobs_categories on jobs_categories.job_id=jobs.job_id where jobs.job_id=?;";
  const categories = await execute(categoriesQuery, [job_id]);
  const imagesQuery = "select * from job_category_images where isDeleted=0;";
  const images = await execute(imagesQuery);
  return [categories, images];
};

const createState = async (job_id, contractor_id) => {
  const query =
    "insert into contractor_state (job_id,contractor_id,state) values (?,?,0);";
  const result = await execute(query, [job_id, contractor_id]);
  return result;
};
const getWorkProofsWithComments = async (contractor_id) => {
  const query1 =
    "select * from jobs inner join (select work_proofs.job_id, jobs_categories.title, work_proofs.work_proof_id, work_proofs.job_category_id, work_proofs.description from work_proofs inner join jobs_categories on work_proofs.job_category_id=jobs_categories.job_category_id) as a on a.job_id=jobs.job_id where jobs.contractor_id=?; ";
  const result1 = await execute(query1, [contractor_id]);
  const query2 = "select * from work_proof_images where isDeleted=0;";
  const result2 = await execute(query2);
  const query3 =
    "select * from jobs inner join contractor_state on jobs.job_id=contractor_state.job_id where jobs.isDeleted=0 and contractor_state.isDeleted=0 and jobs.contractor_id is not null";
  const result3 = await execute(query3);
  const query4 = "select * from comments where isDeleted=0;";
  const result4 = await execute(query4);
  return [result1, result2, result3, result4];
};
module.exports = {
  createEstimate,
  insertWorkProof,
  showTaskByJobId,
  createState,
  getWorkProofsWithComments,
};
