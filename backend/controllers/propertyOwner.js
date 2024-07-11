const { execute } = require("../dbConnections/executeQuery");
const {
  addNewJob,
  addCategoryDetails,
  addUserState,
  getAllPropertyByUserID,
  getEstimateByJobId,
  deleteOthersEstimate,
  addJobContractor,
  updateStates,
  getWorkProofByJobId,
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
  console.log(id);
  const result = await getAllPropertyByUserID(id);
  console.log(result);
  res.json(result);
};

const addJob = async (req, res) => {
  const owner_id = req.user[0].u_id;
  console.log(req.body);
  console.log(req.files);
  try {
    const job_id = await addNewJob(owner_id, req.body.property_id);
    const createState = await addUserState(job_id, owner_id);
    const result = await addCategoryDetails(req.body, req.files, job_id);
    res.json(true);
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
  const owner_id = req.user[0].u_id;
  const { estimate_id, job_id, contractor_id } = req.body;
  try {
    const result1 = await deleteOthersEstimate(estimate_id, job_id);
    const result2 = await addJobContractor(contractor_id, job_id);
    const result3 = await updateStates(contractor_id, owner_id, job_id);
  } catch (err) {
    console.log(err);
  }
};
const getWorkProof = async (req, res) => {
  const job_id = req.query.job_id;
  try {
    const [result1, result2, result3, conState, ownerState] =
      await getWorkProofByJobId(job_id);
    res.json({
      result1: result1,
      result2: result2,
      result3: result3,
      conState: conState,
      ownerState: ownerState,
    });
  } catch (err) {
    console.log(err);
  }
};
const sendMsg = async (req, res) => {
  const { sender_id, receiver_id, message } = req.body;
  const query =
    "insert into messages (sender_id,receiver_id,message) values (?,?,?);";
  const result = await execute(query, [sender_id, receiver_id, message]);
  return result;
};

const editProperty = async (req, res) => {
  const { id, name, address } = req.body;
  const query =
    "update properties set property_name=?, property_address=? where property_id=?;";
  const result = await execute(query, [name, address, id]);
  res.json(result);
};
const deleteProperty = async (req, res) => {
  const id = req.query.id;
  const query = "delete from properties where property_id=?;";
  const result = await execute(query, [id]);
  res.json(result);
};
const getPropertyById = async (req, res) => {
  const property_id = req.query.id;
  const query = "select * from properties where property_id=? and isDeleted=0;";
  const result = await execute(query, [property_id]);
  res.json(result);
};
const deleteEstimate = async (req, res) => {
  const query =
    "update estimates set isDeleted=1, deleted_at=current_timestamp() where estimate_id=?;";
  const result = await execute(query, [req.query.id]);
  res.json(result);
};
const getMessages = async (req, res) => {
  const owner_id = req.user[0].u_id;
  const job_id = req.query.job_id;
  console.log("owner_id " + owner_id);
  console.log("job_id " + job_id);
  const query =
    "with lastMsg as (select sender_id, max(created_at) as created_at from messages where receiver_id=? and job_id=? group by sender_id) select * from users inner join (select lastMsg.sender_id, lastMsg.created_at, message_id, message from lastMsg inner join messages on messages.sender_id=lastMsg.sender_id and messages.created_at=lastMsg.created_at inner join users on users.u_id=lastMsg.sender_id) as a on a.sender_id=users.u_id ;";
  const result = await execute(query, [owner_id, job_id]);

  res.json(result);
};

const getAllMessages = async (req, res) => {
  const { job_id, sender_id, receiver_id } = req.query;
  const query =
    "select * from messages where job_id=? and sender_id in (?,?) and receiver_id in(?,?) and isDeleted=0;";
  const result = await execute(query, [
    job_id,
    sender_id,
    receiver_id,
    sender_id,
    receiver_id,
  ]);

  res.json(result);
};

const addComment = async (req, res) => {
  const { work_proof_id, comment, work_image_id } = req.body;
  const query =
    "insert into comments (comment, work_proof_id, work_image_id) values (?,?,?);";
  const result = await execute(query, [comment, work_proof_id, work_image_id]);
  res.json(result);
};
const jobDoneAccepted = async (req, res) => {
  const job_id = req.body.job_id;
  const query =
    "update owner_state set state=2 where job_id=? and isDeleted=0;";
  const result = await execute(query, [job_id]);
  res.json(result);
};
const jobDoneRejected = async (req, res) => {
  const job_id = req.body.job_id;
  const query =
    "update contractor_state set state=1 where job_id=? and isDeleted=0 ";
  const result = await execute(query, [job_id]);
  res.json(result);
};
const getJobByPropId = async (req, res) => {
  const job_id = req.query.property_id;
  const query = "select * from jobs where property_id=? and isDeleted=0";
  const result = await execute(query, [job_id]);
  console.log(result);
  res.json(result);
};

const getDistinctSenders = async (req, res) => {
  const job_id = req.query.job_id;
  const owner_id = req.user[0].u_id;
  const query =
    "select distinct sender_id, u_name, job_id from  messages inner join users on users.u_id=messages.sender_id where receiver_id=? and job_id=?;";
};
module.exports = {
  addProperty,
  getProperty,
  addJob,
  showEstimates,
  selectEstimate,
  getWorkProof,
  sendMsg,
  deleteProperty,
  editProperty,
  getPropertyById,
  deleteEstimate,
  getMessages,
  getAllMessages,
  addComment,
  jobDoneAccepted,
  jobDoneRejected,
  getJobByPropId,
  getDistinctSenders,
};
