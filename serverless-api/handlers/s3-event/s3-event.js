const models = require("/opt/nodejs/models/PocGameModel");
const utils = require('/opt/nodejs/utils')
const dynamoose = require("dynamoose");

exports.handler = async (event, context, callback) => {
  try {
    console.log("s3 triggered event is ", event);
    const response = {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(event)
    }
    callback(null, response);
  } catch (error) {
    callback(null, utils.handleErr(error));
  }
  
  };
  