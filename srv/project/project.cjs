const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
const projectHandler = require("./projectHandler");

console.log("project handler loaded");

module.exports = (srv) => {
  const { project, objective } = srv.entities;
  const handler = new projectHandler(project, objective);
  srv.before(["UPDATE", "CREATE"], project, async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.validateProject(req, bundle);
  });
};
