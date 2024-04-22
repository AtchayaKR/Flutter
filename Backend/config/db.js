const mongoose = require("mongoose");

//connect to mongodb
const connection = mongoose.createConnection('mongodb://localhost:27017/assessment').on('open', () => {
    console.log('MONGODB connected');
}).on('error', () => {
    console.log('mongodb not connected');
});

module.exports = connection;
