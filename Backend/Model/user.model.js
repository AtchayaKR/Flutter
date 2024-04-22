const mongoose = require('mongoose');
const db = require('../Config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true
    },
    passWord: {
        type: String,
        required: true,
    }
})

const userModel = db.model('user', userSchema);

module.exports = userModel;