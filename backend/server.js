const express = require("express");
const cookie = require("cookie-parser");
const app = express();
const http = require("http");
const server = http.createServer(app);
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookie());
app.use(express.static("public"));
require("dotenv").config();
const port = process.env.PORT;
const userRoute = require("./routes/user");
const ownerRoute = require("./routes/owner");
const contractorRoute = require("./routes/contractor");
const archiveRoute = require("./routes/archiveJobs");
const cors = require("cors");
var allowCrossDomain = function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "http://localhost:8080");
  res.header("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  res.header("Access-Control-Allow-Credentials", "true");
  next();
};
app.use(allowCrossDomain);
app.use("/", userRoute);
app.use("/", ownerRoute);
app.use("/", contractorRoute);
app.use("/", archiveRoute);
const io = require("socket.io")(server, {
  cors: {
    origin: "*",
  },
});
io.on("connection", (socket) => {
  socket.on("sentMsg", (msg) => {
    console.log("sent message");
    io.emit("receiveMsg", msg);
  });
});
server.listen(port, () => {
  console.log("server is listening at port " + port);
});
