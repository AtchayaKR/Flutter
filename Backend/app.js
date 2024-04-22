const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./Routes/user.route');
const app = express();

app.use(bodyParser.json());

app.use('/', userRouter);

module.exports = app;