class projectHandler {
  constructor(project, objective) {
    //this.req = req;

    console.log("project handler loaded");
  }

  async validateProject(req, bundle) {
    const projectData = req.data;

    if (projectData.starDate > projectData.endDate) {
      return req.error(400, bundle.getText("error6"));
    }

    const existingClient = await cds.transaction(req).run(
      SELECT("testService.client").where({
        ID: projectData.client_ID,
      })
    );

    if (!existingClient.length) {
      return req.error(400, bundle.getText("error7"));
    }
  }

  async reCalculateProgress(req, bundle) {}

  async validateObjective(req, bundle) {
    const projectData = req.data;
    const objectivesData = projectData.objective;
    let totalProgress = projectData.progress;

    console.log("projectData: ", projectData);

    if (objectivesData && objectivesData.length > 0) {
      for (const objective of objectivesData) {
        if (objective.status && !objective.completed) {
          totalProgress += objective.progress;
          objective.completed = true;
        } else if (!objective.status && objective.completed) {
          //totalProgress -= objective.progress;
          //objective.completed = false;
        }
      }

      console.log("totalProgress: ", totalProgress);
      totalProgress = Math.max(0, Math.min(100, totalProgress));
      projectData.progress = totalProgress;

      if (projectData.progress === 100) {
        projectData.status_code = "COM";
        return;
      }
    }
  }
}

module.exports = projectHandler;
