const express = require("express");
const route = require("express").Router();
route.use(express.static("public"));
const passport = require("passport");
require("../middlewares/passport");
const multer = require("multer");
const storage = require("../middlewares/multer.js");
const upload = multer({ storage: storage });
const {
  addEstimate,
  addWorkProof,
  sendMsg,
  showJobs,
  showTask,
  getContacts,
  getMessages,
  getCategories,
  getAllWorkProofs,
  taskCompletedReq,
  selectedJobs,
  unSelectedJobs,
} = require("../controllers/contractor");
route.post(
  "/addEstimate",
  passport.authenticate("jwt", { session: false }),
  addEstimate
);
route.post(
  "/addWorkProof",
  upload.array("files"),
  passport.authenticate("jwt", { session: false }),
  addWorkProof
);
route.post(
  "/sendMsgByCon",
  passport.authenticate("jwt", { session: false }),
  sendMsg
);
route.get(
  "/showJobs",
  passport.authenticate("jwt", { session: false }),
  showJobs
);
route.get(
  "/showTask",
  passport.authenticate("jwt", { session: false }),
  showTask
);
route.get(
  "/getContacts",
  passport.authenticate("jwt", { session: false }),
  getContacts
);
route.get(
  "/getMessages",
  passport.authenticate("jwt", { session: false }),
  getMessages
);
route.get(
  "/getCategories",
  passport.authenticate("jwt", { session: false }),
  getCategories
);
route.get(
  "/getAllWorkProofs",
  passport.authenticate("jwt", { session: false }),
  getAllWorkProofs
);
route.post(
  "/workCompletedReq",
  passport.authenticate("jwt", { session: false }),
  taskCompletedReq
);
route.get(
  "/selectedJobs",
  passport.authenticate("jwt", { session: false }),
  selectedJobs
);
route.get(
  "/unSelectedJobs",
  passport.authenticate("jwt", { session: false }),
  unSelectedJobs
);
module.exports = route;
