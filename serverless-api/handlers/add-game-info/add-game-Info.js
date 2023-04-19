const { uuid } = require('uuidv4');
const models = require("/opt/nodejs/models/PocGameModel");
const utils = require('/opt/nodejs/utils')

exports.handler = async (event, context, callback) => {
  const [err, item] = await utils.to((addGameInfo(event.body)));

  if (err) {
    callback(null, utils.handleErr(err))
  } else {
    const response = {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(item)
    }
    callback(null, response)
  }
};

function addGameInfo(data) {
  const pocGameData = JSON.parse(data)
  
  return models.PocGame.create({
    AccountId: uuid(),
    CreatedAt: Date.now(),
    OriginCountry: pocGameData.OriginCountry,
    GameTitle: pocGameData.GameTitle,
    Score: pocGameData.Score
  })
}

