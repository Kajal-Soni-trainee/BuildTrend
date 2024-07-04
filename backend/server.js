const express = require("express");
const cookie = require("cookie-parser");
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookie());
require("dotenv").config();
const port = process.env.PORT;
const userRoute = require("./routes/user");
const ownerRoute = require("./routes/owner");
const contractorRoute = require("./routes/contractor");
const cors = require("cors");
app.use(cors());
app.use("/", userRoute);
app.use("/", ownerRoute);
app.use("/", contractorRoute);
app.listen(port, () => {
  console.log("server is listening at port " + port);
});
