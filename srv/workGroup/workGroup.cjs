const cds = require("@sap/cds");

console.log("workGroup handler loaded"); // Añade este log

module.exports = (srv) => {
  srv.before("READ", "testService.workGroup", async (req) => {
    // Asegúrate de que la entidad es 'workGroup' y no 'workGroup.draft'
    console.log("Read event triggered for workGroup");
    //return cds.transaction(req).run(req.query);
  });

  // srv.before("CREATE", "testService.workGroup.drafts", async (req) => {
  //   console.log("Before create event triggered for workGroup");
  //   req.error(403, "test no se");
  // });
};
