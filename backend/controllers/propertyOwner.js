const { execute } = require("../dbConnections/executeQuery");
const {
  addNewJob,
  addCategoryDetails,
  addUserState,
  getAllPropertyByUserID,
  getEstimateByJobId,
  getWorkProofByjobId,
} = require("../services/owner");
const addProperty = async (req, res) => {
  const { name, address } = req.body;
  const id = req.user[0].u_id;
  const query =
    "insert into properties (property_name, property_address, owner_id) values (?,?,?);";
  const result = await execute(query, [name, address, id]);
  res.json(result);
};

const getProperty = async (req, res) => {
  const id = req.user[0].u_id;
  const result = await getAllPropertyByUserID(id);
  res.json(result);
};

const addJob = async (req, res) => {
  let owner_id = req.user[0].u_id;
  console.log(req.body);
  console.log(req.files);
  try {
    const job_id = await addNewJob(owner_id, req.body.property_id);
    const createState = await addUserState(job_id, owner_id);
    const result = await addCategoryDetails(req.body, req.files, job_id);
  } catch (err) {
    console.log(err);
  }
};

const showEstimates = async (req, res) => {
  try {
    const result = await getEstimateByJobId(req.query.job_id);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};

const selectEstimate = async (req, res) => {
  const { estimate_id, job_id, contractor_id } = req.body;
  try {
    const result1 = await deleteOthersEstimate(estimate_id, job_id);
    const result2 = await addJobContractor(contractor_id, job_id);
    const result3 = await updateStates(job_id);
  } catch (err) {
    console.log(err);
  }
};
const getWorkProof = async (req, res) => {
  const job_id = req.query.job_id;
  try {
    const result = await getWorkProofByjobId(job_id);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};
const sendMsg = async (req, res) => {};

module.exports = {
  addProperty,
  getProperty,
  addJob,
  showEstimates,
  selectEstimate,
  getWorkProof,
  sendMsg,
};
