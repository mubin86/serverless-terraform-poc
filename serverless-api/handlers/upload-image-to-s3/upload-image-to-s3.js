const AWS = require('aws-sdk');
const parseMultipart = require('parse-multipart');
const utils = require('/opt/nodejs/utils')
const BUCKET = "poc-bucket-m86";
const s3 = new AWS.S3();

exports.handler = async (event, context, callback) => {
  try {
    const { filename, data } = extractFile(event)
    await s3.putObject({ Bucket: BUCKET, Key: filename, ACL: 'public-read', Body: data }).promise();
 
    const response = {
      statusCode: 200,
      body: JSON.stringify({ link: `https://${BUCKET}.s3.amazonaws.com/${filename}` })
    }
    callback(null, response);
  } catch (err) {
    callback(null, utils.handleErr(err));
  }
}
 
function extractFile(event) {
  console.log("event is ", event);
  const boundary = parseMultipart.getBoundary(event.headers['content-type'])
  const parts = parseMultipart.Parse(Buffer.from(event.body, 'base64'), boundary);
  const [{ filename, data }] = parts
 
  return {
    filename,
    data
  }
}