const cds = require("@sap/cds");

console.log("workGroup handler loaded"); // Añade este log

module.exports = (srv) => {
  srv.before("READ", "testService.workGroup", async (req) => {
    // Asegúrate de que la entidad es 'workGroup' y no 'workGroup.draft'
    console.log("Read event triggered for workGroup");
    //console.log(req);
    //return cds.transaction(req).run(req.query);
  });

  srv.before("CREATE", "testService.workGroup.drafts", async (req) => {
    console.log("cosas al crear");
  });

  srv.before(["CREATE", "UPDATE"], "testService.workGroup", async (req) => {
    const employeeIds = new Set();
    const projectIds = new Set();
    const promise1 = req.data.employee.map(async (employee) => {
      if (employee.employee_ID !== undefined) {
        console.log(employee.employee_ID);
        const ExistingEmployee = await cds.transaction(req).run(
          SELECT.from("testService.employee").where({
            ID: employee.employee_ID,
          })
        );

        if (!ExistingEmployee.length) {
          req.error(400, "el empleado no ha sido encontrado");
          return;
        }

        if (employeeIds.has(employee.employee_ID)) {
          req.error(400, "el empleado ya esta en el grupo");
          return;
        }

        employeeIds.add(employee.employee_ID);
      } else {
        req.error(400, "Undefined");
      }
    });
    const promise2 = req.data.project.map(async (project) => {
      if (project.project_ID !== undefined) {
        const ExistingProject = await cds.transaction(req).run(
          SELECT.from("testService.project").where({
            ID: project.project_ID,
          })
        );

        if (!ExistingProject.length) {
          req.error(400, "el proyecto no ha sido encontrado");
          return;
        }

        projectIds.add(project.project_ID);

        if (projectIds.has(project.project_ID)) {
          req.error(400, "el proyecto ya esta en el grupo");
          return;
        }
      } else {
        req.error(400, "Undefined");
      }
    });
    await Promise.all([promise1, promise2]);
  });

  srv.after(["CREATE", "UPDATE"], "testService.workGroup", async (req) => {
    console.log("after create event triggered for workGroup");
    
  });
};
