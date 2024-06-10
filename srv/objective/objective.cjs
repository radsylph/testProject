const cds = require("@sap/cds");
const textBundle = require("../../helpers/textBundle");
const { text } = require("express");
console.log("objective handler loaded");

module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "testService.objective", async (req) => {
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const objective = req.data;
    console.log("objective struct: ", objective);
  });
};
