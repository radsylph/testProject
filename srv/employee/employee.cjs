const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
const employeeHandler = require("./employeeHandler.cjs");

console.log("employee handler loaded");


module.exports = (srv) => {
  const handler = new employeeHandler();
  srv.before(["CREATE", "UPDATE"], "testService.employee", async (req) => {
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.validateEmployee(req, bundle);
  });
};
