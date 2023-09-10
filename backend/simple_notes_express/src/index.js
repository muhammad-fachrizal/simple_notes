require('dotenv').config();
const PORT = 3000;
const express = require('express');
const app = express();

// You can use this code to separate your routes into different files
// which makes it easier to manage your code as it grows.
const noteRoutes = require('./routes/note');
const middlewareLogRequest = require('./middleware/logs');


app.use(middlewareLogRequest);
app.use(express.json());

app.use('/', noteRoutes);
app.get("/json", (req, res) => {
    res.json({ "Choo Choo": "Welcome to your Express app 🚅" });
  });

app.use((req, res, next) => {
    const error = new Error("Not found");
    error.status = 404;
    next(error);
});
  
// error handler middleware
app.use((error, req, res, next) => {
    //console.error(error.message)
    res.status(error.status || 500).send({
        error: {
          status: error.status || 500,
          message: error.message || 'Internal Server Error',
        },
    });
});

app.listen(PORT, () => {
    console.log(`Simple Notes Express is listening on port ${PORT}`);
})