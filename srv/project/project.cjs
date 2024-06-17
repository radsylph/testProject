const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
const projectHandler = require("./projectHandler");

console.log("project handler loaded");

module.exports = (srv) => {
  const { project, objective } = srv.entities;
  const handler = new projectHandler(project, objective);

  srv.before("UPDATE", project, async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.validateObjective(req, bundle);
  });

  srv.before("CREATE", project, async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.validateProject(req, bundle);
  });

  srv.before("DELETE", objective, async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    await handler.reCalculateProgress(req, bundle);
  });
  srv.after("CREATE", project, async (req) => {
    const locale = req.locale;
    const bundle = textBundle.getTextBundle(locale);
    console.log(req.data);
  });
};
