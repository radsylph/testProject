const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
console.log("employee handler loaded");
const emailRegex =
  /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zAZ0-9-]+)*$/;

const validateEmail = (email) => {
  return emailRegex.test(email);
};

const SCNRegex = /^[0-9]{3}-[0-9]{2}-[0-9]{4}$/;

const validateSCN = (scn) => {
  return SCNRegex.test(scn);
};

module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "testService.employee", async (req) => {
    //console.log("employee struct: ", req.data);
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const employee = req.data;
    const employeeEmail = validateEmail(employee.email);
    const employeeSCN = validateSCN(employee.socialSecurityNumber);
    //console.log(employeeEmail);
    if (employeeEmail === false) {
      return req.error(400, bundle.getText("error1"));
    }
    if (employeeSCN === false) {
      return req.error(400, bundle.getText("error3"));
    }
    const employeeOldInfo = await cds.transaction(req).run(
      SELECT("testService.employee").where({
        ID: employee.ID,
      })
    );
    //console.log(employeeOldInfo[0].email);
    console.log(employee.email);
    console.log(employeeOldInfo[0].email !== employee.email);
    if (employeeOldInfo[0] && employeeOldInfo[0].email !== employee.email) {
      const existingEmail = await cds.transaction(req).run(
        SELECT("testService.employee").where({
          email: employee.email,
        })
      );
      if (existingEmail.length) {
        return req.error(400, bundle.getText("error2"));
      }
    }
    if (
      employeeOldInfo[0] &&
      employeeOldInfo[0].socialSecurityNumber !== employee.socialSecurityNumber
    ) {
      const existingSCN = await cds.transaction(req).run(
        SELECT("testService.employee").where({
          socialSecurityNumber: employee.socialSecurityNumber,
        })
      );
      if (existingSCN.length) {
        return req.error(400, bundle.getText("error4"));
      }
    }
  });
};
