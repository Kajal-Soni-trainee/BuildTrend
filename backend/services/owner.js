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
  console.log(job_id);
  const query =
    "insert into owner_state (owner_id, job_id, state) values (?,?,0);";
  try {
    const result = await execute(query, [owner_id, job_id]);
  } catch (err) {
    console.log(err);
  }
};
const addCategoryDetails = async (dataObj, files, job_id) => {
  const { property_id, id, title, description } = dataObj;
  console.log("id", id);
  console.log("title ", title);
  console.log("description", description);
  try {
    for (let i = 0; i < id.length; i++) {
      const query =
        "insert into jobs_categories (job_id, title,description) values (?,?,?);";
      const result = await execute(query, [job_id, title[i], description[i]]);
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
  const query =
    "select * from jobs inner join (select users.u_name, users.u_email, estimates.estimate_id, estimates.cost,estimates.contractor_id as con_id, estimates.job_id from users inner join estimates on users.u_id=estimates.contractor_id where estimates.isDeleted=0 and job_id=?) as a on a.job_id=jobs.job_id;";
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
  const query =
    "update jobs set contractor_id=? where job_id=? and isDeleted=0;";
  try {
    const result = await execute(query, [contractor_id, job_id]);
    return result;
  } catch (err) {
    console.log(err);
  }
};
const updateStates = async (contractor_id, owner_id, job_id) => {
  try {
    const jobQuery = "select * from jobs where job_id =?;";
    const jobResult = await execute(jobQuery, [job_id]);
    const ownerStateQuery =
      "update owner_state set state = 1 where job_id=? and owner_id=? and isDeleted=0;";
    const ownerStateResult = await execute(ownerStateQuery, [job_id, owner_id]);
    const contractorStateQuery =
      "update contractor_state set state=1 where job_id=? and contractor_id=? and isDeleted=0;";
    const cotractorStateResult = await execute(contractorStateQuery, [
      job_id,
      contractor_id,
    ]);

    const deleteOtherContractorState =
      "update contractor_state set isDeleted=1 , deleted_at=current_timestamp() where contractor_id<>? and job_id=?;";
    const deleteResult = await execute(deleteOtherContractorState, [
      contractor_id,
      job_id,
    ]);
    return true;
  } catch (err) {
    console.log(err);
  }
};
const getWorkProofByJobId = async (job_id) => {
  const query1 =
    "select * from jobs inner join (select work_proofs.job_id, jobs_categories.title, work_proofs.work_proof_id, work_proofs.job_category_id, work_proofs.description from work_proofs inner join jobs_categories on work_proofs.job_category_id=jobs_categories.job_category_id where work_proofs.job_id=?) as a on a.job_id=jobs.job_id; ";
  const result1 = await execute(query1, [job_id]);
  const query2 = "select * from work_proof_images where isDeleted=0;";
  const result2 = await execute(query2);
  const query3 = "select * from comments where isDeleted=0;";
  const result3 = await execute(query3);
  const query4 =
    "select state from contractor_state where job_id=? and isDeleted=0;";
  const result4 = await execute(query4, [job_id]);
  const query5 =
    "select state from owner_state where job_id=? and isDeleted=0;";
  const result5 = await execute(query5, [job_id]);
  return [result1, result2, result3, result4[0].state, result5[0].state];
};

const getEstimatedCost = async (job_id) => {
  try {
    const query =
      "select cost from estimates inner join jobs on estimates.job_id=jobs.job_id where estimates.isDeleted=0 and jobs.job_id=? ";
    const result = await execute(query, [job_id]);
    return result[0].cost;
  } catch (err) {
    console.log(err);
  }
};
const paymentEntry = async (session_id, job_id, amount) => {
  const query =
    "insert into payments (job_id,session_id, amount) values (?,?,?)";
  const result = await execute(query, [job_id, session_id, amount]);
  return result;
};
const deleteJobFromEveryWhere = async (job_id) => {
  try {
    const query1 =
      "update jobs set isDeleted=1, deleted_at=current_timestamp() where job_id=?;";
    const result1 = await execute(query1, [job_id]);
    const query2 =
      "update jobs_categories set isDeleted=1, deleted_at=current_timestamp() where job_id=?;";
    const result2 = await execute(query2, [job_id]);
    const query3 =
      "update owner_state set isDeleted=1, deleted_at=current_timestamp() where job_id=?;";
    const result3 = await execute(query3, [job_id]);
    const query4 =
      "update contractor_state set isDeleted=1, deleted_at=current_timestamp() where job_id=?;";
    const result4 = await execute(query4, [job_id]);
    const query5 =
      "update messages set isDeleted=1 , deleted_at=current_timestamp() where job_id=? ;";
    const result5 = await execute(query5, [job_id]);
    const query6 =
      "update work_proofs set deleted_at=current_timestamp(), isDeleted=1 where job_id=?;";
    const result6 = await execute(query6, [job_id]);
    const allWorkProof = "select * from work_proofs where job_id=?;";
    const allProofs = await execute(allWorkProof, [job_id]);
    allProofs.forEach(async (element) => {
      const deleteProofImgQuery =
        "update work_proof_images set isDeleted=1, deleted_at=current_timestamp() where work_proof_id=?; ";
      const deleteProofImg = await execute(
        deleteProofImgQuery,
        element.work_proof_id
      );
    });
    const allImagesQuery = "select * from jobs_categories where job_id=?;";
    const allImgResult = await execute(allImagesQuery, [job_id]);
    allImgResult.forEach(async (element) => {
      const deleteImgQuery =
        "update job_category_images set isDeleted=1 , deleted_at=current_timestamp() where job_category_id=?; ";
      const deleteResult = await execute(
        deleteImgQuery,
        element.job_category_id
      );
    });
    return true;
  } catch (err) {
    console.log(err);
  }
};

const deleteOthersMsg = async (contractor_id, owner_id, job_id) => {
  const query =
    "update messages set isDeleted=1, deleted_at=current_timestamp() where job_id=? and (sender_id <> ? or receiver_id <> ?);";
  const result = await execute(query, job_id, contractor_id, contractor_id);
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
  getEstimatedCost,
  paymentEntry,
  deleteJobFromEveryWhere,
  deleteOthersMsg,
};
