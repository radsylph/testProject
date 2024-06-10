//const textBundle = require("../../helpers/textBundle");

class projectHandler {
  constructor() {
    console.log("project handler loaded");
  }

  async validateProject(req, bundle) {
    const project = req.data;
    console.log("project struct: desde el handler", project);
    
  }
}

module.exports = projectHandler;
