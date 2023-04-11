exports.handler = (event, context, cb) => {
    const p = new Promise((resolve) => {
      resolve('success');
    });

    const message = 'Hello people, terraform poc game add lamda handler';
    const response = {
      statusCode: 200,
      body: JSON.stringify(message),
      headers: {'Content-Type': 'application/json'}
    };
    p.then(() => cb(null, response)).catch((e) => cb(e));
  };
  