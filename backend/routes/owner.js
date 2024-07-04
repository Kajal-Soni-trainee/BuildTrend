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
} = require("../controllers/propertyOwner");
route.post(
  "/addProperty",
  passport.authenticate("jwt", { session: false }),
  addProperty
);
route.get(
  "/getProperty",
  passport.authenticate("jwt", { session: false }),
  upload.array("images"),
  getProperty
);
route.post("/addJob", upload.array("files"), addJob);
route.get("/showEstimates", showEstimates);
route.post("/selectEstimate", selectEstimate);
route.post("/getWorkProof", getWorkProof);
route.post("/sendMsg", sendMsg);
module.exports = route;
