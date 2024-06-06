const { get } = require("@sap/cds");
const TextBundle = require("@sap/textbundle");

const getTextBundle = (locale) => {
  const bundle = new TextBundle("../srv/i18n");
  return bundle;
};

module.exports = {
  getTextBundle,
};
