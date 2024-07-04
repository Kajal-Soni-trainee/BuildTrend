const express = require("express");
const route = express.Router();
const {
  registerUser,
  loginUser,
  forgetPassword,
} = require("../controllers/user.js");
route.post("/register", registerUser);
route.post("/login", loginUser);
route.post("/forgetPass", forgetPassword);
module.exports = route;
