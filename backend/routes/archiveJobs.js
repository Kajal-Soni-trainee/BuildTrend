const express = require("express");
const route = express.Router();
route.use(express.static("public"));
const passport = require("passport");
require("../middlewares/passport");
const {
  getArchiveJobsOwner,
  getArchiveJobsContractor,
  getTaskByJobId,
  getProofByJobId,
} = require("../controllers/archiveJobs");
route.get(
  "/getArchiveJobsOwner",
  passport.authenticate("jwt", { session: false }),
  getArchiveJobsOwner
);
route.get(
  "/getArchiveJobsContractor",
  passport.authenticate("jwt", { session: false }),
  getArchiveJobsContractor
);
route.get(
  "/getTask",
  passport.authenticate("jwt", { session: false }),
  getTaskByJobId
);
route.get(
  "/getProof",
  passport.authenticate("jwt", { session: false }),
  getProofByJobId
);
module.exports = route;
