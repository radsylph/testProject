const cds = require("@sap/cds");
const workGroup = require("./workGroup/workGroup.cjs");

console.log("Initializing custom handlers");

module.exports = async (srv) => {
  await workGroup(srv);
};
