const { execute } = require("../dbConnections/executeQuery");

const getAllPropertyByUserID = async (id) => {
  const query = "select * from properties where owner_id=? and isDeleted=0";
  try {
    const result = await execute(query, [id]);
    return result;
  } catch (err) {
    console.log(err);
  }
};

const addNewJob = async (owner_id, property_id) => {
  const query = "insert into jobs (owner_id, property_id) values (?,?);";
  try {
    const result = await execute(query, [owner_id, property_id]);
    return result.insertId;
  } catch (err) {
    console.log(err);
  }
};
const addUserState = async (job_id, owner_id) => {
  const query = "insert into owner_state (owner_id, job_id) values (?,?);";
  try {
    const result = await execute(query, [job_id, owner_id]);
  } catch (err) {
    console.log(err);
  }
};
const addCategoryDetails = async (dataObj, files, job_id) => {
  const { id, title, description } = dataObj;
  try {
    for (let i = 0; i < id.length; i++) {
      const query =
        "insert into jobs_categories (job_id, title,description) values (?,?);";
      const result = await execute(query, job_id, title[i], description[i]);
      const categoryId = result.insertId;
      files.forEach(async (image) => {
        if (image.originalname == id[i]) {
          const insertImageQuery =
            "insert into job_category_images (job_category_id, image) values (?,?);";
          const imgPath = "/uploads/" + image.filename;
          const result = await execute(insertImageQuery, [categoryId, imgPath]);
        }
      });
    }
    return true;
  } catch (err) {
    console.log(err);
    return false;
  }
};
const getEstimateByJobId = async (job_id) => {
  const query = "select * from estimates where job_id=? and isDeleted=0;";
  try {
    const result = await execute(query, [job_id]);
    return result;
  } catch (err) {
    console.log(err);
  }
};
const deleteOthersEstimate = async (estimate_id, job_id) => {
  const query =
    "update estimates set deleted_at=current_timestamp(), isDeleted=1 where job_id=? and estimate_id <> ?;";
  try {
    const result = await execute(query, [job_id, estimate_id]);
    return result;
  } catch (err) {
    console.log(err);
  }
};

const addJobContractor = async (contractor_id, job_id) => {
  const query = "update jobs set contractor_id=? where job_id=?;";
  try {
    const result = await execute(query, [contractor_id, job_id]);
    return result;
  } catch (err) {
    console.log(err);
  }
};
const updateStates = async (job_id) => {
  try {
    const jobQuery = "select * from jobs where job_id =?;";
    const jobResult = await execute(jobQuery, [job_id]);
    const ownerStateQuery = "update owner_state set state = 2 where job_id=?;";
    const ownerStateResult = await execute(ownerStateQuery, [job_id]);
    const contractorStateQuery =
      "insert into contractor_state (job_id) values (?);";
    const cotractorStateResult = await execute(contractorStateQuery, [job_id]);
    return true;
  } catch (err) {
    console.log(err);
  }
};
const getWorkProofByJobId = async (job) => {
  const query =
    "select * from jobs inner join (select * from work_proofs inner join work_proof_images on work_proofs.work_proof_id=work_proof_images.work_proof_id) as a on  jobs.job_id=a.job_id where jobs.job_id=?";
  const result = await execute(query, [job_id]);
  return result;
};
module.exports = {
  getAllPropertyByUserID,
  addNewJob,
  addUserState,
  addCategoryDetails,
  deleteOthersEstimate,
  addJobContractor,
  updateStates,
  getEstimateByJobId,
  getWorkProofByJobId,
};
