const { execute } = require("../dbConnections/executeQuery");
const { createEstimate, insertWorkProof } = require("../services/contractor");
const addEstimate = async (req, res) => {
  const contractor_id = req.user[0].u_id;
  try {
    const result = await createEstimate(req.body, contractor_id);
  } catch (err) {
    console.log(err);
  }
};
const addWorkProof = async (req, res) => {
  const { description, job_category_id, job_id } = req.body;
  const result = await insertWorkProof(req.body, req.file);
  res.json(result);
};
const sendMsg = async (req, res) => {
  const { sender_id, receiver_id, message } = req.body;
  const query =
    "insert into messages (sender_id,receiver_id,message) values (?,?,?);";
  const result = await execute(query, [sender_id, receiver_id, message]);
  return result;
};
module.exports = { addEstimate, addWorkProof, sendMsg };
