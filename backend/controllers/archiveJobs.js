const { execute } = require("../dbConnections/executeQuery");
const {
  getAllTaskDetails,
  getAllProofDetails,
} = require("../services/archiveJobs");
const getArchiveJobsOwner = async (req, res) => {
  const owner_id = req.user[0].u_id;
  try {
    const query =
      "select * from estimates inner join (select * from users inner join (select job_id, jobs.property_id, property_name, property_address , jobs.owner_id, contractor_id from jobs  inner join properties on jobs.property_id=properties.property_id where jobs.owner_id=? and jobs.isDeleted=1) as a on a.owner_id=users.u_id) as b on b.job_id=estimates.job_id where estimates.contractor_id=b.contractor_id;";
    const result = await execute(query, [owner_id]);
    console.log("sdfsdgdfgdfg", result);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};

const getArchiveJobsContractor = async (req, res) => {
  const contractor_id = req.user[0].u_id;
  try {
    const query =
      "select * from estimates inner join (select * from users inner join (select job_id, jobs.property_id, property_name, property_address , jobs.owner_id, contractor_id from jobs  inner join properties on jobs.property_id=properties.property_id where jobs.contractor_id=? and jobs.isDeleted=1) as a on a.owner_id=users.u_id) as b on b.job_id=estimates.job_id where estimates.contractor_id=b.contractor_id;";
    const result = await execute(query, contractor_id);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};
const getTaskByJobId = async (req, res) => {
  const job_id = req.query.job_id;
  console.log(job_id);
  try {
    const result = await getAllTaskDetails(job_id);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};

const getProofByJobId = async (req, res) => {
  const job_id = req.query.job_id;
  console.log(job_id);
  try {
    const result = await getAllProofDetails(job_id);
    console.log(result);
    res.json(result);
  } catch (err) {
    console.log(err);
  }
};
module.exports = {
  getArchiveJobsOwner,
  getArchiveJobsContractor,
  getTaskByJobId,
  getProofByJobId,
};
