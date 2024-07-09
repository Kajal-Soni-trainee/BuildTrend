const express = require("express");
const route = express.Router();
const {
  registerUser,
  loginUser,
  forgetPassword,
  logout,
} = require("../controllers/user.js");
route.post("/register", registerUser);
route.post("/login", loginUser);
route.post("/forgetPass", forgetPassword);
route.get("/logout", logout);
module.exports = route;
