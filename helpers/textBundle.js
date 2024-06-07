const { get } = require("@sap/cds");
const TextBundle = require("@sap/textbundle").TextBundle;

const getTextBundle = (locale) => {
  const bundle = new TextBundle("../srv/i18n/i18n");
  return bundle;
};

module.exports = {
  getTextBundle,
};
