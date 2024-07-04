const mysql = require("mysql2");
const conn = require("./connection");
async function execute(query, values) {
  conn.connect(function (err) {
    if (err) throw err;
  });

  let res = new Promise((resolve, reject) => {
    conn.query(query, values, (err, result) => {
      if (err) {
        console.log(err);
        reject(err);
      } else {
        resolve(result);
      }
    });
  });
  let result = res
    .then((result) => {
      return result;
    })
    .catch((err) => {
      console.log(err);
      return err;
    });
  return result;
}

module.exports = { execute };
