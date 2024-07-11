const express = require("express");
const cookie = require("cookie-parser");
const app = express();
const http = require("http");
const server = http.createServer(app);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookie());
app.use(express.static("public"));
require("dotenv").config();
const port = process.env.PORT;
const userRoute = require("./routes/user");
const ownerRoute = require("./routes/owner");
const contractorRoute = require("./routes/contractor");
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
const io = require("socket.io")(server, {
  cors: {
    origin: "http://localhost:8080",
    credentials: true,
    methods: ["GET", "POST"],
    transports: ["websocket", "polling"],
  },
  allowEIO4: true,
});
io.on("connection", (socket) => {
  console.log("socket listening");
  socket.on("sentMsgOwner", (msg) => {
    console.log("owner sent message", msg);
    io.emit("receiveMsgOwner", msg);
  });
  socket.on("sentMsgContractor", (msg) => {
    console.log("contractor sent message ", msg);
    io.emit("receiveMsgContractor", msg);
  });
});
server.listen(port, () => {
  console.log("server is listening at port " + port);
});
