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
  sendMsg,
  deleteProperty,
  editProperty,
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
route.get("/showEstimates", showEstimates);
route.post("/selectEstimate", selectEstimate);
route.post("/getWorkProof", getWorkProof);
route.post("/sendMsg", sendMsg);
module.exports = route;
