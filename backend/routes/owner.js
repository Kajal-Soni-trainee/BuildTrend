const express = require("express");
const route = require("express").Router();
route.use(express.static("public"));
const passport = require("passport");
require("../middlewares/passport");
const multer = require("multer");
const storage = require("../middlewares/multer.js");
const upload = multer({ storage: storage });
const {
  addProperty,
  getProperty,
  addJob,
  showEstimates,
  selectEstimate,
  getWorkProof,
  getMessages,
  deleteProperty,
  editProperty,
  getPropertyById,
  deleteEstimate,
  getAllMessages,
  addComment,
  jobDoneAccepted,
  jobDoneRejected,
  getJobByPropId,
  getDistinctSenders,
  makePayment,
  paymentSuccess,
  paymentFail,
} = require("../controllers/propertyOwner");
route.post(
  "/addProperty",
  passport.authenticate("jwt", { session: false }),
  addProperty
);
route.get(
  "/getProperty",
  passport.authenticate("jwt", { session: false }),
  getProperty
);
route.post(
  "/editProperty",
  passport.authenticate("jwt", { session: false }),
  editProperty
);
route.get(
  "/deleteProperty",
  passport.authenticate("jwt", { session: false }),
  deleteProperty
);
route.post(
  "/addJob",
  upload.array("files"),
  passport.authenticate("jwt", { session: false }),
  addJob
);
route.get(
  "/getPropertyById",
  passport.authenticate("jwt", { session: false }),
  getPropertyById
);
route.get(
  "/showEstimates",
  passport.authenticate("jwt", { session: false }),
  showEstimates
);
route.get(
  "/deleteEstimate",
  passport.authenticate("jwt", { session: false }),
  deleteEstimate
);
route.post(
  "/selectEstimate",
  passport.authenticate("jwt", { session: false }),
  selectEstimate
);
route.get(
  "/getMessageOwner",
  passport.authenticate("jwt", { session: false }),
  getMessages
);
route.get(
  "/getAllMsgs",
  passport.authenticate("jwt", { session: false }),
  getAllMessages
);
route.get(
  "/getWorkProof",
  passport.authenticate("jwt", { session: false }),
  getWorkProof
);
route.post(
  "/addComment",
  passport.authenticate("jwt", { session: false }),
  addComment
);
route.post(
  "/jobDoneAccepted",
  passport.authenticate("jwt", { session: false }),
  jobDoneAccepted
);

route.post(
  "/jobDoneRejected",
  passport.authenticate("jwt", { session: false }),
  jobDoneRejected
);
route.get(
  "/getJobByPropId",
  passport.authenticate("jwt", { session: false }),
  getJobByPropId
);
route.get(
  "/getDistinctSender",
  passport.authenticate("jwt", { session: false }),
  getDistinctSenders
);
route.post(
  "/makePayment",
  passport.authenticate("jwt", { session: false }),
  makePayment
);
route.post(
  "/paymentSuccess",
  passport.authenticate("jwt", { session: false }),
  paymentSuccess
);
route.post(
  "/paymentFail",
  passport.authenticate("jwt", { session: false }),
  paymentFail
);
module.exports = route;
