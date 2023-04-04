export const gameHandler = (event, context, cb) => {
    const p = new Promise((resolve) => {
      resolve('success');
    });
    const response = {
      statusCode: 200,
      body: JSON.stringify(
        {
          message: 'Hello people',
        },
        null,
        2
      ),
    };
    p.then(() => cb(null, response)).catch((e) => cb(e));
  };
  