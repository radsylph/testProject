const cds = require("@sap/cds");
const workGroup = require("./workGroup/workGroup.cjs");
const employee = require("./employee/employee.cjs");
const project = require("./project/project.cjs");
const objective = require("./objective/objective.cjs");

console.log("Initializing custom handlers");

module.exports = async (srv) => {
  await workGroup(srv);
  await employee(srv);
  //await project(srv);
  await objective(srv);
};
