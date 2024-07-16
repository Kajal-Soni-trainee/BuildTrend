const express = require("express");
const route = express.Router();
route.use(express.static("public"));
const passport = require("passport");
require("../middlewares/passport");
const multer = require("multer");
const storage = require("../middlewares/multer.js");
const upload = multer({ storage: storage });
const {
  registerUser,
  loginUser,
  forgetPassword,
  logout,
  getUserDetails,
  addImg,
  updateUser,
} = require("../controllers/user.js");
route.post("/register", registerUser);
route.post("/login", loginUser);
route.post("/forgetPass", forgetPassword);
route.get("/logout", logout);
route.get(
  "/getUserDetails",
  passport.authenticate("jwt", { session: false }),
  getUserDetails
);
route.post(
  "/addImg",
  passport.authenticate("jwt", { session: false }),
  upload.single("image"),
  addImg
);
route.post(
  "/updateUser",
  passport.authenticate("jwt", { session: false }),
  updateUser
);
module.exports = route;
