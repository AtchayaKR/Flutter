const UserServices = require('../Services/user.servvices');

exports.register = async (req, res, next) => {
    try {
        const { email, passWord } = req.body;

        const successRes = await UserServices.registerUser(email, passWord);

        res.json({ status: true, success: "User Registered Successfully" });

    }  catch (err) {
        throw err;
    }
}