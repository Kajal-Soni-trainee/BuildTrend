const { execute } = require("../dbConnections/executeQuery");
const {
  createEstimate,
  insertWorkProof,
  showTaskByJobId,
  createState,
} = require("../services/contractor");
const addEstimate = async (req, res) => {
  const contractor_id = req.user[0].u_id;
  console.log(req.body);
  try {
    const result1 = await createEstimate(req.body, contractor_id);
    const result2 = await createState(req.body.job_id, contractor_id);
    res.json(result1);
  } catch (err) {
    console.log(err);
  }
};
const addWorkProof = async (req, res) => {
  const { description, job_category_id, job_id } = req.body;
  const result = await insertWorkProof(req.body, req.files);
  res.json(result);
};
const sendMsg = async (req, res) => {
  const sender_id = req.user[0].u_id;
  console.log(sender_id);
  const { receiver_id, job_id, message } = req.body;
  const query =
    "insert into messages (sender_id,receiver_id, job_id, message) values (?,?,?,?);";
  const result = await execute(query, [
    sender_id,
    receiver_id,
    job_id,
    message,
  ]);
  return result;
};

const showJobs = async (req, res) => {
  const query =
    "select * from users inner join (select job_id, properties.property_id, property_name, property_address, properties.owner_id from jobs inner join properties on jobs.property_id=properties.property_id where jobs.isDeleted=0) as a on users.u_id=a.owner_id; ";
  const result = await execute(query);
  res.json(result);
};
const showTask = async (req, res) => {
  const job_id = req.query.job_id;
  const result = await showTaskByJobId(job_id);
  res.json(result);
};

const getContacts = async (req, res) => {
  const query =
    "select * from messages inner join (select * from users inner join (select jobs.job_id, properties.property_id, properties.owner_id from jobs inner join properties on jobs.property_id=properties.property_id where jobs.isDeleted=0) as a on users.u_id=a.owner_id) as b on messages.job_id=b.job_id order by messages.created_at desc limit 1;";
  const result = await execute(query);
  res.json(result);
};
const getMessages = async (req, res) => {
  const { job_id, owner_id } = req.query;
  const contractor_id = req.user[0].u_id;

  const query =
    "select * from messages where job_id=? and (sender_id=? or sender_id=?) and (receiver_id=? or receiver_id=?) and isDeleted=0 order by message_id; ";
  const result = await execute(query, [
    job_id,
    owner_id,
    contractor_id,
    owner_id,
    contractor_id,
  ]);
  res.json(result);
};

const getCategories = async (req, res) => {
  const query = "select * from jobs_categories where job_id=? and isDeleted=0;";
  const result = await execute(query, [req.query.job_id]);
  res.json(result);
};
module.exports = {
  addEstimate,
  addWorkProof,
  sendMsg,
  showJobs,
  showTask,
  getContacts,
  getMessages,
  getCategories,
};
