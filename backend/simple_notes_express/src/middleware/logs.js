// Middleware is a function that runs on every request that is sent to your app.
// It can be used to modify the request or response objects, or to run some code
// generally middleware is used for things like authentication,
// logging, or parsing the request body
//
// the example shown below will be for logging, and it is run on every request
const logRequest = (req, res, next) => {
    const start = Date.now();
    res.on("finish", () => {
      const responseTime = Date.now() - start;
      const contentLength = res.get("Content-Length");
      console.log({
        method: req.method,
        url: req.originalUrl,
        query: req.query,
        responseTime: `${responseTime} ms`,
        contentLength: `${contentLength} bytes`,
        status: res.statusCode,
      });
    });
    // the next function is a callback that tells express to move on to the next middleware or route handler
    next();
}

module.exports = logRequest;
