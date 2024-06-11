class projectHandler {
  constructor(project, objective) {
    //this.req = req;

    console.log("project handler loaded");
  }

  async validateProject(req, bundle) {
    const projectData = req.data;
    const objectivesData = projectData.objective;
    let totalProgress = projectData.progress;

    if (objectivesData !== undefined && objectivesData.length > 0) {
      for (const objective of objectivesData) {
        if (objective.status) {
          if (!objective.completed) {
            objective.completed = true;
            totalProgress += objective.progress;
          } else {
            totalProgress = Math.max(0, totalProgress - objective.progress);
            objective.completed = false;
          }
        }
      } //revisar esto despues
      totalProgress = Math.min(totalProgress, 100);
      console.log("totalProgress: ", totalProgress);
      projectData.progress = totalProgress;
    }
  }

  async validateObjective(req, project, totalProgress) {
    try {
      console.log("Selected project: ", project);
      const updatedProjectProgress = await cds
        .transaction(req)
        .run(
          UPDATE("testService_project")
            .set({ progress: totalProgress })
            .where({ ID: project.ID })
        );
      console.log("updatedProjectProgress: ", updatedProjectProgress);
      return updatedProjectProgress;
    } catch (error) {
      console.error("Error updating project progress: ", error);
      throw error;
    }
  }
}

module.exports = projectHandler;
