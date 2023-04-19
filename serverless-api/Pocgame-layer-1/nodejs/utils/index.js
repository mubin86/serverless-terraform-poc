exports.to = promise =>
  promise
    .then(data => [null, data])
    .catch(err => [err])

exports.handleErr = (error, statusCode = 500) => {
  console.error(' => ERROR:', error.stack)

  return {
    statusCode,
    headers: {
    //   'Access-Control-Allow-Origin': '*', // Required for CORS support to work in LAMBDA-PROXY integration
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ error })
  }
}