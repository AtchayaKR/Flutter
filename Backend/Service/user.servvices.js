const userModel = require('../Models/user.model');

class UserServices {
    static async registerUser(email, passWord) {
        try {
            const createUser = new userModel({ email, passWord});
            return await createUser.save();
        } catch (err) {
            throw err;
        }
    }
}

module.exports = UserServices;