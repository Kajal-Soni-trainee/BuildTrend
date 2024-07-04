const { execute } = require("../dbConnections/executeQuery");

const findByEmail = async (email) => {
  const query = "select * from users where u_email=?";
  try {
    const result = await execute(query, [email]);
    return result;
  } catch (err) {
    console.log(err);
  }
};

module.exports = { findByEmail };
