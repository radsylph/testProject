const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
console.log("employee handler loaded");
const emailRegex =
  /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zAZ0-9-]+)*$/;

const validateEmail = (email) => {
  return emailRegex.test(email);
};
module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "testService.employee", async (req) => {
    //console.log("employee struct: ", req.data);
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const employee = req.data;
    const employeeEmail = validateEmail(employee.email);
    console.log(employeeEmail);
    if (employeeEmail === false) {
      return req.error(400, bundle.getText("error1"));
    }

    const existingEmail = await cds.transaction(req).run(
      SELECT("testService.employee").where({
        email: employee.email,
      })
    );
    if (existingEmail.length > 1) {
      return req.error(400, "The email is already in use");
    }
    const employeeSCN = employee.socialSecurityNumber;
    if (employeeSCN !== undefined) {
      const existingSCN = await cds.transaction(req).run(
        SELECT("testService.employee").where({
          socialSecurityNumber: employeeSCN,
        })
      );
      if (existingSCN.Length > 1) {
        return req.error(400, "The social security number is already in use");
      }
    }
  });
};
