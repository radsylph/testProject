class projectHandler {
  constructor(project, objective) {
    //this.req = req;

    console.log("project handler loaded");
  }

  async validateProject(req, bundle) {
    const projectData = req.data;
    const objectivesData = projectData.objective;
    let totalProgress = projectData.progress;

    console.log("projectData: ", projectData);

    if (projectData.progress === 100) {
      projectData.status_code = "COM";
      return;
    }

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
    }
  }

  async validateObjective(req, bundle) {
    const objectiveData = req.data;
    try {
      console.log("objectiveData: ", objectiveData);
      req.error(400, "Error updating project progress");
    } catch (error) {
      console.error("Error updating project progress: ", error);
      throw error;
    }
  }
}

module.exports = projectHandler;
