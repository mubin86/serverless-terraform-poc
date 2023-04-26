const models = require("/opt/nodejs/models/PocGameModel");
const utils = require('/opt/nodejs/utils')
const dynamoose = require("dynamoose");

exports.handler = async (event, context, callback) => {
  const pathParams = event.pathParameters;
  try {
      const d = new Date();
      d.setMonth(d.getMonth() - Number(pathParams.createdBeforeInMonth));

      const item = await models.PocGame.query({"AccountId": {eq: pathParams.accountId}}).where('CreatedAt').ge(d.getTime()).exec();
      const response = {
        statusCode: 200,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(item)
      }
    callback(null, response);
  } catch (error) {
    callback(null, utils.handleErr(error));
  }
  };
  