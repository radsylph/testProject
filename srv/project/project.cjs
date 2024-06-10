const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
const projectHandler = require("./projectHandler");

const handler = new projectHandler();

console.log("project handler loaded");

module.exports = (srv) => {
  srv.before(["UPDATE", "CREATE"], "testService.project", async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.validateProject(req, bundle);
    //const bundle = textBundle.getTextBundle(locale);
    // const project = req.data;

    // console.log("project struct: ", project);
  });
};
