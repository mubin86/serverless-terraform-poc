const models = require("/opt/nodejs/models/PocGameModel");
const utils = require('/opt/nodejs/utils')
const dynamoose = require("dynamoose");

exports.handler = async (event, context, callback) => {
  const pathParams = event.pathParameters;
  try {
    const item = await models.PocGame.scan({GameTitle: { eq: pathParams.gameTitle }})
                                    .using('GameTitleIndex').where('OriginCountry')
                                    .eq(pathParams.originCountry).exec();

    // const filter = new dynamoose.Condition().where("GameTitle").eq(pathParams.gameTitle).and().where("OriginCountry").eq(pathParams.originCountry);
    // const item = await models.PocGame.query(filter).using('GameTitleIndex').exec();
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
  